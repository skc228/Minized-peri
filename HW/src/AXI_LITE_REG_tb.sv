`timescale 1 ns / 1 ps

module axi_lite_reg_tb;

    // Parameters for AXI Lite
    parameter ADDR_WIDTH = 32;
    parameter DATA_WIDTH = 32;

    // AXI Lite Signals
    logic clk;
    logic resetn;
    
    logic [ADDR_WIDTH-1:0]    awaddr;
    logic                     awvalid;
    logic                     awready;
    
    logic [DATA_WIDTH-1:0]    wdata;
    logic [DATA_WIDTH/8-1:0]  wstrb;
    logic                     wvalid;
    logic                     wready;
    
    logic [2-1:0]             bresp;
    logic                     bvalid;
    logic                     bready;
    
    logic [ADDR_WIDTH-1:0]    araddr;
    logic                     arvalid;
    logic                     arready;
    
    logic [DATA_WIDTH-1:0]    rdata;
    logic [2-1:0]             rresp;
    logic                     rvalid;
    logic                     rready;

    // Instantiate the AXI Lite DUT (Device Under Test)
    AXI_LITE_REG #(
    .ADDR_WIDTH                     (32),
    .DATA_WIDTH                     (32)
    )
    DUT
    (
      .aclk                           (clk),
      .aresetn                        (resetn),

      .S_AXI_LITE_awaddr              (awaddr),
      .S_AXI_LITE_awvalid             (awvalid),
      .S_AXI_LITE_awready             (awready),
      .S_AXI_LITE_wdata               (wdata),
      .S_AXI_LITE_wstrb               (wstrb),
      .S_AXI_LITE_wvalid              (wvalid),
      .S_AXI_LITE_wready              (wready),
      .S_AXI_LITE_bresp               (bresp),
      .S_AXI_LITE_bvalid              (bvalid),
      .S_AXI_LITE_bready              (bready),
      .S_AXI_LITE_araddr              (araddr),
      .S_AXI_LITE_arvalid             (arvalid),
      .S_AXI_LITE_arready             (arready),
      .S_AXI_LITE_rdata               (rdata),
      .S_AXI_LITE_rresp               (rresp),
      .S_AXI_LITE_rvalid              (rvalid),
      .S_AXI_LITE_rready              (rready) 
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100MHz clock
    end

    // Reset generation
    initial begin
        resetn = 0;
        #20 resetn = 1;
    end

    // Test sequence
    initial begin
        // Initialize inputs
        awaddr  = 0;
        awvalid = 0;
        wdata   = 0;
        wstrb   = 4'hf;
        wvalid  = 0;
        bready  = 0;
        araddr  = 0;
        arvalid = 0;
        rready  = 0;

        // Wait for reset
        @(posedge resetn);
        
        #1000;
        
        // 1. Write 2 to address 0x00000000
        @(posedge clk);
        awaddr  = 32'h00000000;
        awvalid = 1;

        // Wait for AWREADY
        wait(awready);
        @(posedge clk);
        awvalid = 0;

        // Start WVALID after AWVALID & AWREADY handshake
        wdata   = 32'h00000002;
        wvalid  = 1;
        
        // Wait for WREADY
        wait(wready);
        @(posedge clk);
        wvalid  = 0;

        // Wait for BVALID
        @(posedge bvalid);
        bready = 1;
        @(posedge clk);
        bready = 0;

        // 2. Write 3 to address 0x00000004
        @(posedge clk);
        awaddr  = 32'h00000004;
        awvalid = 1;
        
        // Wait for AWREADY
        wait(awready);
        @(posedge clk);
        awvalid = 0;

        // Start WVALID after AWVALID & AWREADY handshake
        wdata   = 32'h00000003;
        wvalid  = 1;

        // Wait for WREADY
        wait(wready);
        @(posedge clk);
        wvalid  = 0;

        // Wait for BVALID
        @(posedge bvalid);
        bready = 1;
        @(posedge clk);
        bready = 0;
        
        // 3. Read from address 0x00000008
        @(posedge clk);
        araddr  = 32'h00000008;
        arvalid = 1;
        @(posedge clk);
        wait(arready);
        @(posedge clk);
        arvalid = 0;

        // Wait for RVALID and print the result
        @(posedge rvalid);
        rready = 1;
        $display("Read from 0x00000008: %h", rdata);
        @(posedge clk);
        rready = 0;

        // 4. Read from address 0x0000000C
        @(posedge clk);
        araddr  = 32'h0000000C;
        arvalid = 1;
        @(posedge clk);
        wait(arready);
        @(posedge clk);
        arvalid = 0;

        // Wait for RVALID and print the result
        @(posedge rvalid);
        rready = 1;
        $display("Read from 0x0000000C: %h", rdata);
        @(posedge clk);
        rready = 0;

        // 5. Read from address 0x00000010
        @(posedge clk);
        araddr  = 32'h00000010;
        arvalid = 1;
        @(posedge clk);
        wait(arready);
        @(posedge clk);
        arvalid = 0;

        // Wait for RVALID and print the result
        @(posedge rvalid);
        rready = 1;
        $display("Read from 0x00000010: %h", rdata);
        @(posedge clk);
        rready = 0;

        // 6. Read from address 0x00000020
        @(posedge clk);
        araddr  = 32'h00000020;
        arvalid = 1;
        @(posedge clk);
        wait(arready);
        @(posedge clk);
        arvalid = 0;

        // Wait for RVALID and print the result
        @(posedge rvalid);
        rready = 1;
        $display("Read from 0x00000020: %h", rdata);
        @(posedge clk);
        rready = 0;

        // Finish simulation
        #100 $finish;
    end

endmodule
