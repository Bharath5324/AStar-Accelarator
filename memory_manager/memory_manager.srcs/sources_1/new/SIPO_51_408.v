module sipo(
  input clk,
  input [50:0] data_in,
  input rst,
  input enable,
  output reg [407:0] data_out
);

reg [50:0] buffer [0:7];

always @(posedge clk) begin
  if (rst) begin
    // Reset the buffer
    buffer[7] <= 0;
    buffer[6] <= 0;
    buffer[5] <= 0;
    buffer[4] <= 0;
    buffer[3] <= 0;
    buffer[2] <= 0;
    buffer[1] <= 0;
    buffer[0] <= 0;
   
  end 
  else if (enable) 
  begin
    // Shift in new data 
    buffer[7] <= buffer[6];
    buffer[6] <= buffer[5];
    buffer[5] <= buffer[4];
    buffer[4] <= buffer[3];
    buffer[3] <= buffer[2];
    buffer[2] <= buffer[1];
    buffer[1] <= buffer[0];
    buffer[0] <= data_in;
  
    // Combine 
    data_out = {buffer[7], buffer[6], buffer[5], buffer[4], buffer[3], buffer[2], buffer[1], buffer[0]};
  end
  
 
  
end

endmodule
