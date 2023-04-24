`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Gouri Krishna 
// 
// Create Date: 04/07/2023 02:00:58 PM
// Design Name: Blockram - width 35 bit, Depth: 65536
// Module Name: blockram
// Project Name: Memory Manager
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


module blockram(
    input clka,
    input clkb,
    input ena,
    input enb,
    input wea,
    input web,
    input [15:0] addra,
    input [15:0] addrb,
    input [34:0] dia,
    input [34:0] dib,
    output reg [34:0] doa,
    output reg [34:0] dob
    );
    reg [34:0] ram [65535:0];
    always @(posedge clka)
    begin
        if (ena)
        begin
            if (wea)
                ram[addra] <= dia;
            doa <= ram[addra];
        end
    end
    always @(posedge clkb)
    begin
        if (enb)
        begin
            if (web)
                ram[addrb] <= dib;
            dob <= ram[addrb];
        end
    end
endmodule
