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
    input [50:0] din,
    output reg [407:0] dout,
    output reg ready   
    );
    
    // State control nets and patameters
    reg [2:0] state;
    parameter a = 3'b000, b = 3'b001, c = 3'b010 , d = 3'b011, e = 3'b100;
    
    // Control signal nets
    
    reg current_reg_en, piso_wr_en, piso_rd_en, sipo_en, bram_en, bram_we;
    reg bram_write_ack;
    
    // Current register nets and instantiation
    
    wire [50:0] current_data;
    wire current_reg_overflow;
    
    current_reg current(.din(din), .clk(clk), .enable(current_reg_en), .dout(current_data), .overflow(current_reg_overflow));
    
    
   // Neigbour address genrator nets and instantiation
   
    wire [127:0] neighbour_address;
    
    neighbour_coordinates address_gen(.input_coordinate(current_data[15:0]), .neighbours(neighbour_address));
    
    // BRAM nets and instantiation
    
    reg [15:0] address_bus;
    
    wire [34:0] bram_data;
    
    blockram ram(.clka(clk), .clkb(clk), .ena(bram_en), .enb(), .wea(bram_we), .web(), .addra(address_bus), .addrb(), .dia(current_data[50:16]), .dib(), .doa(bram_data), .dob());
        
    // PISO nets and instantiation
    
    wire [15:0] piso_out;
    wire piso_overflow;
    piso_128bit piso(.clk(clk), .reset(), .data_in(neighbour_address), .write_en(piso_wr_en), .read_en(piso_rd_en), .out(piso_out), .piso_overflow(piso_overflow));
    
    
    // FIFO nets and instantiation
    
    wire [15:0] fifo_out;
    
    fifo f1(.clk(clk), .din(piso_out), .dout(fifo_out));
    
    // SIPO nets and instantiation
    wire sipo_overflow;
    wire [127:0] dout_wire;
    wire sipo_empty;
    sipo s1(.clk(clk), .data_in({bram_data, fifo_out}), .rst(), .enable(sipo_en), .data_out(dout_wire), .sipo_overflow(sipo_overflow), .sipo_empty(sipo_empty));
    
    
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
        b: begin
            current_reg_en <= 1'b1;
            end
        c: begin 
            piso_wr_en<= 1'b1; current_reg_en <= 1'b0; address_bus <= current_data[15:0];
           end
        d: begin 
            piso_wr_en<= 1'b0; piso_rd_en<= 1'b1; sipo_en <= 1'b1; bram_en <= 1'b1; address_bus <= piso_out;
           end
        e: begin
            ready <= 1'b1;
            dout <= dout_wire;
           end
        endcase
    end
endmodule
