module tb_test_readWrite;

reg sd_intf_cke;
reg sd_intf_we;
reg [12:0] sd_intf_addr;
reg sd_intf_dqml;
reg sd_intf_cas;
reg sd_intf_dqmh;
reg sd_intf_ras;
reg [1:0] sd_intf_bs;
reg sd_intf_cs;
reg [15:0] sd_intf_dq;
reg host_intf_wr_i;
reg host_intf_done_o;
reg host_intf_rdPending_o;
reg host_intf_rst_i;
reg [15:0] host_intf_data_i;
reg [15:0] host_intf_data_o;
reg host_intf_rd_i;
reg [23:0] host_intf_addr_i;

initial begin
    $from_myhdl(
        sd_intf_cke,
        sd_intf_we,
        sd_intf_addr,
        sd_intf_dqml,
        sd_intf_cas,
        sd_intf_dqmh,
        sd_intf_ras,
        sd_intf_bs,
        sd_intf_cs,
        sd_intf_dq,
        host_intf_wr_i,
        host_intf_done_o,
        host_intf_rdPending_o,
        host_intf_rst_i,
        host_intf_data_i,
        host_intf_data_o,
        host_intf_rd_i,
        host_intf_addr_i
    );
end

test_readWrite dut(
    sd_intf_cke,
    sd_intf_we,
    sd_intf_addr,
    sd_intf_dqml,
    sd_intf_cas,
    sd_intf_dqmh,
    sd_intf_ras,
    sd_intf_bs,
    sd_intf_cs,
    sd_intf_dq,
    host_intf_wr_i,
    host_intf_done_o,
    host_intf_rdPending_o,
    host_intf_rst_i,
    host_intf_data_i,
    host_intf_data_o,
    host_intf_rd_i,
    host_intf_addr_i
);

endmodule
