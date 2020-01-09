onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group tb /tb/BUS_CLK
add wave -noupdate -expand -group tb /tb/BUS_RST
add wave -noupdate -expand -group tb /tb/BUS_ADD
add wave -noupdate -expand -group tb /tb/BUS_DATA
add wave -noupdate -expand -group tb /tb/BUS_RD
add wave -noupdate -expand -group tb /tb/BUS_WR
add wave -noupdate -expand -group tb /tb/start_veto
add wave -noupdate -expand -group tb -color Gold -itemcolor Gold /tb/ddr_init_done
add wave -noupdate -expand -group tb /tb/vfifo_data_out_valid
add wave -noupdate -expand -group tb /tb/vfifo_empty
add wave -noupdate -expand -group tb /tb/vfifo_full
add wave -noupdate -expand -group tb /tb/vfifo_data_out
add wave -noupdate -expand -group tb /tb/sys_clk_i
add wave -noupdate -expand -group tb /tb/clk_tb
add wave -noupdate -expand -group tb /tb/reset
add wave -noupdate -expand -group tb /tb/aresetn
add wave -noupdate -expand -group tb /tb/ext_s_axis_tvalid
add wave -noupdate -expand -group tb /tb/ext_s_axis_tready
add wave -noupdate -expand -group tb /tb/ext_s_axis_tlast
add wave -noupdate -expand -group tb /tb/ext_s_axis_tdata
add wave -noupdate -expand -group tb /tb/ext_s_axis_tdest
add wave -noupdate -expand -group tb /tb/ext_m_axis_tvalid
add wave -noupdate -expand -group tb /tb/ext_m_axis_tready
add wave -noupdate -expand -group tb /tb/ext_m_axis_tlast
add wave -noupdate -expand -group tb /tb/ext_m_axis_tdata
add wave -noupdate -expand -group tb /tb/ext_m_axis_tdest
add wave -noupdate -expand -group tb /tb/ext_vfifo_mm2s_channel_full
add wave -noupdate -expand -group tb /tb/ext_vfifo_s2mm_channel_full
add wave -noupdate -expand -group tb /tb/ext_vfifo_mm2s_channel_empty
add wave -noupdate -expand -group tb /tb/ext_vfifo_idle
add wave -noupdate -expand -group tb /tb/vfifo_mm2s_rresp_err_intr
add wave -noupdate -expand -group tb /tb/vfifo_s2mm_bresp_err_intr
add wave -noupdate -expand -group tb /tb/vfifo_s2mm_overrun_err_intr
add wave -noupdate -expand -group tb /tb/ddr3_addr_sdram
add wave -noupdate -expand -group tb /tb/ddr3_ba_sdram
add wave -noupdate -expand -group tb /tb/ddr3_cas_n_sdram
add wave -noupdate -expand -group tb /tb/ddr3_ck_n_sdram
add wave -noupdate -expand -group tb /tb/ddr3_ck_p_sdram
add wave -noupdate -expand -group tb /tb/ddr3_cke_sdram
add wave -noupdate -expand -group tb /tb/ddr3_ras_n_sdram
add wave -noupdate -expand -group tb /tb/ddr3_reset_n
add wave -noupdate -expand -group tb /tb/ddr3_we_n_sdram
add wave -noupdate -expand -group tb /tb/ddr3_dq_sdram
add wave -noupdate -expand -group tb /tb/ddr3_dqs_n_sdram
add wave -noupdate -expand -group tb /tb/ddr3_dqs_p_sdram
add wave -noupdate -expand -group tb /tb/ddr3_cs_n_sdram
add wave -noupdate -expand -group tb /tb/ddr3_dm_sdram
add wave -noupdate -expand -group tb /tb/ddr3_odt_sdram
add wave -noupdate -expand -group tb /tb/read
add wave -noupdate -expand -group tb /tb/write
add wave -noupdate -expand -group tb /tb/data_in
add wave -noupdate -expand -group tb /tb/data_out
add wave -noupdate -expand -group tb /tb/empty
add wave -noupdate -expand -group tb /tb/full
add wave -noupdate -expand -group tb /tb/data_from_fifo
add wave -noupdate -expand -group tb /tb/data_to_fifo
add wave -noupdate -expand -group tb /tb/int_data_to_fifo
add wave -noupdate -expand -group tb /tb/wr_word_cnt
add wave -noupdate -expand -group tb /tb/wr_word_cnt_temp
add wave -noupdate -expand -group tb /tb/wr_wait_cnt
add wave -noupdate -expand -group tb /tb/wr_timeout
add wave -noupdate -expand -group tb /tb/rd_word_cnt
add wave -noupdate -expand -group tb /tb/rd_wait_cnt_temp
add wave -noupdate -expand -group tb /tb/rd_wait_cnt
add wave -noupdate -expand -group tb /tb/rd_timeout
add wave -noupdate -expand -group tb /tb/int_m_axis_tlast_delay
add wave -noupdate -expand -group tb /tb/int_s_axis_tdest
add wave -noupdate -expand -group tb -color Gold -itemcolor Gold /tb/init_calib_complete
add wave -noupdate -expand -group tb /tb/runs
add wave -noupdate -expand -group tb /tb/int_m_axis_tready
add wave -noupdate -expand -group tb /tb/int_s_axis_tvalid
add wave -noupdate -expand -group tb /tb/int_s_axis_tvalid_delay
add wave -noupdate -expand -group tb /tb/int_s_axis_tlast
add wave -noupdate -expand -group tb /tb/int_s_axis_tlast_delay
add wave -noupdate -expand -group tb /tb/int_burst_strobe
add wave -noupdate -expand -group tb /tb/data_ch0
add wave -noupdate -expand -group tb /tb/data_ch1
add wave -noupdate -expand -group tb /tb/state
add wave -noupdate -expand -group tb /tb/mmcm_locked
add wave -noupdate -expand -group tb /tb/IO
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/aclk
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/aresetn
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/s_axis_tvalid
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/s_axis_tready
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/s_axis_tdata
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/s_axis_tstrb
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/s_axis_tkeep
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/s_axis_tlast
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/s_axis_tid
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/s_axis_tdest
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axis_tvalid
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axis_tready
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axis_tdata
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axis_tstrb
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axis_tkeep
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axis_tlast
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axis_tid
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axis_tdest
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axi_awid
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axi_awaddr
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axi_awlen
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axi_awsize
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axi_awburst
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axi_awlock
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axi_awcache
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axi_awprot
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axi_awqos
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axi_awregion
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axi_awuser
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axi_awvalid
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axi_awready
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axi_wdata
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axi_wstrb
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axi_wlast
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axi_wuser
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axi_wvalid
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axi_wready
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axi_bid
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axi_bresp
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axi_buser
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axi_bvalid
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axi_bready
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axi_arid
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axi_araddr
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axi_arlen
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axi_arsize
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axi_arburst
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axi_arlock
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axi_arcache
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axi_arprot
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axi_arqos
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axi_arregion
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axi_aruser
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axi_arvalid
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axi_arready
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axi_rid
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axi_rdata
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axi_rresp
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axi_rlast
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axi_ruser
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axi_rvalid
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/m_axi_rready
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/vfifo_mm2s_channel_full
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/vfifo_s2mm_channel_full
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/vfifo_mm2s_channel_empty
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/vfifo_idle
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/NLW_U0_vfifo_mm2s_rresp_err_intr_UNCONNECTED
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/NLW_U0_vfifo_s2mm_bresp_err_intr_UNCONNECTED
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/NLW_U0_vfifo_s2mm_overrun_err_intr_UNCONNECTED
add wave -noupdate -group vfifo /tb/i_axi_ddrvfifo/virtual_fifo_inst/NLW_U0_m_axis_tuser_UNCONNECTED
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/ddr3_dq
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/ddr3_dqs_n
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/ddr3_dqs_p
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/ddr3_addr
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/ddr3_ba
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/ddr3_ras_n
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/ddr3_cas_n
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/ddr3_we_n
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/ddr3_reset_n
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/ddr3_ck_p
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/ddr3_ck_n
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/ddr3_cke
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/ddr3_cs_n
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/ddr3_dm
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/ddr3_odt
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/sys_clk_i
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/ui_clk
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/ui_clk_sync_rst
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/mmcm_locked
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/aresetn
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/app_sr_req
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/app_ref_req
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/app_zq_req
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/app_sr_active
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/app_ref_ack
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/app_zq_ack
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/s_axi_awid
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/s_axi_awaddr
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/s_axi_awlen
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/s_axi_awsize
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/s_axi_awburst
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/s_axi_awlock
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/s_axi_awcache
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/s_axi_awprot
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/s_axi_awqos
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/s_axi_awvalid
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/s_axi_awready
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/s_axi_wdata
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/s_axi_wstrb
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/s_axi_wlast
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/s_axi_wvalid
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/s_axi_wready
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/s_axi_bready
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/s_axi_bid
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/s_axi_bresp
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/s_axi_bvalid
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/s_axi_arid
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/s_axi_araddr
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/s_axi_arlen
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/s_axi_arsize
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/s_axi_arburst
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/s_axi_arlock
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/s_axi_arcache
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/s_axi_arprot
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/s_axi_arqos
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/s_axi_arvalid
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/s_axi_arready
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/s_axi_rready
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/s_axi_rid
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/s_axi_rdata
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/s_axi_rresp
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/s_axi_rlast
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/s_axi_rvalid
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/init_calib_complete
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/device_temp_i
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/device_temp
add wave -noupdate -group mig /tb/i_axi_ddrvfifo/u_mig_7series_0/sys_rst
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1249620 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 394
configure wave -valuecolwidth 94
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {10300698 ps}
