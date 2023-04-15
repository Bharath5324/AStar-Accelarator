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


module control_path(
    input clk,
    input enable,
    output reg ready
    );
    parameter a = 2'b00, b = 2'b01, c = 2'b10 , d = 2'b11;
    wire sipo_empty, current_reg_overflow, bram_write_ack, piso_overflow;
    always@ (posedge clk) 
    begin
        
    end
endmodule
