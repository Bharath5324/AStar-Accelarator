`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/23/2023 12:12:59 PM
// Design Name: 
// Module Name: control_path_tb
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


module control_path_tb(
    );
    reg clk, enable;
    wire ready;
    control_path dut(.clk(clk), .enable(enable), .ready(ready));
    initial clk = 1'b0;
    always #5 clk = ~clk;
    initial
    begin
        $dumpvars(0, control_path_tb);
        #13 enable = 1'b1;
        #10 dut.current_reg_overflow = 1'b1; enable = 1'b0;
        #10 dut.piso_overflow = 1'b1; dut.current_reg_overflow = 1'b0;
        #10 dut.sipo_overflow = 1'b1;dut.piso_overflow = 1'b0;
        #10 dut.sipo_empty = 1'b1; dut.sipo_overflow = 1'b0;
        #10 dut.sipo_empty = 1'b0;
        #70 $finish;
    end
endmodule
