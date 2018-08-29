#from myhdl import block, always, Signal, instance, delay, Simulation, intbv, enum
from myhdl import *
t_state_tx = enum('TX_IDLE', 'TX_START_BIT', 'TX_DATA_BITS', 'TX_STOP_BIT', 'TX_CLEANUP')
@block
def uart_tx(i_Clock,i_TX_DV,i_TX_Byte,o_TX_Active,o_TX_Serial,o_TX_Done,state_tx,CLKS_PER_BIT=None):
	
	r_TX_Done = Signal(bool(0))
	r_TX_Active = Signal(bool(0))
	r_Clock_Count = Signal(intbv(0)[12:])
	r_TX_data = Signal(intbv(0)[8:])
	r_Bit_Index = Signal(intbv(0)[3:]) 
 
	@always(i_Clock.posedge)
	def send():
		if(state_tx==t_state_tx.TX_IDLE):
			"""Drive Line High for TX_IDLE"""
		
			o_TX_Serial.next = 1
			r_TX_Done.next = 0
			r_Bit_Index.next = 0
			r_Clock_Count.next = 0
			if(i_TX_DV == 1):
				r_TX_Active.next = 1
				r_TX_data.next = i_TX_Byte
				state_tx.next = t_state_tx.TX_START_BIT
			else:
				state_tx.next = t_state_tx.TX_IDLE 
				"""
				End of TX TX_IDLE state
				Start of TX TX_START_BIT state
				"""
		elif (state_tx==t_state_tx.TX_START_BIT):
			o_TX_Serial.next = 0
			if (r_Clock_Count < CLKS_PER_BIT -1):
				r_Clock_Count.next = r_Clock_Count + 1
				state_tx.next = t_state_tx.TX_START_BIT
			else:
				r_Clock_Count.next = 0
				state_tx.next = t_state_tx.TX_DATA_BITS
				"""
				End of TX TX_START_BIT state_tx
				Start of TX TX_DATA_BITS state_tx
				"""
		elif (state_tx==t_state_tx.TX_DATA_BITS):
			o_TX_Serial.next = r_TX_data[r_Bit_Index]
			if (r_Clock_Count < CLKS_PER_BIT -1):
				r_Clock_Count.next = r_Clock_Count + 1
				state_tx.next = t_state_tx.TX_DATA_BITS
			else:
				r_Clock_Count.next = 0
				if (r_Bit_Index < 7):
					r_Bit_Index.next = r_Bit_Index + 1
					state_tx.next = t_state_tx.TX_DATA_BITS
				else:
					r_Bit_Index.next = 0
					state_tx.next = t_state_tx.TX_STOP_BIT
				"""
				End of TX TX_DATA_BITS state_tx
				Start of TX TX_STOP_BIT state_tx
				"""
					
		elif (state_tx==t_state_tx.TX_STOP_BIT):
			o_TX_Serial.next = 1
			if (r_Clock_Count < CLKS_PER_BIT -1):
				r_Clock_Count.next = r_Clock_Count + 1
				state_tx.next = t_state_tx.TX_STOP_BIT
			else:
				r_TX_Done.next = 1
				r_Clock_Count.next = 0
				state_tx.next = t_state_tx.TX_CLEANUP
				r_TX_Active.next = 0
				"""
				End of TX TX_STOP_BIT state_tx
				Start of TX TX_CLEANUP state_tx
				"""
		elif (state_tx==t_state_tx.TX_CLEANUP):
			r_TX_Done.next = 1
			state_tx.next = t_state_tx.TX_IDLE
		else:
			state_tx.next = t_state_tx.TX_IDLE
		o_TX_Active.next = r_TX_Active
		o_TX_Done.next = r_TX_Done

	return send

def convert_uart_tx(hdl):
	"""Convert inc block to Verilog or VHDL."""

	i_TX_DV = Signal(bool(0))
	o_TX_Done = Signal(bool(0))
	o_TX_Serial = Signal(bool(0))
	o_TX_Active = Signal(bool(0))
	#o_uart_tx = Signal(bool(0))
	i_Clock  = Signal(bool(0))
	i_TX_Byte = Signal(intbv(0)[8:])
	state_tx = Signal(t_state_tx.TX_IDLE)
	CPB = 434
	uart_tx_inst = uart_tx(i_Clock,i_TX_DV,i_TX_Byte,o_TX_Active,o_TX_Serial,o_TX_Done,state_tx,CLKS_PER_BIT=CPB)
	uart_tx_inst.convert(hdl=hdl)
convert_uart_tx(hdl='Verilog')
