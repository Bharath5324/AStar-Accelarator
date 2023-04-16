module piso_128bit(
    input clk, 
  	input reset,
    input [127:0] data_in,
    input enable,
    output reg [15:0] out
    );

  reg [3:0] counter;

  always @(posedge clk) 
    begin
    if (reset) 
      begin
      counter <= 4'd0;
      out <= 16'd0;
      end 
      else if (enable) 
      begin
      counter <= counter + 1;
      if (counter == 4'd1) 
      begin
        out <= data_in[127 -: 16];
      end 
      else if (counter == 4'd2) 
      begin
        out <= data_in[111 -: 16];
      end 
      else if (counter == 4'd3) 
      begin
        out <= data_in[95  -: 16];
      end 
      else if (counter == 4'd4) 
      begin
        out <= data_in[79  -: 16];
      end 
      else if (counter == 4'd5) 
      begin
        out <= data_in[63  -: 16];
      end 
      else if (counter == 4'd6) 
      begin
        out <= data_in[47  -: 16];
      end 
      else if (counter == 4'd7) 
      begin
        out <= data_in[31  -: 16];
      end 
      else if (counter == 4'd8) 
      begin
        out <= data_in[15  -: 16];
      end
    end
  end

endmodule