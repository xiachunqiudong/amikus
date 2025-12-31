module REG #(
  parameter DW = 1
) (
  input  wire          CLK,
  input  wire          EN,
  input  wire [DW-1:0] D,
  output reg  [DW-1:0] Q
);
  
  always @(posedge CLK) begin
    if (EN) Q[DW-1:0] <= D[DW-1:0];
  end

endmodule
