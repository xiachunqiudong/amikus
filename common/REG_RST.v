module REG_RST #(
  parameter DW = 1
) (
  input  wire          CLK,
  input  wire          RST,
  input  wire [DW-1:0] RSTVAL,
  input  wire          EN,
  input  wire [DW-1:0] D,
  output reg  [DW-1:0] Q
);
  
  always @(posedge CLK or posedge RST) begin
    if (RST) begin
      Q[DW-1:0] <= RSTVAL[DW-1:0];
    end
    else if (EN) begin
      Q[DW-1:0] <= D[DW-1:0];
    end
  end

endmodule
