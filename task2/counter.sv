module counter #(
  parameter WIDTH = 8
)(
  // interface signals
  input  logic             clk,      // clock 
  input  logic             rst,      // reset 
  input  logic             en,       // enable
  input  logic [WIDTH-1:0] del,      // increment for counter
  output logic [WIDTH-1:0] count1,    // count output
  output logic [WIDTH-1:0] count2    // Offset output
);

always_ff @ (posedge clk) 
  if (rst) begin
    count1 <= {WIDTH{1'b0}};
    count2 <= {WIDTH{1'b0}};
  end
  else if (en) begin
    count1 <= count1 + 1;
    count2 <= count1 + 1 + del;
  end

  //else     count <= count + {{WIDTH-1{1'b0}}, en};    //This is default increment by 1

endmodule
