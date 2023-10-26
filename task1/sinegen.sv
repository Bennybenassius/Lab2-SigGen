module sinegen # (
    parameter    A_WIDTH = 8,
                D_WIDTH = 8
) (
    //interface signals
    input   logic               clk,
    input   logic               rst,
    input   logic               en,
    input   logic [D_WIDTH-1:0] incr,
    output  logic [D_WIDTH-1:0] dout
);

    logic [A_WIDTH-1:0]         address;

counter addrCounter (
    .clk (clk),
    .rst (rst),
    .en (en),
    .incr (incr),
    .count (address)        //We're making the output equal to .count the address defined above
);

rom sineRom (
    .clk (clk),
    .addr (address),       //We're passing into .addr the address defined above
    .dout (dout)           //.dout is whatever the sineRom sayes the value is
);

endmodule
