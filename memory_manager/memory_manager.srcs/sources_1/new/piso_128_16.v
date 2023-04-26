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


module piso_128bit(
    input clk, 
    input reset,
    input [127:0] data_in,
    input write_en,
    input read_en,
    output reg [15:0] out,
    output reg piso_overflow
);

  reg [3:0] counter;
  reg [127:0] register_data;
  reg [7:0]interm;
  always @(posedge clk) 
  begin
    if (reset) 
    begin
      counter <= 4'd0;
      out <= 16'd0;
    end 
    else 
    begin
      if (write_en) 
      begin
        register_data <= data_in;
      end
      if (read_en) 
      begin
        if (counter == 4'd0) 
        begin
          out <= register_data[127 -: 16];
        end 
        else if (counter == 4'd1) 
        begin
          out <= register_data[111 -: 16];
        end 
        else if (counter == 4'd2) 
        begin
          out <= register_data[95  -: 16];
        end 
        else if (counter == 4'd3) 
        begin
          out <= register_data[79  -: 16];
        end 
        else if (counter == 4'd4) 
        begin
          out <= register_data[63  -: 16];
        end 
        else if (counter == 4'd5) 
        begin
          out <= register_data[47  -: 16];
        end 
        else if (counter == 4'd6) 
        begin
          out <= register_data[31  -: 16];
        end 
        else if (counter == 4'd7) 
        begin
          out <= register_data[15  -: 16];
        end
      end
      
      counter <= counter + 1;
      if (counter == 4'd8) 
      begin
        counter <= 4'd0;
      end
    end
  end
  // overflow and empty
  always @(register_data) begin
    interm[0] = |register_data[0:15];
    interm[1] = |register_data[16:31];
    interm[2] = |register_data[32:47];
    interm[3] = |register_data[48:63];
    interm[4] = |register_data[64:79];
    interm[5] = |register_data[80:95];
    interm[6] = |register_data[96:111]; 
    interm[7] = |register_data[112:127];
    piso_overflow = &interm;
  end

endmodule
