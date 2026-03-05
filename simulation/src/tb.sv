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

  logic               axi_arValid;
  logic               axi_arReady;
  logic [`AXI_AW-1:0] axi_arAddr;
  logic               axi_rValid;
  logic               axi_rReady;
  logic [`AXI_DW-1:0] axi_rData;

  amikus_top
  amikus(
    .clk        (clk),
    .rst        (rst),
    .axi_arValid(axi_arValid),
    .axi_arReady(axi_arReady),
    .axi_arAddr (axi_arAddr[`AXI_AW-1:0]),
    .axi_rValid (axi_rValid),
    .axi_rReady (axi_rReady),
    .axi_rdata  (axi_rData[`AXI_DW-1:0])
  );

  rom #(.AW(`AXI_AW), .DW(`AXI_DW))
  ram_u1 (
    .clk    (clk),
    .rst    (rst),
    .arvalid(axi_arValid),
    .arready(axi_arReady),
    .araddr (axi_arAddr[`AXI_AW-1:0]),
    .rValid (axi_rValid),
    .rReady (axi_rReady),
    .rData  (axi_rData[`AXI_DW-1:0])
  );


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