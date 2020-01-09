/**
 * ------------------------------------------------------------
 * Copyright (c) All rights reserved
 * SiLab, Physics Institute, University of Bonn
 * ------------------------------------------------------------
 */

`include "utils/fifo_32_to_8.v"
`include "utils/generic_fifo.v"
`include "utils/rgmii_io.v"
`include "utils/rbcp_to_bus.v"
`include "utils/bus_to_ip.v"

`include "axi_ddrvfifo.v"


module bdaq53_eth_throughput_test(
    input wire RESET_BUTTON,
    input wire clkin,
    input wire CLK200_P, CLK200_N,

    output wire [3:0] rgmii_txd,
    output wire rgmii_tx_ctl,
    output wire rgmii_txc,
    input wire [3:0] rgmii_rxd,
    input wire rgmii_rx_ctl,
    input wire rgmii_rxc,
    output wire mdio_phy_mdc,
    inout wire mdio_phy_mdio,
    output wire phy_rst_n,

    output wire [7:0] LED,

    // DDR3 Memory Interface
    output wire [14:0]  ddr3_addr,
    output wire [2:0]   ddr3_ba,
    output wire         ddr3_cas_n,
    output wire         ddr3_ras_n,
    output wire [0:0]   ddr3_ck_n, ddr3_ck_p,
    output wire [0:0]   ddr3_cke,
    output wire         ddr3_reset_n,
    inout  wire [63:0]  ddr3_dq,
    inout  wire [7:0]   ddr3_dqs_n, ddr3_dqs_p,
    output wire [7:0]   ddr3_dm,
    output wire         ddr3_we_n,
    output wire [0:0]   ddr3_cs_n,
    output wire [0:0]   ddr3_odt
);

wire RESET_N;
assign RESET_N = RESET_BUTTON;
wire RESET;
assign RESET = ~RESET_N;

wire BUS_CLK_PLL, CLK125PLLTX, CLK125PLLTX90;
wire PLL_FEEDBACK, LOCKED;

PLLE2_BASE #(
    .BANDWIDTH("OPTIMIZED"),  // OPTIMIZED, HIGH, LOW
    .CLKFBOUT_MULT(10),       // Multiply value for all CLKOUT, (2-64)
    .CLKFBOUT_PHASE(0.0),     // Phase offset in degrees of CLKFB, (-360.000-360.000).
    .CLKIN1_PERIOD(10.000),      // Input clock period in ns to ps resolution (i.e. 33.333 is 30 MHz).

    .CLKOUT0_DIVIDE(7),     // Divide amount for CLKOUT0 (1-128)
    .CLKOUT0_DUTY_CYCLE(0.5), // Duty cycle for CLKOUT0 (0.001-0.999).
    .CLKOUT0_PHASE(0.0),      // Phase offset for CLKOUT0 (-360.000-360.000).

    .CLKOUT1_DIVIDE(4),     // Divide amount for CLKOUT0 (1-128)
    .CLKOUT1_DUTY_CYCLE(0.5), // Duty cycle for CLKOUT0 (0.001-0.999).
    .CLKOUT1_PHASE(0.0),      // Phase offset for CLKOUT0 (-360.000-360.000).

    .CLKOUT2_DIVIDE(8),     // Divide amount for CLKOUT0 (1-128)
    .CLKOUT2_DUTY_CYCLE(0.5), // Duty cycle for CLKOUT0 (0.001-0.999).
    .CLKOUT2_PHASE(0.0),      // Phase offset for CLKOUT0 (-360.000-360.000).

    .CLKOUT3_DIVIDE(8),     // Divide amount for CLKOUT0 (1-128)
    .CLKOUT3_DUTY_CYCLE(0.5), // Duty cycle for CLKOUT0 (0.001-0.999).
    .CLKOUT3_PHASE(90.0),      // Phase offset for CLKOUT0 (-360.000-360.000).

    .CLKOUT4_DIVIDE(8),     // Divide amount for CLKOUT0 (1-128)
    .CLKOUT4_DUTY_CYCLE(0.5), // Duty cycle for CLKOUT0 (0.001-0.999).
    .CLKOUT4_PHASE(-5.625),      // Phase offset for CLKOUT0 (-360.000-360.000).
    //-65 -> 0?; - 45 -> 39;  -25 -> 100; -5 -> 0;

    .DIVCLK_DIVIDE(1),        // Master division value, (1-56)
    .REF_JITTER1(0.0),        // Reference input jitter in UI, (0.000-0.999).
    .STARTUP_WAIT("FALSE")     // Delay DONE until PLL Locks, ("TRUE"/"FALSE")
 )
 PLLE2_BASE_inst (

     .CLKOUT0(BUS_CLK_PLL),
     .CLKOUT1(),
     .CLKOUT2(CLK125PLLTX),
     .CLKOUT3(CLK125PLLTX90),
     .CLKOUT4(),
     .CLKOUT5(),

     .CLKFBOUT(PLL_FEEDBACK),

     .LOCKED(LOCKED),     // 1-bit output: LOCK

     // Input 100 MHz clock
     .CLKIN1(clkin),

     // Control Ports
     .PWRDWN(0),
     .RST(RESET),

     // Feedback
     .CLKFBIN(PLL_FEEDBACK)
 );


wire BUS_CLK;
BUFG BUFG_inst_BUS_CKL    (.O(BUS_CLK),     .I(BUS_CLK_PLL)   );

wire CLK125TX, CLK125TX90, CLK125RX;
BUFG BUFG_inst_CLK125TX   ( .O(CLK125TX),   .I(CLK125PLLTX)   );
BUFG BUFG_inst_CLK125TX90 ( .O(CLK125TX90), .I(CLK125PLLTX90) );
BUFG BUFG_inst_CLK125RX   ( .O(CLK125RX),   .I(rgmii_rxc)     );

wire CLK200_buf;
IBUFDS #(
    .DIFF_TERM("FALSE"),       // Differential Termination
    .IBUF_LOW_PWR("FALSE"),    // Low power="TRUE", Highest performance="FALSE"
    .IOSTANDARD("DEFAULT")     // Specify the input I/O standard
) IBUFDS_inst (
    .O(CLK200_buf),    // Buffer output
    .I(CLK200_P),     // Diff_p buffer input (connect directly to top-level port)
    .IB(CLK200_N)     // Diff_n buffer input (connect directly to top-level port)
);


wire   gmii_tx_clk;
wire   gmii_tx_en;
wire  [7:0] gmii_txd;
wire   gmii_tx_er;
wire   gmii_crs;
wire   gmii_col;
wire   gmii_rx_clk;
wire   gmii_rx_dv;
wire  [7:0] gmii_rxd;
wire   gmii_rx_er;
wire   mdio_gem_mdc;
wire   mdio_gem_i;
wire   mdio_gem_o;
wire   mdio_gem_t;
wire   link_status;
wire  [1:0] clock_speed;
wire   duplex_status;

rgmii_io rgmii
(
    .rgmii_txd(rgmii_txd),
    .rgmii_tx_ctl(rgmii_tx_ctl),
    .rgmii_txc(rgmii_txc),

    .rgmii_rxd(rgmii_rxd),
    .rgmii_rx_ctl(rgmii_rx_ctl),

    .gmii_txd_int(gmii_txd),      // Internal gmii_txd signal.
    .gmii_tx_en_int(gmii_tx_en),
    .gmii_tx_er_int(gmii_tx_er),
    .gmii_col_int(gmii_col),
    .gmii_crs_int(gmii_crs),
    .gmii_rxd_reg(gmii_rxd),   // RGMII double data rate data valid.
    .gmii_rx_dv_reg(gmii_rx_dv), // gmii_rx_dv_ibuf registered in IOBs.
    .gmii_rx_er_reg(gmii_rx_er), // gmii_rx_er_ibuf registered in IOBs.

    .eth_link_status(link_status),
    .eth_clock_speed(clock_speed),
    .eth_duplex_status(duplex_status),

    // Following are generated by DCMs
    .tx_rgmii_clk_int(CLK125TX),     // Internal RGMII transmitter clock.
    .tx_rgmii_clk90_int(CLK125TX90),   // Internal RGMII transmitter clock w/ 90 deg phase
    .rx_rgmii_clk_int(CLK125RX),     // Internal RGMII receiver clock

    .reset(!phy_rst_n)
);


// Instantiate tri-state buffer for MDIO
IOBUF i_iobuf_mdio(
    .O(mdio_gem_i),
    .IO(mdio_phy_mdio),
    .I(mdio_gem_o),
    .T(mdio_gem_t));

wire EEPROM_CS, EEPROM_SK, EEPROM_DI;

wire TCP_CLOSE_REQ;
wire TCP_OPEN_ACK;
wire RBCP_ACT, RBCP_WE, RBCP_RE;
wire [7:0] RBCP_WD, RBCP_RD;
wire [31:0] RBCP_ADDR;
wire TCP_RX_WR;
wire TCP_TX_WR;
wire [7:0] TCP_RX_DATA;
wire [7:0] TCP_TX_DATA;
wire TCP_TX_FULL;
wire RBCP_ACK;
wire SiTCP_RST;
reg [10:0] TCP_RX_WC_11B;


WRAP_SiTCP_GMII_XC7K_32K #(
    .TIM_PERIOD (8'd142)
) sitcp (
    .CLK(BUS_CLK)               ,    // in    : System Clock >129MHz
    .RST(RESET | !LOCKED)       ,    // in    : System reset
    // Configuration parameters
    .FORCE_DEFAULTn(1'b0)       ,    // in    : Load default parameters
    .EXT_IP_ADDR(32'hc0a80a10)  ,    // in    : IP address[31:0] //192.168.10.16
    .EXT_TCP_PORT(16'd24)       ,    // in    : TCP port #[15:0]
    .EXT_RBCP_PORT(16'd4660)    ,    // in    : RBCP port #[15:0]
    .PHY_ADDR(5'd3)             ,    // in    : PHY-device MIF address[4:0]
    // EEPROM
    .EEPROM_CS(EEPROM_CS)       ,    // out    : Chip select
    .EEPROM_SK(EEPROM_SK)       ,    // out    : Serial data clock
    .EEPROM_DI(EEPROM_DI)       ,    // out    : Serial write data
    .EEPROM_DO(1'b0)            ,    // in    : Serial read data
    // user data, intialial values are stored in the EEPROM, 0xFFFF_FC3C-3F
    .USR_REG_X3C()              ,    // out    : Stored at 0xFFFF_FF3C
    .USR_REG_X3D()              ,    // out    : Stored at 0xFFFF_FF3D
    .USR_REG_X3E()              ,    // out    : Stored at 0xFFFF_FF3E
    .USR_REG_X3F()              ,    // out    : Stored at 0xFFFF_FF3F
    // MII interface
    .GMII_RSTn(phy_rst_n)       ,    // out    : PHY reset
    .GMII_1000M(1'b1)           ,    // in    : GMII mode (0:MII, 1:GMII)
    // TX
    .GMII_TX_CLK(CLK125TX)      ,    // in    : Tx clock
    .GMII_TX_EN(gmii_tx_en)     ,    // out    : Tx enable
    .GMII_TXD(gmii_txd)         ,    // out    : Tx data[7:0]
    .GMII_TX_ER(gmii_tx_er)     ,    // out    : TX error
    // RX
    .GMII_RX_CLK(CLK125RX)      ,    // in    : Rx clock
    .GMII_RX_DV(gmii_rx_dv)     ,    // in    : Rx data valid
    .GMII_RXD(gmii_rxd)         ,    // in    : Rx data[7:0]
    .GMII_RX_ER(gmii_rx_er)     ,    // in    : Rx error
    .GMII_CRS(gmii_crs)         ,    // in    : Carrier sense
    .GMII_COL(gmii_col)         ,    // in    : Collision detected
    // Management IF
    .GMII_MDC(mdio_phy_mdc)     ,    // out    : Clock for MDIO
    .GMII_MDIO_IN(mdio_gem_i)   ,    // in    : Data
    .GMII_MDIO_OUT(mdio_gem_o)  ,    // out    : Data
    .GMII_MDIO_OE(mdio_gem_t)   ,    // out    : MDIO output enable
    // User I/F
    .SiTCP_RST(SiTCP_RST)       ,    // out    : Reset for SiTCP and related circuits
    // TCP connection control
    .TCP_OPEN_REQ(1'b0)         ,    // in    : Reserved input, shoud be 0
    .TCP_OPEN_ACK(TCP_OPEN_ACK) ,    // out    : Acknowledge for open (=Socket busy)
    .TCP_ERROR()                ,    // out    : TCP error, its active period is equal to MSL
    .TCP_CLOSE_REQ(TCP_CLOSE_REQ)    ,    // out    : Connection close request
    .TCP_CLOSE_ACK(TCP_CLOSE_REQ)    ,    // in    : Acknowledge for closing
    // FIFO I/F
    .TCP_RX_WC({5'b1,TCP_RX_WC_11B}) ,    // in    : Rx FIFO write count[15:0] (Unused bits should be set 1)
    .TCP_RX_WR(TCP_RX_WR)            ,    // out    : Write enable
    .TCP_RX_DATA(TCP_RX_DATA)   ,    // out    : Write data[7:0]
    .TCP_TX_FULL(TCP_TX_FULL)   ,    // out    : Almost full flag
    .TCP_TX_WR(TCP_TX_WR)       ,    // in    : Write enable
    .TCP_TX_DATA(TCP_TX_DATA)   ,    // in    : Write data[7:0]
    // RBCP
    .RBCP_ACT(RBCP_ACT)         ,    // out    : RBCP active
    .RBCP_ADDR(RBCP_ADDR)       ,    // out    : Address[31:0]
    .RBCP_WD(RBCP_WD)           ,    // out    : Data[7:0]
    .RBCP_WE(RBCP_WE)           ,    // out    : Write enable
    .RBCP_RE(RBCP_RE)           ,    // out    : Read enable
    .RBCP_ACK(RBCP_ACK)         ,    // in    : Access acknowledge
    .RBCP_RD(RBCP_RD)                // in    : Read data[7:0]
);


wire BUS_WR, BUS_RD, BUS_RST;
wire [31:0] BUS_ADD;
wire [7:0] BUS_DATA;
assign BUS_RST = SiTCP_RST;

rbcp_to_bus irbcp_to_bus(
    .BUS_RST(BUS_RST),
    .BUS_CLK(BUS_CLK),

    .RBCP_ACT(RBCP_ACT),
    .RBCP_ADDR(RBCP_ADDR),
    .RBCP_WD(RBCP_WD),
    .RBCP_WE(RBCP_WE),
    .RBCP_RE(RBCP_RE),
    .RBCP_ACK(RBCP_ACK),
    .RBCP_RD(RBCP_RD),

    .BUS_WR(BUS_WR),
    .BUS_RD(BUS_RD),
    .BUS_ADD(BUS_ADD),
    .BUS_DATA(BUS_DATA)
    );

reg [63:0] DDR_FIFO_OUT;
wire [63:0] DDR_FIFO_IN;
wire DDR_FIFO_WRITE;
wire DDR_FIFO_FULL;

wire fifo_empty, fifo_full, fifo_write;
reg fifo_next;

wire [7:0] GPIO;

fifo_32_to_8 #(.DEPTH(256*1024)) i_data_fifo (
    .RST(BUS_RST),
    .CLK(BUS_CLK),

    .WRITE(fifo_write),
    .READ(TCP_TX_WR),
    .DATA_IN(DDR_FIFO_OUT),
    .FULL(fifo_full),
    .EMPTY(fifo_empty),
    .DATA_OUT(TCP_TX_DATA)
);


bdaq53_eth_core i_bdaq53_eth_core(
    .RESET_N(RESET_N),

    // clocks from PLL
    .BUS_CLK(BUS_CLK),
    .PLL_LOCKED(LOCKED),

    .BUS_RST(BUS_RST),
    .BUS_ADD(BUS_ADD),
    .BUS_DATA(BUS_DATA),
    .BUS_RD(BUS_RD),
    .BUS_WR(BUS_WR),

    .fifo_full(DDR_FIFO_FULL),
    .FIFO_DATA(DDR_FIFO_IN),
    .FIFO_WRITE(DDR_FIFO_WRITE),

    .GPIO(GPIO)
    );


assign TCP_TX_WR = !TCP_TX_FULL && !fifo_empty;

reg ETH_START_SENDING, ETH_START_SENDING_temp, ETH_START_SENDING_LOCK;

// FIFO-style interface
wire        EMPTY;
wire        FULL;
wire [31:0] DATA_OUT;
wire [31:0] DATA_IN;
wire        READ;
wire        WRITE;
wire        TLAST;

// VFIFO status lines
wire [1:0]  vfifo_mm2s_channel_full;
wire [1:0]  vfifo_s2mm_channel_full;
wire [1:0]  vfifo_mm2s_channel_empty;
wire [1:0]  vfifo_idle;

wire vfifo_mm2s_rresp_err_intr;      // output wire vfifo_mm2s_rresp_err_intr
wire vfifo_s2mm_bresp_err_intr;      // output wire vfifo_s2mm_bresp_err_intr
wire vfifo_s2mm_overrun_err_intr;   // output wire vfifo_s2mm_overrun_err_intr

wire init_calib_complete;

 // Slave AXI stream ports
reg         s_axis_tvalid;      // input wire s_axis_tvalid
wire        s_axis_tready;      // output wire s_axis_tready
reg [31:0]  s_axis_tdata;       // input wire [31 : 0] s_axis_tdata
reg         s_axis_tlast;       // input wire s_axis_tlast
reg [0:0]   s_axis_tdest;       // input wire [0:0] s_axis_tdest

// Master AXI stream ports
wire        m_axis_tvalid;      // output wire m_axis_tvalid
reg         m_axis_tready;      // input wire m_axis_tready
wire [31:0] m_axis_tdata;       // output wire [31 : 0] m_axis_tdata
wire        m_axis_tlast;       // output wire m_axis_tlast
wire [0:0]  m_axis_tdest;       // output wire [0:0] m_axis_tdest

assign vfifo_mm2s_channel_full = 2'h00;

wire mmcm_locked;
wire mig_axi_wvalid, mig_axi_wready, mig_axi_rvalid, mig_axi_rready;

wire vfifo_empty, vfifo_full;
assign vfifo_empty = (vfifo_mm2s_channel_empty == 2'b11) ? 1'b1 : 1'b0;
assign vfifo_full  = (vfifo_s2mm_channel_full  != 2'b00) ? 1'b1 : 1'b0;

assign DDR_FIFO_FULL = vfifo_full;


axi_ddrvfifo i_axi_ddrvfifo (
    // BASIL BUS signals
    .aclk(BUS_CLK),
    .aresetn(!(RESET | !LOCKED)),
    
    // DDR3 controller clock (200 MHz)
    .sys_clk_i(CLK200_buf),

    //Generic FIFO style interface
    .read(),
    .write(),
    .data_in(),
    .data_out(),
    .empty(),
    .full(),
    
    //VFIFO status lines
    .ext_vfifo_mm2s_channel_full(vfifo_mm2s_channel_full),
    .ext_vfifo_s2mm_channel_full(vfifo_s2mm_channel_full),
    .ext_vfifo_mm2s_channel_empty(vfifo_mm2s_channel_empty),
    .ext_vfifo_idle(vfifo_idle),
    .vfifo_mm2s_rresp_err_intr(),      // output wire vfifo_mm2s_rresp_err_intr
    .vfifo_s2mm_bresp_err_intr(),      // output wire vfifo_s2mm_bresp_err_intr
    .vfifo_s2mm_overrun_err_intr(),  // output wire vfifo_s2mm_overrun_err_intr
            
     //Slave AXI stream ports
    .ext_s_axis_tvalid(s_axis_tvalid),      // input wire s_axis_tvalid
    .ext_s_axis_tready(s_axis_tready),      // output wire s_axis_tready
    .ext_s_axis_tdata(s_axis_tdata),        // input wire [63 : 0] s_axis_tdata
    .ext_s_axis_tlast(s_axis_tlast),        // input wire s_axis_tlast
    .ext_s_axis_tdest(s_axis_tdest),

    //Master AXI stream ports  
    .ext_m_axis_tvalid(m_axis_tvalid),      // output wire m_axis_tvalid
    .ext_m_axis_tready(m_axis_tready),      // input wire m_axis_tready
    .ext_m_axis_tdata(m_axis_tdata),        // output wire [63 : 0] m_axis_tdata
    .ext_m_axis_tlast(m_axis_tlast),         // output wire m_axis_tlast
    .ext_m_axis_tdest(m_axis_tdest),
    
    // Memory interface ports
    .ddr3_addr(ddr3_addr),    // output [14:0]    ddr3_addr
    .ddr3_ba(ddr3_ba),        // output [2:0]		ddr3_ba
    .ddr3_cas_n(ddr3_cas_n),  // output			ddr3_cas_n
    .ddr3_ck_n(ddr3_ck_n),    // output [0:0]		ddr3_ck_n
    .ddr3_ck_p(ddr3_ck_p),    // output [0:0]		ddr3_ck_p
    .ddr3_cke(ddr3_cke),      // output [0:0]		ddr3_cke
    .ddr3_ras_n(ddr3_ras_n),  // output			ddr3_ras_n
    .ddr3_reset_n(ddr3_reset_n),    // output			ddr3_reset_n
    .ddr3_we_n(ddr3_we_n),    // output			ddr3_we_n
    .ddr3_dq(ddr3_dq),        // inout [63:0]		ddr3_dq
    .ddr3_dqs_n(ddr3_dqs_n),  // inout [7:0]		ddr3_dqs_n
    .ddr3_dqs_p(ddr3_dqs_p),  // inout [7:0]		ddr3_dqs_p
    .ddr3_cs_n(ddr3_cs_n),    // output [0:0]		ddr3_cs_n
    .ddr3_dm(ddr3_dm),        // output [7:0]		ddr3_dm
    .ddr3_odt(ddr3_odt),      // output [0:0]		ddr3_odt
    .ddr3_fpga_temperature(),
    .init_calib_complete(init_calib_complete),
    .mmcm_locked(mmcm_locked)
);


reg [31:0] datasource;

// ------ Main FSM ------ //
always@ (posedge BUS_CLK) begin
    if (RESET | !init_calib_complete) begin
        s_axis_tvalid <= 1'b0;
        s_axis_tlast <= 1'b0;
        s_axis_tdest <= 1'h0;
        m_axis_tready <= 1'b0;
        datasource <= 32'd0;
    end
    else begin
        // wait for start condition
        ETH_START_SENDING <= GPIO[0];    //TCP_OPEN_ACK;

        if(ETH_START_SENDING && !ETH_START_SENDING_temp)
            ETH_START_SENDING_LOCK <= 1;
        ETH_START_SENDING_temp <= ETH_START_SENDING;  

        // RX FIFO word counter
        if(TCP_RX_WR) begin
            TCP_RX_WC_11B <= TCP_RX_WC_11B + 1;
        end
        else begin
            TCP_RX_WC_11B <= 11'd0;
        end

        // WRITE FIFO
        if(ETH_START_SENDING_LOCK && init_calib_complete) begin
            // Fill DDR FIFO with counter data
            if (s_axis_tready && !vfifo_full) begin
                s_axis_tdata <= DDR_FIFO_IN;
                s_axis_tvalid <= DDR_FIFO_WRITE;
            end
        end
        else begin
            s_axis_tvalid <= 1'b0;
            s_axis_tlast <= 1'b0;
        end
    
        // READ FIFO
        if(m_axis_tvalid & !fifo_full) begin
            m_axis_tready <= 1'b1;
            DDR_FIFO_OUT <= m_axis_tdata;
        end
        else begin
            m_axis_tready <= 1'b0;
        end

        // stop, if connection is closed by host
        if(TCP_CLOSE_REQ || !GPIO[0]) begin
            ETH_START_SENDING_LOCK <= 0;
            m_axis_tready <= 1'b0;
            s_axis_tvalid <= 1'b0;
            s_axis_tlast <= 1'b1;
        end
    end
end


/* -------  Main FSM  ------- */
/*always @(posedge BUS_CLK)
    begin

    // wait for start condition
    ETH_START_SENDING <= GPIO[0];    //TCP_OPEN_ACK;

    if(ETH_START_SENDING && !ETH_START_SENDING_temp)
        ETH_START_SENDING_LOCK <= 1;
    ETH_START_SENDING_temp <= ETH_START_SENDING;

    // RX FIFO word counter
    if(TCP_RX_WR) begin
        TCP_RX_WC_11B <= TCP_RX_WC_11B + 1;
    end
    else begin
        TCP_RX_WC_11B <= 11'd0;
    end

    // stop, if connection is closed by host
    if(TCP_CLOSE_REQ || !GPIO[0]) begin
        ETH_START_SENDING_LOCK <= 0;
    end

end
*/

//assign LED = ~{TCP_OPEN_ACK, TCP_CLOSE_REQ, TCP_RX_WR, TCP_TX_WR, fifo_full, fifo_empty, fifo_write, TCP_TX_WR};    //GPIO_IO[3:0]};
assign LED = ~{ mmcm_locked, init_calib_complete, vfifo_empty, vfifo_full,
                s_axis_tready, s_axis_tvalid, m_axis_tready, m_axis_tvalid };

endmodule
