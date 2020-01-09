//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 01/23/2017 05:24:01 PM
// Design Name:
// Module Name: top
// Project Name:
// Target Devices:
// Tool Versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////

`timescale 1ps / 1ps

`include  "ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_1_axi_ctrl_addr_decode.v"
`include  "ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_1_axi_ctrl_read.v"
`include  "ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_1_axi_ctrl_reg.v"
`include  "ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_1_axi_ctrl_reg_bank.v"
`include  "ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_1_axi_ctrl_top.v"
`include  "ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_1_axi_ctrl_write.v"
`include  "ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_1_axi_mc.v"
`include  "ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_1_axi_mc_ar_channel.v"
`include  "ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_1_axi_mc_aw_channel.v"
`include  "ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_1_axi_mc_b_channel.v"
`include  "ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_1_axi_mc_cmd_arbiter.v"
`include  "ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_1_axi_mc_cmd_fsm.v"
`include  "ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_1_axi_mc_cmd_translator.v"
`include  "ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_1_axi_mc_fifo.v"
`include  "ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_1_axi_mc_incr_cmd.v"
`include  "ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_1_axi_mc_r_channel.v"
`include  "ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_1_axi_mc_simple_fifo.v"
`include  "ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_1_axi_mc_w_channel.v"
`include  "ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_1_axi_mc_wr_cmd_fsm.v"
`include  "ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_1_axi_mc_wrap_cmd.v"
`include  "ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_1_ddr_a_upsizer.v"
`include  "ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_1_ddr_axi_register_slice.v"
`include  "ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_1_ddr_axi_upsizer.v"
`include  "ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_1_ddr_axic_register_slice.v"
`include  "ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_1_ddr_carry_and.v"
`include  "ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_1_ddr_carry_latch_and.v"
`include  "ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_1_ddr_carry_latch_or.v"
`include  "ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_1_ddr_carry_or.v"
`include  "ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_1_ddr_command_fifo.v"
`include  "ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_1_ddr_comparator.v"
`include  "ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_1_ddr_comparator_sel.v"
`include  "ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_1_ddr_comparator_sel_static.v"
`include  "ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_1_ddr_r_upsizer.v"
`include  "ddr3/ddr3/user_design/rtl/axi/mig_7series_v4_1_ddr_w_upsizer.v"
`include  "ddr3/ddr3/user_design/rtl/clocking/mig_7series_v4_1_clk_ibuf.v"
`include  "ddr3/ddr3/user_design/rtl/clocking/mig_7series_v4_1_infrastructure.v"
`include  "ddr3/ddr3/user_design/rtl/clocking/mig_7series_v4_1_iodelay_ctrl.v"
`include  "ddr3/ddr3/user_design/rtl/clocking/mig_7series_v4_1_tempmon.v"
`include  "ddr3/ddr3/user_design/rtl/controller/mig_7series_v4_1_arb_mux.v"
`include  "ddr3/ddr3/user_design/rtl/controller/mig_7series_v4_1_arb_row_col.v"
`include  "ddr3/ddr3/user_design/rtl/controller/mig_7series_v4_1_arb_select.v"
`include  "ddr3/ddr3/user_design/rtl/controller/mig_7series_v4_1_bank_cntrl.v"
`include  "ddr3/ddr3/user_design/rtl/controller/mig_7series_v4_1_bank_common.v"
`include  "ddr3/ddr3/user_design/rtl/controller/mig_7series_v4_1_bank_compare.v"
`include  "ddr3/ddr3/user_design/rtl/controller/mig_7series_v4_1_bank_mach.v"
`include  "ddr3/ddr3/user_design/rtl/controller/mig_7series_v4_1_bank_queue.v"
`include  "ddr3/ddr3/user_design/rtl/controller/mig_7series_v4_1_bank_state.v"
`include  "ddr3/ddr3/user_design/rtl/controller/mig_7series_v4_1_col_mach.v"
`include  "ddr3/ddr3/user_design/rtl/controller/mig_7series_v4_1_mc.v"
`include  "ddr3/ddr3/user_design/rtl/controller/mig_7series_v4_1_rank_cntrl.v"
`include  "ddr3/ddr3/user_design/rtl/controller/mig_7series_v4_1_rank_common.v"
`include  "ddr3/ddr3/user_design/rtl/controller/mig_7series_v4_1_rank_mach.v"
`include  "ddr3/ddr3/user_design/rtl/controller/mig_7series_v4_1_round_robin_arb.v"
`include  "ddr3/ddr3/user_design/rtl/ecc/mig_7series_v4_1_ecc_buf.v"
`include  "ddr3/ddr3/user_design/rtl/ecc/mig_7series_v4_1_ecc_dec_fix.v"
`include  "ddr3/ddr3/user_design/rtl/ecc/mig_7series_v4_1_ecc_gen.v"
`include  "ddr3/ddr3/user_design/rtl/ecc/mig_7series_v4_1_ecc_merge_enc.v"
`include  "ddr3/ddr3/user_design/rtl/ecc/mig_7series_v4_1_fi_xor.v"
`include  "ddr3/ddr3/user_design/rtl/ip_top/mig_7series_v4_1_mem_intfc.v"
`include  "ddr3/ddr3/user_design/rtl/ip_top/mig_7series_v4_1_memc_ui_top_axi.v"
`include  "ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_1_ddr_byte_group_io.v"
`include  "ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_1_ddr_byte_lane.v"
`include  "ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_1_ddr_calib_top.v"
`include  "ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_1_ddr_if_post_fifo.v"
`include  "ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_1_ddr_mc_phy.v"
`include  "ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_1_ddr_mc_phy_wrapper.v"
`include  "ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_1_ddr_of_pre_fifo.v"
`include  "ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_4lanes.v"
`include  "ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_ck_addr_cmd_delay.v"
`include  "ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_dqs_found_cal.v"
`include  "ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_dqs_found_cal_hr.v"
`include  "ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_init.v"
`include  "ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_ocd_cntlr.v"
`include  "ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_ocd_data.v"
`include  "ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_ocd_edge.v"
`include  "ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_ocd_lim.v"
`include  "ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_ocd_mux.v"
`include  "ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_ocd_po_cntlr.v"
`include  "ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_ocd_samp.v"
`include  "ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_oclkdelay_cal.v"
`include  "ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_prbs_rdlvl.v"
`include  "ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_rdlvl.v"
`include  "ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_tempmon.v"
`include  "ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_top.v"
`include  "ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_wrcal.v"
`include  "ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_wrlvl.v"
`include  "ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_1_ddr_phy_wrlvl_off_delay.v"
`include  "ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_1_ddr_prbs_gen.v"
`include  "ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_1_ddr_skip_calib_tap.v"
`include  "ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_1_poc_cc.v"
`include  "ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_1_poc_edge_store.v"
`include  "ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_1_poc_meta.v"
`include  "ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_1_poc_pd.v"
`include  "ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_1_poc_tap_base.v"
`include  "ddr3/ddr3/user_design/rtl/phy/mig_7series_v4_1_poc_top.v"
`include  "ddr3/ddr3/user_design/rtl/ui/mig_7series_v4_1_ui_cmd.v"
`include  "ddr3/ddr3/user_design/rtl/ui/mig_7series_v4_1_ui_rd_data.v"
`include  "ddr3/ddr3/user_design/rtl/ui/mig_7series_v4_1_ui_top.v"
`include  "ddr3/ddr3/user_design/rtl/ui/mig_7series_v4_1_ui_wr_data.v"
`include  "ddr3/ddr3/user_design/rtl/ddr3.v"
`include  "ddr3/ddr3/user_design/rtl/ddr3_mig_sim.v"


module axi_ddrvfifo(
    input wire aclk,
    input wire aresetn,

    //DDR3 controller clocks
//    input wire sys_clk_p,
//    input wire sys_clk_n,
    input wire sys_clk_i,

    //Generic FIFO style interface
    input  wire read,
    input  wire write,
    input  wire [63:0] data_in,
    output wire [63:0] data_out,
    output wire empty,
    output wire full,

    //VFIFO status lines
    input wire [1:0]  ext_vfifo_mm2s_channel_full,
    output wire [1:0] ext_vfifo_s2mm_channel_full,
    output wire [1:0] ext_vfifo_mm2s_channel_empty,
    output wire [1:0] ext_vfifo_idle,
    output wire vfifo_mm2s_rresp_err_intr,         // output wire vfifo_mm2s_rresp_err_intr
    output wire vfifo_s2mm_bresp_err_intr,         // output wire vfifo_s2mm_bresp_err_intr
    output wire vfifo_s2mm_overrun_err_intr,       // output wire vfifo_s2mm_overrun_err_intr

     //Slave AXI stream ports
    input wire          ext_s_axis_tvalid,      // input wire s_axis_tvalid
    output wire         ext_s_axis_tready,      // output wire s_axis_tready
    input wire [63:0]   ext_s_axis_tdata,       // input wire [31 : 0] s_axis_tdata
    input wire          ext_s_axis_tlast,       // input wire s_axis_tlast
    input wire [0:0]    ext_s_axis_tdest,

    //Master AXI stream ports
    output wire         ext_m_axis_tvalid,      // output wire m_axis_tvalid
    input wire          ext_m_axis_tready,      // input wire m_axis_tready
    output wire [63:0]  ext_m_axis_tdata,       // output wire [31 : 0] m_axis_tdata
    output wire         ext_m_axis_tlast,        // output wire m_axis_tlast
    output wire [0:0]   ext_m_axis_tdest,

    // DEBUG: MIG Slave Interface Write Data Ports
    //output axi_wvalid, axi_wready,
    // DEBUG: MIG Slave Interface Read Data Ports
    //output axi_rvalid, axi_rready,

    // Memory interface ports
    inout wire [63:0] ddr3_dq,
    inout wire [7:0] ddr3_dqs_n,
    inout wire [7:0] ddr3_dqs_p,
    output wire [14:0] ddr3_addr,
    output wire [2:0] ddr3_ba,
    output wire ddr3_ras_n,
    output wire ddr3_cas_n,
    output wire ddr3_we_n,
    output wire ddr3_reset_n,
    output wire [0:0] ddr3_ck_p,
    output wire [0:0] ddr3_ck_n,
    output wire [0:0] ddr3_cke,
    output wire [0:0] ddr3_cs_n,
    output wire [7:0] ddr3_dm,
    output wire [0:0] ddr3_odt,
    
    input wire [11:0] ddr3_fpga_temperature,
    output wire mmcm_locked,
    output wire init_calib_complete // output           init_calib_complete
    );

    wire sys_rst; //DDR reset controller
    assign sys_rst = aresetn;

    wire ui_clk;            // output           ui_clk
    wire ui_clk_sync_rst;   // output           ui_clk_sync_rst
//    wire mmcm_locked;       // output         mmcm_locked
    wire app_sr_req;        // input            app_sr_req
    wire app_ref_req;       // input            app_ref_req
    wire app_zq_req;        // input            app_zq_req
    wire app_sr_active;     // output           app_sr_active
    wire app_ref_ack;       // output           app_ref_ack
    wire app_zq_ack;        // output           app_zq_ack


    //Signals to connect the MIG to the Virtual FIFO Controller
    wire [2:0]  axi_awid;       // output wire [2 : 0] m_axi_awid
    wire [31:0] axi_awaddr;     // output wire [31 : 0] m_axi_awaddr
    wire [7:0]  axi_awlen;      // output wire [7 : 0] m_axi_awlen
    wire [2:0]  axi_awsize;     // output wire [2 : 0] m_axi_awsize
    wire [1:0]  axi_awburst;    // output wire [1 : 0] m_axi_awburst
    wire        axi_awvalid;    // output wire m_axi_awvalid
    wire        axi_awready;    // input wire m_axi_awready
    wire [63:0] axi_wdata;      // output wire [63 : 0] m_axi_wdata
    wire [7:0]  axi_wstrb;      // output wire [7 : 0] m_axi_wstrb
    wire        axi_wlast;      // output wire m_axi_wlast
    wire        axi_wvalid;     // output wire m_axi_wvalid
    wire        axi_wready;     // input wire m_axi_wready
    wire [2:0]  axi_bid;        // input wire [2 : 0] m_axi_bid
    wire [1:0]  axi_bresp;      // input wire [1 : 0] m_axi_bresp
    wire [0:0]  axi_buser;      // input wire [0 : 0] m_axi_buser
    wire        axi_bvalid;     // input wire m_axi_bvalid
    wire        axi_bready;     // output wire m_axi_bready
    wire [2:0]  axi_arid;       // output wire [2 : 0] m_axi_arid
    wire [31:0] axi_araddr;     // output wire [31 : 0] m_axi_araddr
    wire [7:0]  axi_arlen;      // output wire [7 : 0] m_axi_arlen
    wire [2:0]  axi_arsize;     // output wire [2 : 0] m_axi_arsize
    wire [1:0]  axi_arburst;    // output wire [1 : 0] m_axi_arburst
    wire        axi_arvalid;    // output wire m_axi_arvalid
    wire        axi_arready;    // input wire m_axi_arready
    wire [2:0]  axi_rid;        // input wire [2 : 0] m_axi_rid
    wire [63:0] axi_rdata;      // input wire [63 : 0] m_axi_rdata
    wire [1:0]  axi_rresp;      // input wire [1 : 0] m_axi_rresp
    wire        axi_rlast;      // input wire m_axi_rlast
    wire [0:0]  axi_ruser;      // input wire [0 : 0] m_axi_ruser
    wire        axi_rvalid;     // input wire m_axi_rvalid
    wire        axi_rready;     // output wire m_axi_rready


    //VFIFO status lines
    wire [1:0]  vfifo_mm2s_channel_full;
    wire [1:0]  vfifo_s2mm_channel_full;
    wire [1:0]  vfifo_mm2s_channel_empty;
    wire [1:0]  vfifo_idle;

     //Slave AXI stream ports
    wire        s_axis_tvalid;              // input wire s_axis_tvalid
    wire        s_axis_tready;              // output wire s_axis_tready
    wire [63:0] s_axis_tdata;               // input wire [63 : 0] s_axis_tdata
    wire [7:0]  s_axis_tstrb;               // input wire [7 : 0] s_axis_tstrb
    wire [7:0]  s_axis_tkeep;               // input wire [7 : 0] s_axis_tkeep
    wire        s_axis_tlast;               // input wire s_axis_tlast
    wire [0:0]  s_axis_tid;                 // input wire [0 : 0] s_axis_tid
    wire [0:0]  s_axis_tdest;               // input wire [0 : 0] s_axis_tdest

    //Master AXI stream ports
    wire        m_axis_tvalid;              // output wire m_axis_tvalid
    wire        m_axis_tready;              // input wire m_axis_tready
    wire [63:0] m_axis_tdata;               // output wire [63 : 0] m_axis_tdata
    wire [7:0]  m_axis_tstrb;               // output wire [7 : 0] m_axis_tstrb
    wire [7:0]  m_axis_tkeep;               // output wire [7 : 0] m_axis_tkeep
    wire        m_axis_tlast;               // output wire m_axis_tlast
    wire [0:0]  m_axis_tid;                 // output wire [0 : 0] m_axis_tid
    wire [0:0]  m_axis_tdest;               // output wire [0 : 0] m_axis_tdest

    assign s_axis_tdest = ext_s_axis_tdest;
    assign s_axis_tid = 1'b0;
    assign s_axis_tkeep = 4'hf;
    assign s_axis_tstrb = 4'hf;
//    assign vfifo_mm2s_channel_full = 2'd0;

    //General FIFO style interface
    assign empty = (vfifo_mm2s_channel_empty==2'd0 && s_axis_tready);
    assign full = vfifo_s2mm_channel_full;
    assign data_out = m_axis_tvalid ? m_axis_tdata : 64'd0;

     //Slave AXI stream ports
    assign s_axis_tvalid     = ext_s_axis_tvalid;       // input wire s_axis_tvalid
    assign ext_s_axis_tready = s_axis_tready;           // output wire s_axis_tready
    assign s_axis_tdata      = ext_s_axis_tdata;        // input wire [63 : 0] s_axis_tdata
    assign s_axis_tlast      = ext_s_axis_tlast;        // input wire s_axis_tlast
    assign s_axis_tdest      = ext_s_axis_tdest;

    //Master AXI stream ports
    assign ext_m_axis_tvalid = m_axis_tvalid;           // output wire m_axis_tvalid
    assign m_axis_tready     = ext_m_axis_tready;       // input wire m_axis_tready
    assign ext_m_axis_tdata  = m_axis_tdata;            // output wire [63 : 0] m_axis_tdata
    assign ext_m_axis_tlast  = m_axis_tlast;            // output wire m_axis_tlast
    assign ext_m_axis_tdest  = m_axis_tdest;

    assign vfifo_mm2s_channel_full      = ext_vfifo_mm2s_channel_full;
    assign ext_vfifo_s2mm_channel_full  = vfifo_s2mm_channel_full;
    assign ext_vfifo_mm2s_channel_empty = vfifo_mm2s_channel_empty;
    assign ext_vfifo_idle               = vfifo_idle;


    //*****************************************************************************
    //   ____  ____
    //  /   /\/   /
    // /___/  \  /   Vendor             : Xilinx
    // \   \   \/    Version            :
    //  \   \        Application        : VFIFO
    //  /   /        Filename           : axi_vfifo_ctrl_0.veo
    // /___/   /\    Date Last Modified :
    // \   \  /  \   Date Created       :
    //  \___\/\___\
    //
    // Device           : 7 Series
    // Design Name      : Virtual FIFO
    // Purpose          : Template file containing code that can be used as a model
    //                    for instantiating a CORE Generator module in a HDL design.
    // Revision History :
    //*****************************************************************************
//    `ifdef 2017    
//    axi_vfifo_ctrl_0 virtual_fifo_inst
//    `elsif 2019
    vfifo virtual_fifo_inst
 //   `endif
    (
        .aclk(aclk),                                          // input wire aclk
        .aresetn(aresetn),                                    // input wire aresetn

        //Slave AXI stream ports
        .s_axis_tvalid(s_axis_tvalid),                        // input wire s_axis_tvalid
        .s_axis_tready(s_axis_tready),                        // output wire s_axis_tready
        .s_axis_tdata(s_axis_tdata),                          // input wire [31 : 0] s_axis_tdata
        .s_axis_tstrb(s_axis_tstrb),                          // input wire [3 : 0] s_axis_tstrb           <----------------------------- NOT USED
        .s_axis_tkeep(s_axis_tkeep),                          // input wire [3 : 0] s_axis_tkeep
        .s_axis_tlast(s_axis_tlast),                          // input wire s_axis_tlast
        .s_axis_tid(s_axis_tid),                              // input wire [0 : 0] s_axis_tid
        .s_axis_tdest(s_axis_tdest),                          // input wire [0 : 0] s_axis_tdest

        //Master AXI stream ports
        .m_axis_tvalid(m_axis_tvalid),                        // output wire m_axis_tvalid
        .m_axis_tready(m_axis_tready),                        // input wire m_axis_tready
        .m_axis_tdata(m_axis_tdata),                          // output wire [31 : 0] m_axis_tdata
        .m_axis_tstrb(),                          // output wire [3 : 0] m_axis_tstrb           <----------------------------- NOT USED
        .m_axis_tkeep(m_axis_tkeep),                          // output wire [3 : 0] m_axis_tkeep
        .m_axis_tlast(m_axis_tlast),                          // output wire m_axis_tlast
        .m_axis_tid(m_axis_tid),                              // output wire [0 : 0] m_axis_tid
        .m_axis_tdest(m_axis_tdest),                          // output wire [0 : 0] m_axis_tdest

        //AXI Memory Mapped ports
        .m_axi_awid(axi_awid),                              // output wire [0 : 0] m_axi_awid
        .m_axi_awaddr(axi_awaddr),                          // output wire [31 : 0] m_axi_awaddr
        .m_axi_awlen(axi_awlen),                            // output wire [7 : 0] m_axi_awlen
        .m_axi_awsize(axi_awsize),                          // output wire [2 : 0] m_axi_awsize
        .m_axi_awburst(axi_awburst),                        // output wire [1 : 0] m_axi_awburst
        .m_axi_awlock(),                          // output wire [0 : 0] m_axi_awlock
        .m_axi_awcache(),                        // output wire [3 : 0] m_axi_awcache
        .m_axi_awprot(),                          // output wire [2 : 0] m_axi_awprot
        .m_axi_awqos(),                            // output wire [3 : 0] m_axi_awqos
        .m_axi_awregion(),                      // output wire [3 : 0] m_axi_awregion
        .m_axi_awuser(),                          // output wire [0 : 0] m_axi_awuser
        .m_axi_awvalid(axi_awvalid),                        // output wire m_axi_awvalid
        .m_axi_awready(axi_awready),                        // input wire m_axi_awready
        .m_axi_wdata(axi_wdata),                            // output wire [31 : 0] m_axi_wdata
        .m_axi_wstrb(axi_wstrb),                            // output wire [3 : 0] m_axi_wstrb
        .m_axi_wlast(axi_wlast),                            // output wire m_axi_wlast
        .m_axi_wuser(),                            // output wire [0 : 0] m_axi_wuser
        .m_axi_wvalid(axi_wvalid),                          // output wire m_axi_wvalid
        .m_axi_wready(axi_wready),                          // input wire m_axi_wready
        .m_axi_bid(1'h0),                                // input wire [0 : 0] m_axi_bid
        .m_axi_bresp(axi_bresp),                            // input wire [1 : 0] m_axi_bresp
        .m_axi_buser(1'h0),                            // input wire [0 : 0] m_axi_buser
        .m_axi_bvalid(axi_bvalid),                          // input wire m_axi_bvalid
        .m_axi_bready(axi_bready),                          // output wire m_axi_bready
        .m_axi_arid(axi_arid),                              // output wire [0 : 0] m_axi_arid
        .m_axi_araddr(axi_araddr),                          // output wire [31 : 0] m_axi_araddr
        .m_axi_arlen(axi_arlen),                            // output wire [7 : 0] m_axi_arlen
        .m_axi_arsize(axi_arsize),                          // output wire [2 : 0] m_axi_arsize
        .m_axi_arburst(axi_arburst),                        // output wire [1 : 0] m_axi_arburst
        .m_axi_arlock(),                          // output wire [0 : 0] m_axi_arlock
        .m_axi_arcache(),                        // output wire [3 : 0] m_axi_arcache
        .m_axi_arprot(),                          // output wire [2 : 0] m_axi_arprot
        .m_axi_arqos(),                            // output wire [3 : 0] m_axi_arqos
        .m_axi_arregion(),                      // output wire [3 : 0] m_axi_arregion
        .m_axi_aruser(),                          // output wire [0 : 0] m_axi_aruser
        .m_axi_arvalid(axi_arvalid),                        // output wire m_axi_arvalid
        .m_axi_arready(axi_arready),                        // input wire m_axi_arready
        .m_axi_rid(1'h0),                                // input wire [0 : 0] m_axi_rid                    <----------------------------- NOT USED
        .m_axi_rdata(axi_rdata),                            // input wire [31 : 0] m_axi_rdata
        .m_axi_rresp(axi_rresp),                            // input wire [1 : 0] m_axi_rresp
        .m_axi_rlast(axi_rlast),                            // input wire m_axi_rlast
        .m_axi_ruser(1'h0),                            // input wire [0 : 0] m_axi_ruser                    <----------------------------- NOT USED
        .m_axi_rvalid(axi_rvalid),                          // input wire m_axi_rvalid
        .m_axi_rready(axi_rready),                          // output wire m_axi_rready

        .vfifo_mm2s_channel_full(vfifo_mm2s_channel_full),    // input wire [1 : 0] vfifo_mm2s_channel_full
        .vfifo_s2mm_channel_full(vfifo_s2mm_channel_full),    // output wire [1 : 0] vfifo_s2mm_channel_full
        .vfifo_mm2s_channel_empty(vfifo_mm2s_channel_empty),  // output wire [1 : 0] vfifo_mm2s_channel_empty
        .vfifo_idle(vfifo_idle)                              // output wire [1 : 0] vfifo_idle

//        .vfifo_mm2s_rresp_err_intr(vfifo_mm2s_rresp_err_intr),      // output wire vfifo_mm2s_rresp_err_intr
//        .vfifo_s2mm_bresp_err_intr(vfifo_s2mm_bresp_err_intr),      // output wire vfifo_s2mm_bresp_err_intr
//        .vfifo_s2mm_overrun_err_intr(vfifo_s2mm_overrun_err_intr)   // output wire vfifo_s2mm_overrun_err_intr
    );



    //*****************************************************************************
    //   ____  ____
    //  /   /\/   /
    // /___/  \  /   Vendor             : Xilinx
    // \   \   \/    Version            : 4.0
    //  \   \        Application        : MIG
    //  /   /        Filename           : mig_7series_0.veo
    // /___/   /\    Date Last Modified : $Date: 2011/06/02 08:34:47 $
    // \   \  /  \   Date Created       : Tue Sept 21 2010
    //  \___\/\___\
    //
    // Device           : 7 Series
    // Design Name      : DDR3 SDRAM
    // Purpose          : Template file containing code that can be used as a model
    //                    for instantiating a CORE Generator module in a HDL design.
    // Revision History :
    //*****************************************************************************
//    `ifdef 2017        
//    mig_7series_0 u_mig_7series_0 (
//    `elsif 2019
    ddr3 u_mig_7series_0 (
//    `endif
        // Memory interface ports
        .ddr3_addr                      (ddr3_addr),  // output [14:0]      ddr3_addr
        .ddr3_ba                        (ddr3_ba),  // output [2:0]     ddr3_ba
        .ddr3_cas_n                     (ddr3_cas_n),  // output            ddr3_cas_n
        .ddr3_ck_n                      (ddr3_ck_n),  // output [0:0]       ddr3_ck_n
        .ddr3_ck_p                      (ddr3_ck_p),  // output [0:0]       ddr3_ck_p
        .ddr3_cke                       (ddr3_cke),  // output [0:0]        ddr3_cke
        .ddr3_ras_n                     (ddr3_ras_n),  // output            ddr3_ras_n
        .ddr3_reset_n                   (ddr3_reset_n),  // output          ddr3_reset_n
        .ddr3_we_n                      (ddr3_we_n),  // output         ddr3_we_n
        .ddr3_dq                        (ddr3_dq),  // inout [63:0]     ddr3_dq
        .ddr3_dqs_n                     (ddr3_dqs_n),  // inout [7:0]       ddr3_dqs_n
        .ddr3_dqs_p                     (ddr3_dqs_p),  // inout [7:0]       ddr3_dqs_p
        .init_calib_complete            (init_calib_complete),  // output           init_calib_complete
          
        .ddr3_cs_n                      (ddr3_cs_n),  // output [0:0]       ddr3_cs_n
        .ddr3_dm                        (ddr3_dm),  // output [7:0]     ddr3_dm
        .ddr3_odt                       (ddr3_odt),  // output [0:0]        ddr3_odt
        // Application interface ports
        .ui_clk                         (ui_clk),  // output            ui_clk
        .ui_clk_sync_rst                (ui_clk_sync_rst),  // output           ui_clk_sync_rst
        .mmcm_locked                    (mmcm_locked),  // output           mmcm_locked
        .aresetn                        (aresetn),  // input            aresetn
        .app_sr_req                     (1'b0),  // input         app_sr_req
        .app_ref_req                    (1'b0),  // input            app_ref_req
        .app_zq_req                     (1'b0),  // input         app_zq_req
        .app_sr_active                  (app_sr_active),  // output         app_sr_active
        .app_ref_ack                    (app_ref_ack),  // output           app_ref_ack
        .app_zq_ack                     (app_zq_ack),  // output            app_zq_ack
        // Slave Interface Write Address Ports
        .s_axi_awid                     (axi_awid),  // input [2:0]           s_axi_awid
        .s_axi_awaddr                   (axi_awaddr),  // input [30:0]            s_axi_awaddr
        .s_axi_awlen                    (axi_awlen),  // input [7:0]          s_axi_awlen
        .s_axi_awsize                   (axi_awsize),  // input [2:0]         s_axi_awsize
        .s_axi_awburst                  (axi_awburst),  // input [1:0]            s_axi_awburst
        .s_axi_awlock                   (1'h0),  // input [0:0]         s_axi_awlock
        .s_axi_awcache                  (4'h0),  // input [3:0]            s_axi_awcache
        .s_axi_awprot                   (3'h0),  // input [2:0]         s_axi_awprot
        .s_axi_awqos                    (4'h0),  // input [3:0]          s_axi_awqos
        .s_axi_awvalid                  (axi_awvalid),  // input          s_axi_awvalid
        .s_axi_awready                  (axi_awready),  // output         s_axi_awready
        // Slave Interface Write Data Ports
        .s_axi_wdata                    (axi_wdata),  // input [63:0]         s_axi_wdata
        .s_axi_wstrb                    (axi_wstrb),  // input [7:0]          s_axi_wstrb
        .s_axi_wlast                    (axi_wlast),  // input            s_axi_wlast
        .s_axi_wvalid                   (axi_wvalid),  // input           s_axi_wvalid
        .s_axi_wready                   (axi_wready),  // output          s_axi_wready
        // Slave Interface Write Response Ports
        .s_axi_bid                      (axi_bid),  // output [2:0]           s_axi_bid
        .s_axi_bresp                    (axi_bresp),  // output [1:0]         s_axi_bresp
        .s_axi_bvalid                   (axi_bvalid),  // output          s_axi_bvalid
        .s_axi_bready                   (axi_bready),  // input           s_axi_bready
        // Slave Interface Read Address Ports
        .s_axi_arid                     (axi_arid),  // input [2:0]           s_axi_arid
        .s_axi_araddr                   (axi_araddr),  // input [30:0]            s_axi_araddr
        .s_axi_arlen                    (axi_arlen),  // input [7:0]          s_axi_arlen
        .s_axi_arsize                   (axi_arsize),  // input [2:0]         s_axi_arsize
        .s_axi_arburst                  (axi_arburst),  // input [1:0]            s_axi_arburst
        .s_axi_arlock                   (1'h0),  // input [0:0]         s_axi_arlock
        .s_axi_arcache                  (4'h0),  // input [3:0]            s_axi_arcache
        .s_axi_arprot                   (3'h0),  // input [2:0]         s_axi_arprot
        .s_axi_arqos                    (4'h4),  // input [3:0]          s_axi_arqos
        .s_axi_arvalid                  (axi_arvalid),  // input          s_axi_arvalid
        .s_axi_arready                  (axi_arready),  // output         s_axi_arready
        // Slave Interface Read Data Ports
        .s_axi_rid                      (axi_rid),  // output [2:0]           s_axi_rid
        .s_axi_rdata                    (axi_rdata),  // output [63:0]            s_axi_rdata
        .s_axi_rresp                    (axi_rresp),  // output [1:0]         s_axi_rresp
        .s_axi_rlast                    (axi_rlast),  // output           s_axi_rlast
        .s_axi_rvalid                   (axi_rvalid),  // output          s_axi_rvalid
        .s_axi_rready                   (axi_rready),  // input           s_axi_rready
        // System Clock Ports
        .sys_clk_i                      (sys_clk_i),    // clock for the init state machines etc.
//        .clk_ref_p                      (clk_ref_p),    // reference clock for the memory chip interface
//        .clk_ref_n                      (clk_ref_n),
        .sys_rst                        (sys_rst), // input sys_rst
        .device_temp_i                  (ddr3_fpga_temperature)  //TODO: could (should?) be connected to the XADC block for DDR timing temperature compensation
    );

endmodule
