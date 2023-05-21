module BitDataConcat(
  input wire [663:0] input_data,
  output wire [255:0] output_data_256
);

  reg [82:0] data_segments [7:0];
  reg [31:0] last_32_bits [7:0];
  reg [255:0] concatenated_bits;

  integer i;

  always @(*) begin
    // Split  input into 8 
    for (i = 0; i < 8; i = i + 1)
      data_segments[i] = input_data[(i+1)*83-1 : i*83];

    // Extract the last 32 bits from each 
    for (i = 0; i < 8; i = i + 1)
      last_32_bits[i] = data_segments[i][31 : 0];

    // Concatenate the 32-bit segments to 256-bit
    concatenated_bits = {last_32_bits[7], last_32_bits[6], last_32_bits[5], last_32_bits[4], last_32_bits[3], last_32_bits[2], last_32_bits[1], last_32_bits[0]};
  end

  assign output_data_256 = concatenated_bits;

endmodule
