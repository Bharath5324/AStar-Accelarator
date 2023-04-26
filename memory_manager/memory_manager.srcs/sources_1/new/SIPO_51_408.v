`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
//
// Create Date: 04/07/2023 02:05:19 PM
// Design Name: 
// Module Name: control_path
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////




module sipo(
  input clk,
  input [50:0] data_in,
  input rst,
  input enable,
  output reg [407:0] data_out,
  output reg sipo_overflow,
  output reg sipo_empty
);

reg [50:0] buffer [0:7];
reg [7:0] interm;

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
  end  
end

// Combinational statements

// Combine, empty and overflow

always @(buffer) begin
    data_out = {buffer[7], buffer[6], buffer[5], buffer[4], buffer[3], buffer[2], buffer[1], buffer[0]};
    interm[0] = |buffer[0];
    interm[1] = |buffer[1];
    interm[2] = |buffer[2];
    interm[3] = |buffer[3];
    interm[4] = |buffer[4];
    interm[5] = |buffer[5];
    interm[6] = |buffer[6]; 
    interm[7] = |buffer[7];
    sipo_overflow = &interm;
    sipo_empty = ~|interm;
end
endmodule


