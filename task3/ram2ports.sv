module ram2ports #(
    parameter    ADDRESS_WIDTH = 9,
                 DATA_WIDTH = 8
) (
    input   logic                           clk,        //clock
    input   logic                           wr_en,      //Write enable
    input   logic                           rd_en,      //Read enable
    input   logic   [ADDRESS_WIDTH-1:0]     wr_addr,    //Write address
    input   logic   [ADDRESS_WIDTH-1:0]     rd_addr,    //Read address
    input  logic    [DATA_WIDTH-1:0]        din,        //Data to write
    output  logic   [DATA_WIDTH-1:0]        dout        //Data that is read
);

logic [DATA_WIDTH-1:0] ram_array [2**ADDRESS_WIDTH-1:0];

always_ff @(posedge clk) begin
    //output is synchronous
    if (wr_en)      ram_array [wr_addr] <= din;  //Write to address in ram
    if (rd_en)      dout <= ram_array [rd_addr]; //Read from address of ram 
end

endmodule
