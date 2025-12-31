module amikus_top(
  input wire clk,
  input wire rst
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