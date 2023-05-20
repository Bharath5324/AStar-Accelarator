`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/10/2023 01:07:05 PM
// Design Name: 
// Module Name: queue
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


module queue(
    output reg [15:0] dout,
    input [15:0] din,
    input en,
    input wr_en,
    input clk
    );
    parameter reg_depth = 2000 ;
    reg [15:0] reg_bank [reg_depth:0];
    integer i;
    always @(posedge clk) begin
        if(en && wr_en) begin
            
            if(din <= reg_bank[0] || reg_bank[0] === 16'hxxxx) begin
                $display("true");
                reg_bank[0] <= din;
            end
            for(i = 1; i<=reg_depth; i = i+1) begin
                if(din <= reg_bank[i] || reg_bank[i] === 16'hxxxx) begin
                    if(din <= reg_bank[i-1] || reg_bank[i-1] === 16'hxxxx)
                        reg_bank[i] <= reg_bank[i-1];
                    else
                        reg_bank[i] <= din;
                end
            end
        end
        else if( en && !wr_en) begin
            dout  <= reg_bank[0];
            for(i = 0; i<reg_depth; i = i+1)
                reg_bank[i] <= reg_bank[i+1];
            reg_bank[reg_depth] <= 16'hxxxx;
        end
    end
    
endmodule
