#!/bin/bash
export SIM=questa

if [ -d "unisims" ] && [ -d "secureip" ]; then
    echo "Directories unisims and secureip already exist"
else
    echo "Compiling unisims and secureip libs"

    vlog -work unisims $XILINX_VIVADO/data/verilog/src/unisims/*.v
    vlog -work unisims $XILINX_VIVADO/data/verilog/src/retarget/*.v

    vlog -work secureip -f $XILINX_VIVADO/data/secureip/gtxe2_common/gtxe2_common_cell.list.f
    vlog -work secureip -f $XILINX_VIVADO/data/secureip/gtxe2_channel/gtxe2_channel_cell.list.f
    
    vlog -work secureip -f $XILINX_VIVADO/data/secureip/in_fifo/in_fifo_cell.list.f
    vlog -work secureip -f $XILINX_VIVADO/data/secureip/out_fifo/out_fifo_cell.list.f
    
    vlog -work secureip -f $XILINX_VIVADO/data/secureip/iserdese2/iserdese2_cell.list.f
    vlog -work secureip -f $XILINX_VIVADO/data/secureip/oserdese2/oserdese2_cell.list.f
   
    vlog -work secureip -f $XILINX_VIVADO/data/secureip/phaser_in/phaser_in_cell.list.f
    vlog -work secureip -f $XILINX_VIVADO/data/secureip/phaser_out/phaser_out_cell.list.f
    
    vlog -work secureip -f $XILINX_VIVADO/data/secureip/phy_control/phy_control_cell.list.f
fi
