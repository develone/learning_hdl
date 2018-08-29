from myhdl import *
@block
def forceHi(w_TX_Serial,w_TX_Active,o_uart_tx):
	"""
	Drive UART line high when transmitter is not active
	          c           b              a
	assign o_uart_tx = w_TX_Active ? w_TX_Serial : 1'b1;
	sigtest_inst = sigtest(w_TX_Serial,w_TX_Active,o_uart_tx)
	"""

	@always_comb
	def comb():
		if(w_TX_Active):
			o_uart_tx.next = w_TX_Serial
		else:
			o_uart_tx.next = True
		
	return comb
