module AXI_LITE_REG #(
  parameter ADDR_WIDTH = 4,    // Address width
  parameter DATA_WIDTH = 32    // Data width
)
(
    input  logic                       aclk,                    // Clock
    input  logic                       aresetn,                 // Reset (active low)

    // AXI Lite Write Address Channel
    input  logic [ADDR_WIDTH-1:0]      S_AXI_LITE_awaddr,        // Write address
    input  logic                       S_AXI_LITE_awvalid,       // Write address valid
    output logic                       S_AXI_LITE_awready,       // Write address ready

    // AXI Lite Write Data Channel
    input  logic [DATA_WIDTH-1:0]      S_AXI_LITE_wdata,         // Write data
    input  logic [(DATA_WIDTH/8)-1:0]  S_AXI_LITE_wstrb,         // Write strobe
    input  logic                       S_AXI_LITE_wvalid,        // Write data valid
    output logic                       S_AXI_LITE_wready,        // Write data ready

    // AXI Lite Write Response Channel
    output logic [1:0]                 S_AXI_LITE_bresp,         // Write response
    output logic                       S_AXI_LITE_bvalid,        // Write response valid
    input  logic                       S_AXI_LITE_bready,        // Write response ready

    // AXI Lite Read Address Channel
    input  logic [ADDR_WIDTH-1:0]      S_AXI_LITE_araddr,        // Read address
    input  logic                       S_AXI_LITE_arvalid,       // Read address valid
    output logic                       S_AXI_LITE_arready,       // Read address ready

    // AXI Lite Read Data Channel
    output logic [DATA_WIDTH-1:0]      S_AXI_LITE_rdata,         // Read data
    output logic [1:0]                 S_AXI_LITE_rresp,         // Read response
    output logic                       S_AXI_LITE_rvalid,        // Read data valid
    input  logic                       S_AXI_LITE_rready         // Read data ready
);


  localparam ADDR_LSB                   = $clog2(DATA_WIDTH/ 8);

  // Initial block for the assertion (AXI LITE Associated Signal)
    initial begin
        if (DATA_WIDTH != 32 && DATA_WIDTH != 64) begin
            $error("DATA_WIDTH parameter must be either 32 or 64. Current value: %0d", DATA_WIDTH);
            $finish;
        end

        if (ADDR_WIDTH > 64) begin
            $error("ADDR_WIDTH parameter must be smaller than 64. Current value: %0d", ADDR_WIDTH);
            $finish;
        end
    end

/////// 
/////// AXI Step Flags
/////// 

  

// aw channel signal
  logic                               aw_done, aw_done_nxt;
  logic [ADDR_WIDTH-1:0]              awaddr, awaddr_nxt;
// w channel signal
  logic                               w_done, w_done_nxt;
// b channel signal
  logic                               b_done, b_done_nxt;
// ar channel signal
  logic                               ar_done, ar_done_nxt;
  logic [ADDR_WIDTH-1:0]              araddr, araddr_nxt;
// r channel signal
  logic                               r_done, r_done_nxt;

// Ready 1 Cycle Wait
  logic                               wait_done;

/////// 
/////// Registers
/////// 

  logic [DATA_WIDTH-1:0]              srcA_reg, srcA_reg_nxt;
  logic [DATA_WIDTH-1:0]              srcB_reg, srcB_reg_nxt;
  logic [DATA_WIDTH-1:0]              add_reg, add_reg_nxt;
  logic [DATA_WIDTH-1:0]              sub_reg, sub_reg_nxt;
  logic [DATA_WIDTH-1:0]              mult_reg, mult_reg_nxt;


  always_comb begin
    aw_done_nxt                       = aw_done;
    w_done_nxt                        = w_done;
    b_done_nxt                        = b_done;  
    ar_done_nxt                       = ar_done; 
    r_done_nxt                        = r_done;  
    awaddr_nxt                        = awaddr;
    araddr_nxt                        = araddr;
    srcA_reg_nxt                      = srcA_reg;
    srcB_reg_nxt                      = srcB_reg;
    add_reg_nxt                       = add_reg;
    sub_reg_nxt                       = sub_reg;
    mult_reg_nxt                      = mult_reg;

    S_AXI_LITE_awready                = 'd0;
    S_AXI_LITE_wready                 = 'd0;
    S_AXI_LITE_bresp                  = 'd0;
    S_AXI_LITE_bvalid                 = 'd0;
    S_AXI_LITE_rdata                  = {DATA_WIDTH/16}{'hdead};
    S_AXI_LITE_rresp                  = 'd0;
    S_AXI_LITE_rvalid                 = 'd0;
    

    

  //// Write assocaited if state
    if(~aw_done) begin
      S_AXI_LITE_awready              = (wait_done) ? 1'b1 : 1'b0;

      if(S_AXI_LITE_awvalid && S_AXI_LITE_awready) begin
        awaddr_nxt                    = S_AXI_LITE_awaddr;
        aw_done_nxt                   = 1'b1;
      end
    end

    else if(aw_done & ~w_done) begin
      S_AXI_LITE_wready               = 1'b1;

        if(S_AXI_LITE_wvalid && S_AXI_LITE_wready) begin
          w_done_nxt                  = 1'b1;
          
          for(int i = 0 ; i < (DATA_WIDTH / 8) ; i++) begin
            if((S_AXI_LITE_wstrb[i])) begin
              case (awaddr[ADDR_WIDTH-1:ADDR_LSB])
                'h0 : begin
                  srcA_reg_nxt[8*(i+1)-1:8*i]   = S_AXI_LITE_wdata[8*(i+1)-1:8*i];
                end
                'h1 : begin
                  srcB_reg_nxt[8*(i+1)-1:8*i]   = S_AXI_LITE_wdata[8*(i+1)-1:8*i];
                end
                default : begin  
                  ; // Nothing Happened
                end
              endcase
            end
          end
        end
      end
    end

    else if(aw_done & w_done & ~b_done) begin
      S_AXI_LITE_bvalid               = 1'b1;

      if(S_AXI_LITE_bvalid && S_AXI_LITE_bready) begin
        b_done_nxt                    = 1'b1;
      end
    end

    else if(aw_done & w_done & b_done) begin
      aw_done_nxt                     = 'b0;
      w_done_nxt                      = 'b0;
      b_done_nxt                      = 'b0;
    end

  //// Read assocaited if state
    if(~ar_done) begin
    end

    else if() begin
    end
  end

  always_ff @(posedge aclk) begin
    aw_done                             <= ~aresetn ? 'd0 : aw_done_nxt;
    w_done                              <= ~aresetn ? 'd0 : w_done_nxt;
    dec_err                             <= ~aresetn ? 'd0 : dec_err_nxt;
    b_done                              <= ~aresetn ? 'd0 : b_done_nxt;
    ar_done                             <= ~aresetn ? 'd0 : ar_done_nxt;
    r_done                              <= ~aresetn ? 'd0 : r_done_nxt;
    awaddr                              <= awaddr_nxt;
    araddr                              <= araddr_nxt;
    srcA_reg                            <= srcA_reg_nxt;
    srcB_reg                            <= srcB_reg_nxt;
    add_reg                             <= add_reg_nxt;
    sub_reg                             <= sub_reg_nxt;
    mult_reg                            <= mult_reg_nxt;

    wait_done                           <= ~aresetn ? 'd0 : 'b1;
  end
    
endmodule