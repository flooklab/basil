
module seq_gen
#(
    parameter MEM_BYTES = 16384,
    parameter OUT_BITS = 16 //4,8,16,32
)(
    BUS_CLK,                     
    BUS_RST,                  
    BUS_ADD,                    
    BUS_DATA_IN,                    
    BUS_RD,                    
    BUS_WR,                    
    BUS_DATA_OUT,  

    SEQ_CLK,
    SEQ_OUT
); 

input                       BUS_CLK;
input                       BUS_RST;
input      [15:0]           BUS_ADD;
input      [7:0]            BUS_DATA_IN;
input                       BUS_RD;
input                       BUS_WR;
output     reg [7:0]        BUS_DATA_OUT;

input SEQ_CLK;
output reg [OUT_BITS-1:0] SEQ_OUT;

`include "../includes/log2func.v"

localparam ADDR_SIZEA = log2(MEM_BYTES);

reg [7:0] status_regs [15:0];  

wire RST;
wire SOFT_RST;

assign RST = BUS_RST || SOFT_RST;

localparam DEF_BIT_OUT = MEM_BYTES;

always @(posedge BUS_CLK) begin
    if(RST) begin
        status_regs[0] <= 0;
        status_regs[1] <= 0;
        status_regs[2] <= 1;
        status_regs[3] <= DEF_BIT_OUT[15:8]; //bits
        status_regs[4] <= DEF_BIT_OUT[7:0]; //bits
        status_regs[5] <= 0; //wait
        status_regs[6] <= 0; //wait
        status_regs[7] <= 0; // 7  repeat
        status_regs[8] <= 0; //repeat start
        status_regs[9] <= 0; //repeat start 
        
    end
    else if(BUS_WR && BUS_ADD < 16)
        status_regs[BUS_ADD[3:0]] <= BUS_DATA_IN;
end

wire [7:0] BUS_IN_MEM;
reg [7:0] BUS_OUT_MEM;

// 1 - finished

wire START;
assign SOFT_RST = (BUS_ADD==0 && BUS_WR);
assign START = (BUS_ADD==1 && BUS_WR);

wire [15:0] CONF_COUNT;
assign CONF_COUNT = {status_regs[3],status_regs[4]};

wire [7:0] CONF_CLK_DIV;
assign CONF_CLK_DIV = status_regs[2] -1;
reg CONF_DONE;

wire [15:0] CONF_WAIT;
assign CONF_WAIT = {status_regs[5],status_regs[6]};

wire [7:0] CONF_REPEAT;
assign CONF_REPEAT = status_regs[7];

wire [7:0] BUS_STATUS_OUT;
assign BUS_STATUS_OUT = status_regs[BUS_ADD[3:0]];

wire [15:0] CONF_REP_START;
assign CONF_REP_START = {status_regs[8],status_regs[9]};

always @ (negedge BUS_CLK) begin
    if(BUS_ADD == 1)
        BUS_DATA_OUT <= {7'b0,CONF_DONE};
    else if(BUS_ADD == 3)
        BUS_DATA_OUT <= CONF_COUNT[15:8];    
    else if(BUS_ADD == 4)
        BUS_DATA_OUT <= CONF_COUNT[7:0];
    else if(BUS_ADD == 5)
        BUS_DATA_OUT <= CONF_WAIT[15:8];
    else if(BUS_ADD == 6)
        BUS_DATA_OUT <= CONF_WAIT[7:0]; 
    else if(BUS_ADD == 7)
        BUS_DATA_OUT <= CONF_REPEAT;     
    else if(BUS_ADD < 16)
        BUS_DATA_OUT <= BUS_STATUS_OUT;
    else if(BUS_ADD < 16 + MEM_BYTES )
        BUS_DATA_OUT <= BUS_IN_MEM;
end

reg [15:0] out_bit_cnt;

generate
    if (OUT_BITS<=8) begin
        wire [log2(MEM_BYTES*(8/OUT_BITS))-1:0] memout_addrb;
    end else begin
        wire [ log2(MEM_BYTES/(OUT_BITS/8))-1:0] memout_addrb;
    end
endgenerate

assign memout_addrb = out_bit_cnt-1;
wire [ADDR_SIZEA-1:0] memout_addra;
wire [15:0] BUS_ADD_MEM;
assign BUS_ADD_MEM = BUS_ADD-16;

generate
    if (OUT_BITS<=8) begin
        assign memout_addra = BUS_ADD_MEM; 
    end else begin
        assign memout_addra = {BUS_ADD_MEM[15:OUT_BITS/8-1], {(OUT_BITS/8-1){1'b0}}} + (OUT_BITS/8-1) - (BUS_ADD_MEM % (OUT_BITS/8)); //Byte order
    end
endgenerate

wire [OUT_BITS-1:0] SEQ_OUT_MEM;

seq_gen_blk_mem memout(
    .clka(BUS_CLK), .clkb(SEQ_CLK), .douta(BUS_IN_MEM), .doutb(SEQ_OUT_MEM), .wea(BUS_WR && BUS_ADD >=16 && BUS_ADD < 16+MEM_BYTES), .web(1'b0), .addra(memout_addra), .addrb(memout_addrb), .dina(BUS_DATA_IN), .dinb({OUT_BITS{1'b0}})
);

wire RST_SYNC;
wire RST_SOFT_SYNC;
cdc_pulse_sync rst_pulse_sync (.clk_in(BUS_CLK), .pulse_in(RST), .clk_out(SEQ_CLK), .pulse_out(RST_SOFT_SYNC));
assign RST_SYNC = RST_SOFT_SYNC || BUS_RST;

wire START_SYNC;
cdc_pulse_sync start_pulse_sync (.clk_in(BUS_CLK), .pulse_in(START), .clk_out(SEQ_CLK), .pulse_out(START_SYNC));

wire [15:0] STOP_BIT;
assign STOP_BIT = CONF_COUNT + CONF_WAIT;
reg [7:0] REPEAT_COUNT;

reg [7:0] dev_cnt;

wire REP_START;
assign REP_START = (out_bit_cnt == STOP_BIT && dev_cnt == CONF_CLK_DIV && (CONF_REPEAT==0 || REPEAT_COUNT < CONF_REPEAT));

always @ (posedge SEQ_CLK)
    if (RST_SYNC)
        out_bit_cnt <= 0;
    else if(START_SYNC)
        out_bit_cnt <= 1;
    else if(REP_START)
        out_bit_cnt <= CONF_REP_START+1;
    else if(out_bit_cnt == STOP_BIT && dev_cnt == CONF_CLK_DIV)
        out_bit_cnt <= out_bit_cnt;
    else if(out_bit_cnt != 0 && dev_cnt == CONF_CLK_DIV)
        out_bit_cnt <= out_bit_cnt + 1;

always @ (posedge SEQ_CLK)
    if (RST_SYNC || START_SYNC || REP_START)
        dev_cnt <= 0;
    else if(out_bit_cnt != 0 && dev_cnt == CONF_CLK_DIV)
        dev_cnt <= 0;
    else if(out_bit_cnt != 0)
        dev_cnt <= dev_cnt + 1;
        
always @ (posedge SEQ_CLK)
    if (RST_SYNC || START_SYNC)
        REPEAT_COUNT <= 1;
    else if(out_bit_cnt == STOP_BIT && dev_cnt == CONF_CLK_DIV)
        REPEAT_COUNT <= REPEAT_COUNT + 1;


always @(posedge SEQ_CLK)
    if(RST_SYNC | START_SYNC)
        CONF_DONE <= 0;
    else if(REPEAT_COUNT >= CONF_REPEAT)
        CONF_DONE <= 1;

always @(negedge SEQ_CLK)
    SEQ_OUT <= SEQ_OUT_MEM;

    
endmodule  