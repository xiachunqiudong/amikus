package exu

import chisel3._
import chisel3.util._

class Regfile(DW: Int, AW: Int, rdPortNum: Int, wrPortNum: Int) extends Module {
  val readAddrVec  = IO(Input(Vec(rdPortNum, UInt(AW.W))))
  val readDataVec  = IO(Output(Vec(rdPortNum, UInt(DW.W))))
  val writeEnVec   = IO(Input(Vec(wrPortNum, Bool())))
  val writeAddrVec = IO(Input(Vec(wrPortNum, UInt(AW.W))))
  val writeDataVec = IO(Input(Vec(wrPortNum, UInt(DW.W))))

  val entryNum = 1 << AW

  val dataArray = Seq.fill(entryNum)(Reg(UInt(DW.W)))

  val readAddrDcdVec = Wire(Vec(rdPortNum, UInt(entryNum.W)))

  val writeAddrDcdWvVec = Wire(Vec(wrPortNum, UInt(entryNum.W)))

  val entryWriteDataSelVec = Wire(Vec(entryNum, Vec(wrPortNum, Bool())))
  val entryWriteEn         = Wire(Vec(entryNum, Bool()))
  val entryWriteData       = Wire(Vec(entryNum, UInt(DW.W)))

  for (i <- 0 until rdPortNum) {
    readAddrDcdVec(i) := UIntToOH(readAddrVec(i))
    readDataVec(i)    := Mux1H(readAddrDcdVec(i), dataArray)
  }

  // write
  for (i <- 0 until wrPortNum) {
    writeAddrDcdWvVec(i) := UIntToOH(writeAddrVec(i)) & Fill(entryNum, writeEnVec(i))
  }

  for (i <- 0 until entryNum) {
    for (j <- 0 until wrPortNum) {
      entryWriteDataSelVec(i)(j) := writeAddrDcdWvVec(j)(i)
    }
  }

  for (i <- 0 until entryNum) {
    entryWriteEn(i) := entryWriteDataSelVec(i).asUInt.orR
    entryWriteData(i) := Mux1H(entryWriteDataSelVec(i), writeDataVec)
  }

  for (i <- 0 until entryNum) {
    when(entryWriteEn(i)) {
      dataArray(i) := entryWriteData(i)
    }
  }

}