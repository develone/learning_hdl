import myhdl
from myhdl import block, always_comb, instance, Signal, ResetSignal, intbv, delay,StopSimulation

@block
def forceHi(SigA,SigB,SigC):
	"""
	Drive UART line high when transmitter is not active
	          c           b              a
	assign o_uart_tx = w_TX_Active ? w_TX_Serial : 1'b1;
	sigtest_inst = sigtest(w_TX_Serial,w_TX_Active,o_uart_tx)
	"""

	@always_comb
	def comb():
		if(SigB):
			SigC.next = SigA
		else:
			SigC.next = True
		
	return comb




def convert_forceHi(hdl):
	"""Convert inc block to Verilog or VHDL."""

	SigA = Signal(bool(0))
	SigB = Signal(bool(0))
	SigC = Signal(bool(0))
 
	forceHi_inst = forceHi(SigA,SigB,SigC)
	forceHi_inst.convert(hdl=hdl)
convert_forceHi(hdl='Verilog')
