module exuTop(
  input wire        clk,
  input wire        rst,
  input wire        ifu_instrValid,
  input wire [31:0] ifu_instr
);

  decoder
  exu_decoder(
    .instr   (ifu_instr[31:0]),
    .instrDcd()
  );


endmodule