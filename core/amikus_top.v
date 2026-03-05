module amikus_top(
  input  wire               clk,
  input  wire               rst,
  output wire               axi_arValid,
  input  wire               axi_arReady,
  output wire [`AXI_AW-1:0] axi_arAddr,
  input  wire               axi_rValid,
  output wire               axi_rReady,
  input  wire [`AXI_DW-1:0] axi_rdata
);

  wire        ifu_instrValid;
  wire [31:0] ifu_instr;

  ifuTop
  ifu(
    .clk(clk),
    .rst(rst),
    .ifu_instrValid(ifu_instrValid),
    .ifu_instr(ifu_instr[31:0])
  );

  exuTop
  exu(
    .clk(clk),
    .rst(rst),
    .ifu_instrValid(ifu_instrValid),
    .ifu_instr(ifu_instr[31:0])
  );

endmodule