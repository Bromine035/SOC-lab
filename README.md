# 2023-Fall SoC Design Course in NYCU
The codes are base on [Caravel-SoC FPGA lab](https://github.com/bol-edu/caravel-soc_fpga-lab) from [BOL-edu](https://github.com/bol-edu) and 
[Efabless Caravel Harness](https://caravel-harness.readthedocs.io/en/latest/) SoC (System on Chip) template for validation on 
[Xilinx PYNQ-Z2](https://www.xilinx.com/support/university/xup-boards/XUPPYNQ-Z2.html) FPGA board

![horeginderogikh](https://github.com/Bromine035/SOC-lab/assets/145190192/1a8f7448-4098-43c4-af26-73d6c82f7477)

## To Run the Caravel SOC Simulation for Labs
1. Follow the following step to bring up the Toolchain:  
https://github.com/bol-edu/caravel-soc#toolchain-prerequisites 
2. Follow the following step to use Xilinx XSIM:  
https://github.com/bol-edu/caravel-soc_fpga#run-xilinx-vivado-simulation-of-caravel-soc-fpga
3. Run RTL simulation
``` console
lab_final/testbench/final$ source run_clean
lab_final/testbench/final$ source run_sim
```
4. Use GTKwave to examine the waveform
``` console
lab_final/testbench/final$ gtkwave final.vcd
```
