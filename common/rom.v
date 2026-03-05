module rom #(
  parameter AW = 10,
  parameter DW = 32
) (
  input  logic          clk, 
  input  logic          rst, 
  input  logic          arvalid,
  output logic          arready,
  input  logic [AW-1:0] araddr,
  output logic          rValid,
  input  logic          rReady,
  output logic [DW-1:0] rData
);

  parameter EntryNum = 1 << AW;

  typedef enum logic [1:0] {
      IDLE      = 2'b00,
      READ_SRAM = 2'b01,
      READ_DONE = 2'b10
  } state_e;

  state_e state_In;
  state_e state_Q;

  logic [DW-1:0] dataArray [EntryNum-1:0];

//--------------------------------------------------------------------------
//                              State Machine
//--------------------------------------------------------------------------
  always_comb begin
    state_In = state_Q;
    case (state_Q)
      IDLE:      state_In = arvalid ? READ_SRAM : IDLE;
      READ_SRAM: state_In = READ_DONE;
      READ_DONE: state_In = rReady ? IDLE : READ_DONE;
      default:   state_In = IDLE;
    endcase
  end

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      state_Q <= IDLE;
    end
    else begin
      state_Q <= state_In;
    end
  end

//--------------------------------------------------------------------------
//                                  READ
//--------------------------------------------------------------------------
  assign arReady = state_Q == IDLE;

  assign rValid = state_Q == READ_DONE;

  assign rData[DW-1:0] = dataArray[araddr[AW-1:0]][DW-1:0];



//--------------------------------------------------------------------------
//                                Init Ram
//--------------------------------------------------------------------------
  string ram_init_path;

  initial begin
    if ($value$plusargs("rom_init_path=%s", ram_init_path)) begin
      $display("Init rom from %s", ram_init_path);
      $readmemh(ram_init_path, dataArray);
    end
    else begin
      $display("Can not find rom init path!");
    end
  end

endmodule