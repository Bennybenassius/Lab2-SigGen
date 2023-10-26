module sigdelay #(
    parameter   A_WIDTH = 9,
                D_WIDTH = 8
) (
    input   logic               clk,
    input   logic               rst,
    input   logic               wr,
    input   logic               rd,
    input   logic [A_WIDTH-1:0] offset,
    input   logic [D_WIDTH-1:0] mic_signal,
    output  logic [D_WIDTH-1:0] delayed_signal    
);

logic [A_WIDTH-1:0] address1;
logic [A_WIDTH-1:0] address2;

counter addrCounter (
    .clk (clk),
    .rst (rst),
    //.en (en),
    .del (offset),
    .count1 (address1),        //We're making the output equal to .count the address defined above
    .count2 (address2)
);

ram2ports micRam (
    .clk (clk),
    .wr_en (wr),
    .rd_en (rd),
    .wr_addr (address1),       //We're passing into .addr the address defined above
    .rd_addr (address2),
    .din (mic_signal),           //.dout is whatever the sineRom sayes the value is
    .dout (delayed_signal)
);

endmodule
