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


module queue #(parameter data_width = 83)(
    output reg [data_width-1:0] dout,
    input [data_width-1:0] din,
    input en,
    input wr_en,
    input clk
    );
    parameter reg_depth = 100 ;
    reg [data_width-1:0] reg_bank [reg_depth:0];
    integer i;
    always @(posedge clk) begin
        if(en && wr_en) begin
            
            if(din <= reg_bank[0] || reg_bank[0] === 83'bxxxx) begin
                $display("true");
                reg_bank[0] <= din;
            end
            for(i = 1; i<=reg_depth; i = i+1) begin
                if(din[82:51] <= reg_bank[i][82:51] || reg_bank[i][82:51] === 32'bxxxx) begin
                    if(din[82:51] <= reg_bank[i-1][82:51] || reg_bank[i-1][82:51] === 32'bxxxx)
                        reg_bank[i] <= reg_bank[i-1];
                    else
                        reg_bank[i] <= din;
                end
            end
        end
        else if( en && !wr_en) begin
            for(i = 0; i<reg_depth; i = i+1)
                reg_bank[i] <= reg_bank[i+1];
            reg_bank[reg_depth] <= 83'bxxxx;
        end
       dout  <= reg_bank[0]; 
    end
    
endmodule
