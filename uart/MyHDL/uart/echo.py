from myhdl import block, always, Signal, instance, delay, Simulation, intbv, enum
 
from uart_rx import *
from uart_tx import *

 
i_RX_Serial = Signal(bool(0))
#The connection to fpga from the RPi
i_uart_rx =  Signal(bool(0))
#The connection to fpga the goes in the RPi
o_uart_tx = Signal(bool(0))
i_TX_DV = Signal(bool(0))
i_RX_DV = Signal(bool(0))
o_TX_Done = Signal(bool(0))
o_TX_Serial = Signal(bool(0))
o_TX_Active = Signal(bool(0))
i_Clk  = Signal(bool(0)) 
i_Clock  = Signal(bool(0))
i_TX_Byte = Signal(intbv(0)[8:])
o_RX_Byte = Signal(intbv(0)[8:])
""" 
w_RX_DV = Signal(bool(0))
w_RX_Byte = Signal(intbv(0)[8:])
#The wire w_TX_Seriial is used as the uart_tx o_TX_Serial
w_TX_Serial = Signal(bool(0))
w_TX_Active = Signal(bool(0))
"""
@block	
def echo(i_Clk, i_uart_rx, o_uart_tx,CLKS_PER_BIT=None):
	state_rx = Signal(t_state_rx.RX_IDLE)
	state_tx = Signal(t_state_tx.TX_IDLE)
	w_RX_DV = Signal(bool(0))
	w_RX_Byte = Signal(intbv(0)[8:])
	#The wire w_TX_Seriial is used as the uart_tx o_TX_Serial
	w_TX_Serial = Signal(bool(0))
	w_TX_Active = Signal(bool(0))
	"""
	The i_Clk is mapped to i_Clock
	The wire w_RX_DV is used as the uart_tx i_TX_DV
	w_RX_DV <= uart_rx0_0_r_RX_DV;
	The wire w_RX_Byte is used as the uart_tx i_TX_Byte
	w_RX_Byte <= uart_rx0_0_r_RX_Byte;
	uart_rx(i_Clock,i_RX_Serial,o_RX_DV,o_RX_Byte,state,CLKS_PER_BIT=None)
	"""
	uart_rx_inst = uart_rx(i_Clk,i_uart_rx,w_RX_DV,w_RX_Byte,state_rx,CLKS_PER_BIT=868)	 
	
	"""
	@always(i_Clock.posedge)
	def echobyte():
		if(o_RX_DV):
			r_TX_Byte.next <= o_RX_Byte
			i_TX_DV.next = 1
		else:
			i_tx_DV.next = 0
	"""
	
	"""
	The i_Clk is mapped to i_Clock
	The wire w_RX_DV is used as the uart_tx i_TX_DV
	The wire w_RX_Byte is used as the uart_tx i_TX_Byte	
	uart_tx(i_Clock,i_TX_DV,i_TX_Byte,o_TX_Active,o_TX_Serial,o_TX_Done,state,CLKS_PER_BIT=None):
	"""
	uart_tx_inst = uart_tx(i_Clk,w_RX_DV,w_RX_Byte,w_TX_Active,w_TX_Serial,o_TX_Done,state_tx,CLKS_PER_BIT=868)
	#o_TX_Serial = o_TX_Active
	return uart_rx_inst, uart_tx_inst

def convert_echo(hdl):
	"""Convert inc block to Verilog or VHDL."""



	echo_inst = echo(i_Clock, i_RX_Serial, o_TX_Serial, CLKS_PER_BIT=868)
	echo_inst.convert(hdl=hdl)
convert_echo(hdl='Verilog') 

