module Least_cost_finder_tb;
  
  reg [255:0] input_data;
  wire [31:0] push_data;
  reg clk;
  
  Least_cost_finder dut (
    .input_data(input_data),
    .clk(clk),
    .push_data(push_data)
  );
  
  always #5 clk = ~clk;
  
  initial begin
   
    input_data = 256'b1100110000110011001100110011001100110011001100110011001100110011;
    
    
    #10;
    
    
    $display("Input Data: %h", input_data);
    $display("Least Data: %h", push_data);
    
   
    $finish;
  end
  
endmodule
