`timescale 1 ps / 1 ps

module Minized_top_wrapper
(  
  DDR_addr,
  DDR_ba,
  DDR_cas_n,
  DDR_ck_n,
  DDR_ck_p,
  DDR_cke,
  DDR_cs_n,
  DDR_dm,
  DDR_dq,
  DDR_dqs_n,
  DDR_dqs_p,
  DDR_odt,
  DDR_ras_n,
  DDR_reset_n,
  DDR_we_n,
  FIXED_IO_ddr_vrn,
  FIXED_IO_ddr_vrp,
  FIXED_IO_mio,
  FIXED_IO_ps_clk,
  FIXED_IO_ps_porb,
  FIXED_IO_ps_srstb,
  UART_ctsn,
  UART_dcdn,
  UART_dsrn,
  UART_dtrn,
  UART_ri,
  UART_rtsn,
  UART_rxd,
  UART_txd,
  pl_led_g_tri_o,
  pl_led_r_tri_o
);

// Input, Output Signals
  inout [14:0]                      DDR_addr;
  inout [2:0]                       DDR_ba;
  inout                             DDR_cas_n;
  inout                             DDR_ck_n;
  inout                             DDR_ck_p;
  inout                             DDR_cke;
  inout                             DDR_cs_n;
  inout [1:0]                       DDR_dm;
  inout [15:0]                      DDR_dq;
  inout [1:0]                       DDR_dqs_n;
  inout [1:0]                       DDR_dqs_p;
  inout                             DDR_odt;
  inout                             DDR_ras_n;
  inout                             DDR_reset_n;
  inout                             DDR_we_n;
  inout                             FIXED_IO_ddr_vrn;
  inout                             FIXED_IO_ddr_vrp;
  inout [31:0]                      FIXED_IO_mio;
  inout                             FIXED_IO_ps_clk;
  inout                             FIXED_IO_ps_porb;
  inout                             FIXED_IO_ps_srstb;
  input                             UART_ctsn;
  input                             UART_dcdn;
  input                             UART_dsrn;
  output                            UART_dtrn;
  input                             UART_ri;
  output                            UART_rtsn;
  input                             UART_rxd;
  output                            UART_txd;
  output                            pl_led_g_tri_o;
  output                            pl_led_r_tri_o;

  logic [14:0]                      DDR_addr;
  logic [2:0]                       DDR_ba;
  logic                             DDR_cas_n;
  logic                             DDR_ck_n;
  logic                             DDR_ck_p;
  logic                             DDR_cke;
  logic                             DDR_cs_n;
  logic [1:0]                       DDR_dm;
  logic [15:0]                      DDR_dq;
  logic [1:0]                       DDR_dqs_n;
  logic [1:0]                       DDR_dqs_p;
  logic                             DDR_odt;
  logic                             DDR_ras_n;
  logic                             DDR_reset_n;
  logic                             DDR_we_n;
  logic                             FIXED_IO_ddr_vrn;
  logic                             FIXED_IO_ddr_vrp;
  logic [31:0]                      FIXED_IO_mio;
  logic                             FIXED_IO_ps_clk;
  logic                             FIXED_IO_ps_porb;
  logic                             FIXED_IO_ps_srstb;
  logic                             UART_ctsn;
  logic                             UART_dcdn;
  logic                             UART_dsrn;
  logic                             UART_dtrn;
  logic                             UART_ri;
  logic                             UART_rtsn;
  logic                             UART_rxd;
  logic                             UART_txd;
  logic                             pl_led_g_tri_o;
  logic                             pl_led_r_tri_o;

// Internal Signals
  // Clock, Reset Signals
  logic                             FCLK_CLK0;
  logic [0:0]                       FCLK_CLK0_RSTN;

  // AXI Lite Signals
  logic [31:0]                      USER_M_AXI_LITE_araddr;
  logic [2:0]                       USER_M_AXI_LITE_arprot;
  logic                             USER_M_AXI_LITE_arready;
  logic                             USER_M_AXI_LITE_arvalid;
  logic [31:0]                      USER_M_AXI_LITE_awaddr;
  logic [2:0]                       USER_M_AXI_LITE_awprot;
  logic                             USER_M_AXI_LITE_awready;
  logic                             USER_M_AXI_LITE_awvalid;
  logic                             USER_M_AXI_LITE_bready;
  logic [1:0]                       USER_M_AXI_LITE_bresp;
  logic                             USER_M_AXI_LITE_bvalid;
  logic [31:0]                      USER_M_AXI_LITE_rdata;
  logic                             USER_M_AXI_LITE_rready;
  logic [1:0]                       USER_M_AXI_LITE_rresp;
  logic                             USER_M_AXI_LITE_rvalid;
  logic [31:0]                      USER_M_AXI_LITE_wdata;
  logic                             USER_M_AXI_LITE_wready;
  logic [3:0]                       USER_M_AXI_LITE_wstrb;
  logic                             USER_M_AXI_LITE_wvalid;

  Minized_top Minized_top_i
  (
    .DDR_addr                       (DDR_addr),
    .DDR_ba                         (DDR_ba),
    .DDR_cas_n                      (DDR_cas_n),
    .DDR_ck_n                       (DDR_ck_n),
    .DDR_ck_p                       (DDR_ck_p),
    .DDR_cke                        (DDR_cke),
    .DDR_cs_n                       (DDR_cs_n),
    .DDR_dm                         (DDR_dm),
    .DDR_dq                         (DDR_dq),
    .DDR_dqs_n                      (DDR_dqs_n),
    .DDR_dqs_p                      (DDR_dqs_p),
    .DDR_odt                        (DDR_odt),
    .DDR_ras_n                      (DDR_ras_n),
    .DDR_reset_n                    (DDR_reset_n),
    .DDR_we_n                       (DDR_we_n),
    .FCLK_CLK0                      (FCLK_CLK0),
    .FCLK_CLK0_RSTN                 (FCLK_CLK0_RSTN),
    .FIXED_IO_ddr_vrn               (FIXED_IO_ddr_vrn),
    .FIXED_IO_ddr_vrp               (FIXED_IO_ddr_vrp),
    .FIXED_IO_mio                   (FIXED_IO_mio),
    .FIXED_IO_ps_clk                (FIXED_IO_ps_clk),
    .FIXED_IO_ps_porb               (FIXED_IO_ps_porb),
    .FIXED_IO_ps_srstb              (FIXED_IO_ps_srstb),
    .UART_ctsn                      (UART_ctsn),
    .UART_dcdn                      (UART_dcdn),
    .UART_dsrn                      (UART_dsrn),
    .UART_dtrn                      (UART_dtrn),
    .UART_ri                        (UART_ri),
    .UART_rtsn                      (UART_rtsn),
    .UART_rxd                       (UART_rxd),
    .UART_txd                       (UART_txd),
    .USER_M_AXI_LITE_araddr         (USER_M_AXI_LITE_araddr),
    .USER_M_AXI_LITE_arprot         (USER_M_AXI_LITE_arprot),
    .USER_M_AXI_LITE_arready        (USER_M_AXI_LITE_arready),
    .USER_M_AXI_LITE_arvalid        (USER_M_AXI_LITE_arvalid),
    .USER_M_AXI_LITE_awaddr         (USER_M_AXI_LITE_awaddr),
    .USER_M_AXI_LITE_awprot         (USER_M_AXI_LITE_awprot),
    .USER_M_AXI_LITE_awready        (USER_M_AXI_LITE_awready),
    .USER_M_AXI_LITE_awvalid        (USER_M_AXI_LITE_awvalid),
    .USER_M_AXI_LITE_bready         (USER_M_AXI_LITE_bready),
    .USER_M_AXI_LITE_bresp          (USER_M_AXI_LITE_bresp),
    .USER_M_AXI_LITE_bvalid         (USER_M_AXI_LITE_bvalid),
    .USER_M_AXI_LITE_rdata          (USER_M_AXI_LITE_rdata),
    .USER_M_AXI_LITE_rready         (USER_M_AXI_LITE_rready),
    .USER_M_AXI_LITE_rresp          (USER_M_AXI_LITE_rresp),
    .USER_M_AXI_LITE_rvalid         (USER_M_AXI_LITE_rvalid),
    .USER_M_AXI_LITE_wdata          (USER_M_AXI_LITE_wdata),
    .USER_M_AXI_LITE_wready         (USER_M_AXI_LITE_wready),
    .USER_M_AXI_LITE_wstrb          (USER_M_AXI_LITE_wstrb),
    .USER_M_AXI_LITE_wvalid         (USER_M_AXI_LITE_wvalid),
    .pl_led_g_tri_o                 (pl_led_g_tri_o),
    .pl_led_r_tri_o                 (pl_led_r_tri_o)
  );
endmodule
