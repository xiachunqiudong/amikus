module amikus_top(
  input wire clk,
  input wire rst
);

  ifuTop
  ifu(
    .clk(clk),
    .rst(rst)
  );

endmodule