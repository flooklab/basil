# ------------------------------------------------------------
# Copyright (c) All rights reserved
# SiLab, Institute of Physics, University of Bonn
# ------------------------------------------------------------
#

import unittest
import os
import yaml
from basil.dut import Dut
from basil.utils.sim.utils import cocotb_compile_and_run, cocotb_compile_clean, get_basil_dir

class TestExampleMIO(unittest.TestCase):
    def setUp(self):
    
        cocotb_compile_and_run(
            [get_basil_dir()+'/basil/firmware/modules/gpio/gpio.v', 
            get_basil_dir()+'/basil/firmware/modules/utils/reset_gen.v', 
            get_basil_dir()+'/basil/firmware/modules/utils/bus_to_ip.v', 
            os.path.dirname(__file__) + '/../src/example.v'], 
            top_level = 'example',
            sim_bus='basil.utils.sim.SiLibUsbBusDriver'
            )
    
        cnfg = {}
        with open(os.path.dirname(__file__) + '/example.yaml', 'r') as f:
            cnfg = yaml.load(f)
            
        # change to simulation interface
        cnfg['transfer_layer'][0]['type'] = 'SiSim' 

        self.chip = Dut(cnfg)
        self.chip.init()

    def test(self):
        
        ret = self.chip['GPIO_LED'].get_data()
        self.assertEqual([0], ret)
        
        self.chip['GPIO_LED']['LED'] = 0x01
        self.chip['GPIO_LED'].write()
        
        ret = self.chip['GPIO_LED'].get_data()
        self.assertEqual([0x21], ret)
        
        self.chip['GPIO_LED']['LED'] = 0x02
        self.chip['GPIO_LED'].write()
        
        ret = self.chip['GPIO_LED'].get_data()
        self.assertEqual([0x42], ret)
        
        self.chip['GPIO_LED']['LED'] = 0x03
        self.chip['GPIO_LED'].write()
        
        ret = self.chip['GPIO_LED'].get_data()
        self.assertEqual([0x63], ret)
        
    def tearDown(self):
        self.chip.close()  # let it close connection and stop simulator
        cocotb_compile_clean()

if __name__ == '__main__':
    unittest.main()
      
