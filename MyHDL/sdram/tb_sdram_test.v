module tb_sdram_test;

reg master_clk_i;
wire sdram_clk_o;
reg sdram_clk_i;
wire [3:0] led_status;
wire o_uart_tx;
reg pb_i;
wire SdramCntl0_sd_intf_cke;
wire SdramCntl0_sd_intf_we;
wire [12:0] SdramCntl0_sd_intf_addr;
wire SdramCntl0_sd_intf_dqml;
wire SdramCntl0_sd_intf_cas;
wire SdramCntl0_sd_intf_dqmh;
wire SdramCntl0_sd_intf_ras;
wire [1:0] SdramCntl0_sd_intf_bs;
wire SdramCntl0_sd_intf_cs;
wire [15:0] SdramCntl0_sd_intf_dq;

initial begin
    $from_myhdl(
        master_clk_i,
        sdram_clk_i,
        pb_i
    );
    $to_myhdl(
        sdram_clk_o,
        led_status,
        o_uart_tx,
        SdramCntl0_sd_intf_cke,
        SdramCntl0_sd_intf_we,
        SdramCntl0_sd_intf_addr,
        SdramCntl0_sd_intf_dqml,
        SdramCntl0_sd_intf_cas,
        SdramCntl0_sd_intf_dqmh,
        SdramCntl0_sd_intf_ras,
        SdramCntl0_sd_intf_bs,
        SdramCntl0_sd_intf_cs,
        SdramCntl0_sd_intf_dq
    );
end

sdram_test dut(
    master_clk_i,
    sdram_clk_o,
    sdram_clk_i,
    led_status,
    o_uart_tx,
    pb_i,
    SdramCntl0_sd_intf_cke,
    SdramCntl0_sd_intf_we,
    SdramCntl0_sd_intf_addr,
    SdramCntl0_sd_intf_dqml,
    SdramCntl0_sd_intf_cas,
    SdramCntl0_sd_intf_dqmh,
    SdramCntl0_sd_intf_ras,
    SdramCntl0_sd_intf_bs,
    SdramCntl0_sd_intf_cs,
    SdramCntl0_sd_intf_dq
);

endmodule
