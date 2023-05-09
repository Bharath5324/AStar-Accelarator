`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/27/2023 12:06:13 AM
// Design Name: 
// Module Name: current_reg
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


module current_reg(
    input [50:0] din,
    input clk,
    input enable,
    output reg [50:0] dout,
    output reg overflow
    );
    
    always @(posedge clk && enable) begin
        dout <= din;
    end
    always @(dout)
        overflow <= |din;
endmodule
