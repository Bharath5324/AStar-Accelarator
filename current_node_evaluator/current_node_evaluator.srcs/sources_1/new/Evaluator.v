`timescale 1ns / 1ps

module evaluator(
    input clk,
    input enable,
    input [17:0] G_parent,
    input [17:0] G_old,
    input [15:0] Goal,
    input [15:0] Node,
    input [15:0] P_node,
    output reg newValue,
    output reg Queue_insert,
    output reg [17:0] Gcost,
    output reg [31:0] Hcost,
    output reg [31:0] Fcost
);
    parameter D = 7;
    parameter D2 = 10;
    
    reg [15:0] cost;
    
    reg [17:0] G_new;
//    reg [15:0] G_cost_temp;
//    reg Queue_insert_temp;
//    reg newValue_temp;
    reg [7:0] dx;
    reg [7:0] dy;
    reg [7:0] min;
//    reg [31:0] Hcost_temp;
//    reg [31:0] Fcost_temp;

    always @ (posedge clk) begin
        if (enable) begin
            if ((Node[15:8] != P_node[15:8]) && (Node[7:0] != P_node[7:0]))
                 cost = 7; // Assign a value of 7 if diagonal
             else
                 cost = 5; // Assign a value of 5 if not diagonal
            G_new = G_parent + cost;
            if (G_new < G_old) begin
                Gcost = G_new;
                newValue = 1'b1;
                Queue_insert = 1'b1;
            end else begin
                Gcost = G_old;
                newValue = 1'b0;
                Queue_insert = 1'b0;
            end
            dx = (Goal[15:8] > Node[15:8])? Goal[15:8] - Node[15:8] : Node[15:8] - Goal[15:8];
//            dx <= Goal[15:8] - Node[15:8];
            dy = (Goal[7:0] > Node[7:0])? Goal[7:0] - Node[7:0] : Node[7:0] - Goal[7:0];
//            dy <= Goal[7:0] - Node[7:0];
            if (dx < dy) begin
                min = dx;
            end else begin
                min = dy;
            end
            Hcost = (dx + dy) * D + min * (2*D - D2);
            Fcost = Gcost + Hcost;
        end
    end
    
endmodule