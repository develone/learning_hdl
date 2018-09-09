from myhdl import *

@block
def divclkby2(clk_i,o_clkdiv2):
	@always(clk_i.posedge)
	def div2():
		o_clkdiv2.next = not o_clkdiv2
	return instances()
def convert():
	clk_i, o_clkdiv2 = [Signal(bool(0)) for _ in range(2)]
	divclkby2_inst = divclkby2(clk_i,o_clkdiv2)
	divclkby2_inst.convert(hdl="Verilog", initial_values=False)
		
convert()
