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

  always_comb begin
    
  end

  always_ff @(posedge aclk) begin
  
  end
    
endmodule