module tb;

  parameter PERIOD = 5;

  logic        clk;
  logic        rst;
  logic [63:0] cycleCnt_Q;

  initial begin
    clk = 0;
    rst = 1;
    #PERIOD rst = 0;
    forever #(PERIOD/2) clk = ~clk;
  end

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      cycleCnt_Q[63:0] <= 'd0;
    end
    else begin
      cycleCnt_Q[63:0] <= cycleCnt_Q[63:0] + 'd1;
    end
  end

  always @(posedge clk) begin
    if (cycleCnt_Q[63:0] >= 'd20000) begin
      $fsdbDumpoff;
      $finish;
    end
  end

  parameter RAM_AW = 20;
  parameter AXI_AW = 32;
  parameter AXI_DW = 128;

  logic              arValid;
  logic              arReady;
  logic [AXI_AW-1:0] arAddr;
  logic              rValid;
  logic              rReady;
  logic [AXI_DW-1:0] rData;

  amikus_top
  amikus(
    .clk(clk),
    .rst(rst)
  );


  // ram #(
  //   .AW(RAM_AW),
  //   .DW(AXI_DW)
  // ) u_ram(
  //   .clk    (clk),
  //   .rst    (rst),
  //   .arValid(arValid),
  //   .arReady(arReady),
  //   .arAddr (arAddr[RAM_AW-1:0]),
  //   .rValid (rValid),
  //   .rReady (rReady),
  //   .rData  (rData[AXI_DW-1:0])
  // );

  string fsdb_path;

  initial begin
    if ($value$plusargs("fsdb_path=%s", fsdb_path)) begin
      $display("fsdb is write to %s", fsdb_path);
    end
    else begin
      fsdb_path = "tb.fsdb";
    end
  end

  initial begin
    $fsdbDumpfile(fsdb_path, 1024);
    $fsdbDumpvars(0, tb);
    $fsdbDumpvars("+struct");
    $fsdbDumpvars("+mda");
    $fsdbDumpon;
  end

endmodule