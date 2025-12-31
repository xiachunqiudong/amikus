package exu

import chisel3._
import chisel3.util._
import chisel3.util.experimental.decode._

class InstrDcdPla extends Module {
  val instr    = IO(Input(UInt(32.W)))
  val instrDcd = IO(Output(UInt(3.W)))

  instrDcd := decoder(instr, RV32I_InstTable.RV32I_MAP)

}

