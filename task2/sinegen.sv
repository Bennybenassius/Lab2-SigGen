module sinegen # (
    parameter   A_WIDTH = 8,
                D_WIDTH = 8
) (
    //interface signals
    input   logic               clk,
    input   logic               rst,
    input   logic               en,
    input   logic [D_WIDTH-1:0] del,
    output  logic [D_WIDTH-1:0] dout1,
    output  logic [D_WIDTH-1:0] dout2
);

    logic [A_WIDTH-1:0]         address1;
    logic [A_WIDTH-1:0]         address2;

counter addrCounter (
    .clk (clk),
    .rst (rst),
    .en (en),
    .del (del),
    .count1 (address1),        //We're making the output equal to .count the address defined above
    .count2 (address2)
);

rom2ports sineRom (
    .clk (clk),
    .addr1 (address1),       //We're passing into .addr the address defined above
    .addr2 (address2),
    .dout1 (dout1),           //.dout is whatever the sineRom sayes the value is
    .dout2 (dout2)
);

endmodule
