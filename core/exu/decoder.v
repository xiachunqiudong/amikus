module decoder (
  input  wire [31:0] instr,
  output wire [2:0]  instrDcd,
  output wire [4:0]  lsrc1,
  output wire [4:0]  lsrc2,
  output wire [4:0]  ldst
);

  assign lsrc1[4:0] = instr[19:15];
  assign lsrc2[4:0] = instr[24:20];
  assign ldst[4:0]  = instr[11:7];

  InstrDcdPla
  instrDcdPla(
    .instr   (instr[31:0]),
    .instrDcd(instrDcd[2:0])
  );

endmodule