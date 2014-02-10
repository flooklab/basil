/**
 * ------------------------------------------------------------
 * Copyright (c) SILAB , Physics Institute of Bonn University
 * ------------------------------------------------------------
 *
 * SVN revision information:
 *  $Rev::                       $:
 *  $Author::                    $:
 *  $Date::                      $:
 */
`timescale 1ps/1ps
`default_nettype none

module fei4_rx_core
#(
    parameter           DSIZE = 10,
    parameter           DATA_IDENTIFIER = 0
)
(
    input wire RX_CLK,
    input wire RX_CLK2X,
    input wire DATA_CLK,
    input wire RX_DATA,
    output wire RX_READY,
    output wire RX_8B10B_DECODER_ERR,
    output wire RX_FIFO_OVERFLOW_ERR,
     
    input wire FIFO_READ,
    output wire FIFO_EMPTY,
    output wire [31:0] FIFO_DATA,
    
    output wire RX_FIFO_FULL,

    input wire BUS_CLK,
    input wire [15:0] BUS_ADD,
    input wire [7:0] BUS_DATA_IN,
    output reg [7:0] BUS_DATA_OUT,
    input wire BUS_RST,
    input wire BUS_WR,
    input wire BUS_RD
);

// 0 - soft reset
// 1 - status
// 2-3 fifo size
// 4 - decoder_err_cnt
// 5 - lost_err_cnt

wire SOFT_RST;
assign SOFT_RST = (BUS_ADD==0 && BUS_WR);

// reset sync
// when write to addr = 0 then reset
reg RST_FF, RST_FF2, BUS_RST_FF, BUS_RST_FF2;
always @(posedge BUS_CLK) begin
    RST_FF <= SOFT_RST;
    RST_FF2 <= RST_FF;
    BUS_RST_FF <= BUS_RST;
    BUS_RST_FF2 <= BUS_RST_FF;
end

wire SOFT_RST_FLAG;
assign SOFT_RST_FLAG = ~RST_FF2 & RST_FF;
wire BUS_RST_FLAG;
assign BUS_RST_FLAG = BUS_RST_FF2 & ~BUS_RST_FF; // trailing edge
wire RST;
assign RST = BUS_RST_FLAG | SOFT_RST_FLAG;

wire ready_rec;
wire [15:0] fifo_size;
wire [7:0] decoder_err_cnt, lost_err_cnt;

assign RX_READY = (ready_rec==1'b1);
assign RX_8B10B_DECODER_ERR = (decoder_err_cnt!=8'b0);
assign RX_FIFO_OVERFLOW_ERR = (lost_err_cnt!=8'b0);

always @ (negedge BUS_CLK) begin //(*) begin
    //BUS_DATA_OUT = 0;

    if(BUS_ADD == 1)
        BUS_DATA_OUT <= {7'b0, RX_READY};
    else if(BUS_ADD == 2)
        BUS_DATA_OUT <= fifo_size[7:0];
    else if(BUS_ADD == 3)
        BUS_DATA_OUT <= fifo_size[15:8];
    else if(BUS_ADD == 4)
        BUS_DATA_OUT <= decoder_err_cnt;
    else if(BUS_ADD == 5)
        BUS_DATA_OUT <= lost_err_cnt;
    else if(BUS_ADD == 6)
        BUS_DATA_OUT <= 8'b0;
    else if(BUS_ADD == 7)
        BUS_DATA_OUT <= 8'b0;
    else
        BUS_DATA_OUT <= 0;
end

wire [23:0] FE_DATA;
wire [7:0] DATA_HEADER;
assign DATA_HEADER = DATA_IDENTIFIER;
assign FIFO_DATA = {DATA_HEADER, FE_DATA};

receiver_logic #(
    .DSIZE(DSIZE)
) ireceiver_logic (
    .RESET(RST),
    .WCLK(DATA_CLK),
    .FCLK(RX_CLK),
    .FCLK2X(RX_CLK2X),
    .BUS_CLK(BUS_CLK),
    .RX_DATA(RX_DATA),
    .read(FIFO_READ),
    .data(FE_DATA),
    .empty(FIFO_EMPTY),
    .full(RX_FIFO_FULL),
    .rec_sync_ready(ready_rec),
    .lost_err_cnt(lost_err_cnt),
    .decoder_err_cnt(decoder_err_cnt),
    .fifo_size(fifo_size)
);

//assign fei4_rx_d = {11'b0};

endmodule