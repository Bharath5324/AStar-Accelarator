`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/10/2023 01:18:47 PM
// Design Name: 
// Module Name: queue_tb
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


module queue_tb;
    reg clk, en, wr_en;
    reg[15:0] din;
    wire[15:0] dout;
    
    queue dut(.clk(clk), .en(en), .wr_en(wr_en), .din(din), .dout(dout));
    
    initial clk = 0;
    
    always #5 clk = ~clk;
    
    initial begin
        $dumpvars(1, queue_tb);
        #3 en = 1'b1; wr_en = 1'b1; din <= 16'hffff;
        #10 din <= 16'h0010;
        #10 din <= 16'h0003;
        #10 din <= 16'h000A;
        #10 din <= 16'h0011;
        #10 din <= 16'h000D;
        #10 din <= 16'h010A;
        #10 din <= 16'h0011;
        #10 din <= 16'h0100;
        #10 wr_en = 1'b0;
        #40 din = 16'h0010;wr_en = 1'b1; 
        #10 en = 1'b0;
        #10 $finish;
    end
    
endmodule
