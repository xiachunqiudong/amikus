object Elaborate extends App {

  val firtoolOptions = Array(
    "-O=release",
    "--disable-opt",
    "--disable-all-randomization",
    "--split-verilog",
    "-strip-debug-info",
    "-strip-fir-debug-info",
    "--add-mux-pragmas",
    "--emit-separate-always-blocks",
    "--lowering-options=explicitBitcast,disallowLocalVariables,disallowPortDeclSharing,locationInfoStyle=none",
    "--disable-aggressive-merge-connections",
    "--verilog"
  )

  print("hello world!")

  // circt.stage.ChiselStage.emitSystemVerilogFile(new exu.InstrDcdPla(), args, firtoolOptions)

  circt.stage.ChiselStage.emitSystemVerilogFile(new exu.Regfile(DW=64,AW=5,rdPortNum=2,wrPortNum=2), args, firtoolOptions)


}
