package vlsu

import chisel3._
import chisel3.util._

class PieceInfo extends Bundle {
  val byteId     = UInt(9.W)
  val nfId       = UInt(3.W)
  val pieceWidth = UInt(3.W)
}

class PieceInfoEntry extends Module {
  val establish      = IO(Input(Bool()))
  val establishEntry = IO(Input(new PieceInfo))

  val pieceInfo_Q = Reg(new PieceInfo)

  when(establish) {
    pieceInfo_Q := establishEntry
  }

}

class PieceInfoTable (maxPieceNum: Int) extends Module {
  val pieceConfirmVec = IO(Input(UInt(maxPieceNum.W)))
  val pieceInfoWen    = IO(Input(Bool()))
  val pieceInfoWaddr  = IO(Input(UInt((log2Ceil(maxPieceNum)).W)))
  val pieceInfoWdata  = IO(Input(new PieceInfo))

  val pieceInfoArray = Seq.fill(maxPieceNum)(Module(new PieceInfoEntry))

  val pieceInfoEstablishVec = Wire(Vec(maxPieceNum, Bool()))

  for (i <- 0 until maxPieceNum) {
    pieceInfoEstablishVec(i) := pieceInfoWen && pieceInfoWaddr === i.U
  }

  for (i <- 0 until maxPieceNum) {
    pieceInfoArray(i).establish      := pieceInfoEstablishVec(i)
    pieceInfoArray(i).establishEntry := pieceInfoWdata
  }

}
