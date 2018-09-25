from myhdl import *

@block
def data_delay(clk_i, enbl_i, load_i, data_i, rand_o):


    width = len(rand_o)  # Width of random number to be generated.

    tmpdata = Signal(intbv(0)[16:]) # holds the the data_i.
    tmpdata1 = Signal(intbv(0)[16:]) # set the delayed data_i

 

    # Sequential process to generate random number.
    @always_seq(clk_i.posedge, reset=None)
    def delayed():

        if load_i:
            # Load the data_i into tmpdata
            tmpdata.next = data_i
        elif enbl_i:
            # copy the the tmpdata which is the data_i to tmpdata1
            tmpdata1.next = tmpdata
            

    # Combinational process to output the delayed data.
    @always_comb
    def rand_out():
        rand_o.next = tmpdata1

    return instances()
clk, enbl, ld_i  = [Signal(bool(0)) for _ in range(3)]
data_i = Signal(intbv(0)[16:]) # holds the the data_i.
rand_o = Signal(intbv(0)[16:]) # holds the the data_i.
data_delay_inst = data_delay(clk,enbl, ld_i, data_i, rand_o)
data_delay_inst.convert()
