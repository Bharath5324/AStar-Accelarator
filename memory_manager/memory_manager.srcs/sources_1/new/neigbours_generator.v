`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.03.2023 10:04:22
// Design Name: 
// Module Name: neighbour_coordinates
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


module neighbour_coordinates(
    input [15:0] input_coordinate,
    input enable,
    output reg [127:0] neighbours
);

reg [7:0] x_coordinate;
reg [7:0] y_coordinate;
reg [15:0] neighbour_coordinates [7:0];
integer i;

always @(*) begin
    if (!enable) begin
        for (i = 0; i < 8; i = i + 1) begin
            neighbour_coordinates[i] <= 16'hxxxx; // Undefined value
        end
    end else begin
        x_coordinate <= input_coordinate[15:8];
        y_coordinate <= input_coordinate[7:0];

        // neighbour to the top-left
        if (x_coordinate == 0 || y_coordinate == 0) begin
            neighbour_coordinates[0] <= 16'hzzzz; // Invalid coordinate
        end else begin
            neighbour_coordinates[0] <= {x_coordinate-1'b1, y_coordinate-1'b1};
        end

        // neighbour to the top
        if (y_coordinate == 0) begin
            neighbour_coordinates[1] <= 16'h0000; // Invalid coordinate
        end else begin
            neighbour_coordinates[1] <= {x_coordinate, y_coordinate-1'b1};
        end

        // neighbour to the top-right
        if (x_coordinate == 255 || y_coordinate == 0) begin
            neighbour_coordinates[2] <= 16'h0000; // Invalid coordinate
        end else begin
            neighbour_coordinates[2] <= {x_coordinate+1'b1, y_coordinate-1'b1};
        end

        // neighbour to the left
        if (x_coordinate == 0) begin
            neighbour_coordinates[3] <= 16'h0000; // Invalid coordinate
        end else begin
            neighbour_coordinates[3] <= {x_coordinate-1'b1, y_coordinate};
        end

        // neighbour to the right
        if (x_coordinate == 255) begin
            neighbour_coordinates[4] <= 16'h0000; // Invalid coordinate
        end else begin
            neighbour_coordinates[4] <= {x_coordinate+1'b1, y_coordinate};
        end

        // neighbour to the bottom-left
        if (x_coordinate == 0 || y_coordinate == 255) begin
            neighbour_coordinates[5] <= 16'h0000; // Invalid coordinate
        end else begin
            neighbour_coordinates[5] <= {x_coordinate-1'b1, y_coordinate+1'b1};
        end

        // neighbour to the bottom
        if (y_coordinate == 255) begin
            neighbour_coordinates[6] <= 16'h0000; // Invalid coordinate
        end else begin
            neighbour_coordinates[6] <= {x_coordinate, y_coordinate+1'b1};
        end

        // neighbour to the bottom-right
        if (x_coordinate == 255 || y_coordinate == 255) begin
            neighbour_coordinates[7] <= 16'h0000; // Invalid coordinate
        end else begin
            neighbour_coordinates[7] <= {x_coordinate+1'b1, y_coordinate+1'b1};
        end
    end
    neighbours <= {neighbour_coordinates[0],neighbour_coordinates[1],neighbour_coordinates[2],neighbour_coordinates[3],neighbour_coordinates[4],neighbour_coordinates[5],neighbour_coordinates[6],neighbour_coordinates[7]};
end

endmodule