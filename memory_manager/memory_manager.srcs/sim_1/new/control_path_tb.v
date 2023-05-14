`timescale 1ns / 1ps

module control_path_tb;
    reg clk;
    reg enable;
    reg [50:0] din;
    wire [407:0] dout;
    wire ready;
    
    control_path dut (
        .clk(clk),
        .enable(enable),
        .din(din),
        .dout(dout),
        .ready(ready)
    );
    
    initial begin
        clk = 0;
        enable = 0;
        din = 0;
        
        // Apply stimulus
        #10 enable = 1;
        #10 din = 51'b10101010101010101010101010101010101010101010101010;
        #10 dut.current_reg_overflow = 1'b1;
        #10 enable = 0;
        #10 dut.piso_overflow = 1'b1;
        #10 dut.current_reg_overflow = 1'b0;
        #10 dut.sipo_overflow = 1'b1;
        #10 dut.piso_overflow = 1'b0;
        #10 dut.sipo_empty = 1'b1;
        #10 dut.sipo_overflow = 1'b0;
        #10 dut.sipo_empty = 1'b0;
        
        // Clock generation
        forever begin
            #5 clk = ~clk;
        end
        
        // Wait for output ready
        #100;
        
        // Check output
        $display("Output: %d", dout);
        
        // Finish simulation
        $finish;
    end
endmodule
