import myhdl
from myhdl import *

@block
def ram(dout, din, addr, we, i_Clock, depth=32):
    """  Ram model """
    
    mem = [Signal(intbv(0)[8:]) for i in range(depth)]
    
    @always(i_Clock.posedge)
    def write():
        if we:
            mem[addr].next = din
                
    @always_comb
    def read():
        dout.next = mem[addr]

    return write, read


dout = Signal(intbv(0)[16:])
dout_v = Signal(intbv(0)[16:])
din = Signal(intbv(0)[16:])
addr = Signal(intbv(0)[7:])
we = Signal(bool(0))
i_Clock = Signal(bool(0))

def convert_ram(hdl):
	"""Convert inc block to Verilog or VHDL."""

 
 
	ram_inst = ram(dout, din, addr, we, i_Clock, depth=32)
	ram_inst.convert(hdl=hdl)
convert_ram(hdl='Verilog')
 
