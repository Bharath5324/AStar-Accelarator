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
    parameter a = 3'b000, b = 3'b001, c = 3'b010 , d = 3'b011, e = 3'b100;
    wire sipo_overflow, current_reg_overflow, bram_write_ack, piso_overflow, sipo_empty;
    reg [2:0] state;
    always @(posedge clk) 
        case (state)
        a: if(enable) state <= b;
        b: if(current_reg_overflow) state <= c;
        c: if(piso_overflow) state <= d;
        d: if(sipo_overflow) state <= e;
        e: if(sipo_empty) state <= a;
        default: state <= a;
        endcase
    begin
        
    end
endmodule
