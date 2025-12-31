module ifuTop (
  input  wire        clk,
  input  wire        rst,
  output wire        instValid,
  output wire [31:0] inst
);

  wire             pc_en;
  wire [`XLEN-1:0] pc_In;
  wire [`XLEN-1:0] pc_Q;

  assign pc_en = 1'b1;

  assign pc_In[`XLEN-1:0] = pc_Q[`XLEN-1:0] + 'd4;

  REG_RST #(.DW(`XLEN)) pcReg(
    .CLK   (clk),
    .RST   (rst),
    .RSTVAL(64'h80000000),
    .EN    (pc_en),
    .D     (pc_In[`XLEN-1:0]),
    .Q     (pc_Q[`XLEN-1:0])
  );

  rom #(
    .AW(10),
    .DW(32)
  ) instRom(
    .clk  (clk),
    .raddr(pc_Q[11:2]),
    .rdata(inst[31:0])
  );

endmodule