# Learning Hardware Description Language HDL
# Goals 
  - FSM Finite State Machine
  - UART Universal Asynchronous Receiver-Transmitter
  - SDRAM 
  - SPI
# Requirements
* FPGA Field Programmable Gate Array
    - Zedboard
    - XulA2-LX9
    - Arty
    - Catboard
* Programming Languages
    - C 
    - Python
    - Perl
    
* Developement Hardware
    - Xilinx  Ubuntu high development system 
      - ISE
      - Vivado
    - RPi3B+
For several years I have tried to learn Hardware Description Language HDL.
The two major versions of HDL are Verilog and VHDL.  At this point I am focusing on Verilog.
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
  - Yosys Open Synthesis Suite Clifford Wolf
    - yosys
    - icestorm 
    - arachne-pnr
