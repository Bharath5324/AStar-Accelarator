`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/26/2023 10:28:56 PM
// Design Name: 
// Module Name: fifo
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


module fifo(
    input [15:0] din,
    input clk,
    output reg [15:0] dout
    );
    reg [15:0] next_state;
    always @(posedge clk)
    begin
        next_state <= din;
        dout <= next_state;
    end
    
endmodule
