module Least_cost_finder (
  input [255:0] input_data,
  input clk,
  output reg [31:0] push_data,
  output reg [2:0] least_index,
  output reg [7:0] control_output
);

  reg [31:0] min_value;
  integer i;
  
  always @(posedge clk) begin
    min_value = input_data[31:0]; // Initialize with the first 32 bits
    least_index = 0;
    
    for (i = 1; i < 8; i = i + 1) begin
      if (input_data[(i*32) +: 32] < min_value) begin
        min_value = input_data[(i*32) +: 32];
        least_index = i;
      end
    end
    
    push_data <= min_value; 
    
    //control output based on the least_index
    control_output = 8'b0;
    control_output[least_index] = 1'b1;
  end
  
endmodule
