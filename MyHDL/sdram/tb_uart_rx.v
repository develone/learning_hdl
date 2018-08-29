module tb_uart_rx;

reg i_Clock;
reg i_RX_Serial;
wire o_RX_DV;
wire [7:0] o_RX_Byte;
wire [2:0] state_rx;

initial begin
    $from_myhdl(
        i_Clock,
        i_RX_Serial
    );
    $to_myhdl(
        o_RX_DV,
        o_RX_Byte,
        state_rx
    );
end

uart_rx dut(
    i_Clock,
    i_RX_Serial,
    o_RX_DV,
    o_RX_Byte,
    state_rx
);

endmodule
