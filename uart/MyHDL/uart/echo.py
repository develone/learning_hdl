from myhdl import block, always, Signal, instance, delay, Simulation, intbv, enum
 
from uart_rx import uart_rx, t_state_rx
from uart_tx import uart_tx, t_state_tx
from forceHi import forceHi
from ram import ram

i_Clk  = Signal(bool(0))
w_TX_Serial = Signal(bool(0))
w_TX_Active = Signal(bool(0))
w_RX_DV = Signal(bool(0))
w_RX_Byte = Signal(intbv(0)[8:])

state_tx = Signal(t_state_tx.TX_IDLE)
state_rx = Signal(t_state_rx.RX_IDLE) 	

i_uart_rx = Signal(bool(0))
o_uart_tx = Signal(bool(0))
o_TX_Done = Signal(bool(0))

dout = Signal(intbv(0)[16:])
dout_v = Signal(intbv(0)[15:])
din = Signal(intbv(0)[15:])
addr = Signal(intbv(0)[7:])
we = Signal(bool(0))

@block	
def echo(i_Clk, i_uart_rx, o_uart_tx,CLKS_PER_BIT=None):
 
 
	uart_rx_0 = uart_rx(i_Clk,i_uart_rx,w_RX_DV,w_RX_Byte,state_rx,CLKS_PER_BIT=868)
	uart_tx_0 = uart_tx(i_Clk,w_RX_DV,w_RX_Byte,w_TX_Active,w_TX_Serial,o_TX_Done,state_tx,CLKS_PER_BIT=868)
	forceHi_0 = forceHi(w_TX_Serial,w_TX_Active,o_uart_tx)
	ram_0 = ram(dout, din, addr, we, i_Clk, depth=32)
 
	
 
	 
 
	return uart_tx_0, uart_rx_0, forceHi_0, ram_0

def convert_echo(hdl):
	"""Convert inc block to Verilog or VHDL."""



	echo_inst = echo(i_Clk, i_uart_rx, o_uart_tx, CLKS_PER_BIT=868)
	echo_inst.convert(hdl=hdl)
convert_echo(hdl='Verilog') 

