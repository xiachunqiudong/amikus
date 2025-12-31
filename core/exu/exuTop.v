module exuTop(
  input wire        clk,
  input wire        rst,
  input wire        ifu_instrValid,
  input wire [31:0] ifu_instr
);

  wire [4:0] lsrc1;
  wire [4:0] lsrc2;
  wire [4:0] ldst;

  decoder
  exu_decoder (
    .instr   (ifu_instr[31:0]),
    .lsrc1   (lsrc1[4:0]),
    .lsrc2   (lsrc2[4:0]),
    .ldst    (ldst[4:0]),
    .instrDcd()
  );

  Regfile
  exu_regfile (
    .clock         (clk),
    .reset         (),
    .readAddrVec_0 (lsrc1[4:0]),
    .readAddrVec_1 (lsrc2[4:0]),
    .readDataVec_0 (),
    .readDataVec_1 (),
    .writeEnVec_0  (),
    .writeEnVec_1  (),
    .writeAddrVec_0(),
    .writeAddrVec_1(),
    .writeDataVec_0(),
    .writeDataVec_1()
  );

endmodule