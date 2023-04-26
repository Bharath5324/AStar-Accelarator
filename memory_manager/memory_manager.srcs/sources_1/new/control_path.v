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
//    input [34:0] current,
//    output reg [127:0] data,
    output reg ready   
    );
    parameter a = 3'b000, b = 3'b001, c = 3'b010 , d = 3'b011, e = 3'b100;
    reg [50:0] current_reg;
    reg current_reg_en, piso_wr_en, piso_rd_en, sipo_en, bram_en;
    reg sipo_overflow, current_reg_overflow, bram_write_ack, piso_overflow, sipo_empty;
    reg [2:0] state;
    always @(posedge clk) 
    begin
        case (state)
        a: if(enable) state <= b;
        b: if(current_reg_overflow) state <= c;
        c: if(piso_overflow) state <= d;
        d: if(sipo_overflow) state <= e;
        e: if(sipo_empty) state <= a;
        default: state <= a;
        endcase
    end
    
    always @(state)
    begin 
        case(state)
        a:;
        b: current_reg_en <= 1'b1;
        c: begin 
            piso_wr_en<= 1'b1; current_reg_en <= 1'b0; 
           end
        d: begin 
            piso_wr_en<= 1'b0; piso_rd_en<= 1'b1; sipo_en <= 1'b1; bram_en <= 1'b1;
           end
        e: begin
            ready <= 1'b1;
           end
        endcase
    end
endmodule
