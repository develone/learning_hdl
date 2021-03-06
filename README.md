# Learning Hardware Description Language HDL
# For several years I have tried to learn Hardware Description Language HDL.
# The two major versions of HDL are Verilog and VHDL.  At this point I am focusing on Verilog
# Goals 
  - FSM Finite State Machine
  - UART Universal Asynchronous Receiver-Transmitter
  - SDRAM 
  - ram  & rom
  - fifo
  - SPI
  - Parallel data transfer
  - led digit display
  - oled displays
  - dsp
  - SOC
  - Simulation test bench
# Requirements
* GIT
* FPGA Field Programmable Gate Array Boards
    - Zedboard Xilinx Zynq 7000
    - XulA2-LX9 Xilinx Spartan 6 LX9
    - Arty Xilinx Artix-7 35T
    - Catboard Lattice ice40 HX8K
* Programming Languages
    - C 
    - Python
    - Perl
    - Verilog
    
* Developement Hardware
    - Xilinx  Ubuntu high development system 
      - ISE
      - Vivado
    - RPi3B+
      - Software versions as 11/13/18
      - MyHDL 49e90cd21
      - yosys e275692e
      - icestorm 8cac6c58
      - arachne-pnr 5d830dd9
      - icozip 9dcbacfe
      - autofpga 2f443503
      - zipcpu ab82a886
      - verllator c8e437c4
      - wavedrom a867a8df
	

.
# There are many tools that are required to write and simulate HDL.
* MyHDL Jan Decaluwe
    - Takes Python and creates Verilog or VHDL
    - MyHDL provides simulation & co-simulation with Icarus Verilog
* Simulators
    - Icarus Verilog Stephen Williams
      - Privides co-simulation with MyHDL
      - iverilog creates a module from verilog files
      - vvp 
* Verilator Wilson Snyder
      - Converts Verilog to C
      - C simulation
* GTKWAVE Displays Value Change Dump VCD files generated with simulation
* Yosys Open Synthesis Suite Clifford Wolf
    - yosys
    - icestorm 
    - arachne-pnr
* Wavedrom 
    - Signal Editor 

