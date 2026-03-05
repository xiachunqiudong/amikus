module ifu_fetcher(
  input  wire               clk,
  input  wire               rst,
  output wire               fetcher_instValid,
  output wire [31:0]        fetcher_inst,
  output wire               fethcer_arValid,
  input  wire               fethcer_arReady,
  output wire [`AXI_AW-1:0] fetcher_arAddr,
  input  wire               axi_rValid,
  input  wire               axi_rReady,
  input  wire [`AXI_DW-1:0] axi_rData
)

  wire fetcherIdle_In;
  wire fetcherIdle_Q;
  wire fetcherWaitData_In;
  wire fetcherWaitData_Q;

  assign fethcer_arValid = fetcherIdle_Q;

  assign 


endmodule