#
# ------------------------------------------------------------
# Copyright (c) All rights reserved
# SiLab, Institute of Physics, University of Bonn
# ------------------------------------------------------------
#

import os
import yaml
import unittest
import logging

from basil.dut import Dut
from basil.utils.sim.utils import cocotb_compile_and_run, cocotb_compile_clean


class TestDDR3(unittest.TestCase):
    def setUp(self):
        logging.info('Starting test')
        vsim_extras = "-t 1ps"
#    vsim_extras += "-no_autoacc -suppress 2718,2685,2583"
        extra_defines = ''

        top_dir = os.getcwd()
        xilinx_dir = os.environ.get('XILINX_VIVADO')

        cocotb_compile_and_run(sim_files=[os.path.join(top_dir, 'tb.v')],
                               top_level='tb',
                               extra_defines=extra_defines,
                               include_dirs=(os.path.join(top_dir, 'sim'),
                                             os.path.join(top_dir, 'data'),
                                             os.path.join(xilinx_dir, 'data', 'verilog', 'src')),
                               extra='export SIMULATION_MODULES=\n' +
                                     'VSIM_ARGS += -wlf /tmp/ddr3.wlf -L '+
                                     top_dir + '/secureip -L ' +
                                     top_dir + '/unisims work.glbl {vsim_extras}\n'.format(vsim_extras=vsim_extras))

        with open(os.path.join(top_dir, 'sim.yaml'), 'r') as f:
            cnfg = yaml.full_load(f)
        self.chip = Dut(cnfg)
        self.chip.init()

    def testDDR3(self):
        self.chip['gpio'].set_output_en([0xfffe, 0, 0])  # to remove 'z in simulation
        logging.info('Waiting for init')
        while True:
            if self.chip['gpio'].get_data() == 0x1:
                break
        logging.info('Init done')

    def tearDown(self):
        self.chip.close()


if __name__ == '__main__':
    unittest.main()
