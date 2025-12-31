module rom #(
  parameter AW = 10,
  parameter DW = 32
) (
  input  wire          clk,
  input  wire [AW-1:0] raddr,
  output wire [DW-1:0] rdata
);

  parameter EntryNum = 1 << DW;

  reg [DW-1:0] dataArray [EntryNum-1:0];

  assign rdata[DW-1:0] = dataArray[raddr[AW-1:0]][DW-1:0];

  initial begin
    if ($value$plusargs("rom_init_path=%s", ram_init_path)) begin
      $display("Init rom from %s", ram_init_path);
      $readmemh(ram_init_path, dataArray);
    end
    else begin
      $display("Can not find rom init path!");
    end
  end

endmodule