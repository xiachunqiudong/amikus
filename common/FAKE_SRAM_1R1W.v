module FAKE_SRAM_1R1W #(
  parameter AW = 10,
  parameter DW = 64
) (
  input  wire          CLK,
  output reg  [DW-1:0] QB,
  input  wire          MEMB,
  input  wire [AW-1:0] ADRB,
  input  wire          MEMA,
  input  wire          WEMA,
  input  wire [AW-1:0] ADRA,
  input  wire [DW-1:0] WEBA,
  input  wire [DW-1:0] DA
);

  parameter SIZE = 1 << DW;

  reg [DW-1:0] mem [SIZE-1:0];

  always @(posedge CLK) begin
    if (MEMB)
      QB[DW-1:0] <= mem[ADRB[AW-1:0]][DW-1:0];
  end

  always @(posedge CLK) begin
    if (WEBA & MEMA)
      mem[ADRA[AW-1:0]][DW-1:0] <= DA[DW-1:0];
  end

endmodule