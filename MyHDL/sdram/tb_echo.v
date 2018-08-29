module tb_echo;

reg i_Clk;
reg i_uart_rx;
wire o_uart_tx;

initial begin
    $from_myhdl(
        i_Clk,
        i_uart_rx
    );
    $to_myhdl(
        o_uart_tx
    );
end

echo dut(
    i_Clk,
    i_uart_rx,
    o_uart_tx
);

endmodule
