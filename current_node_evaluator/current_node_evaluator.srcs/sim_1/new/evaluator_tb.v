`timescale 1ns / 1ps

module evaluator_tb();
    reg clk;
    reg enable;
    reg [17:0] G_parent;
    reg [17:0] G_old;
    reg [15:0] P_node;
    reg [15:0] Goal;
    reg [15:0] Node;
    wire [17:0] Gcost;
    wire newValue;
    wire Queue_insert;
    wire [31:0] Hcost;
    wire [31:0] Fcost;

    evaluator dut (
        .clk(clk),
        .enable(enable),
        .G_parent(G_parent),
        .G_old(G_old),
        .P_node(P_node),
        .Goal(Goal),
        .Node(Node),
        .Gcost(Gcost),
        .newValue(newValue),
        .Queue_insert(Queue_insert),
        .Hcost(Hcost),
        .Fcost(Fcost)
    );
    
    initial clk = 1'b0;
    always #5 clk = ~clk;

    initial begin
        clk = 1'b0;
        enable = 1'b0;
        G_parent = 16'h0000;
        G_old = 16'h0000;
        P_node = 16'h5677;
        Goal = 16'h1234;
        Node = 16'h5678;

        #10;
        enable = 1'b1;
        G_parent = 16'h0001;
        G_old = 16'h0002;
        P_node = 16'h5899;
        Goal = 16'h1234;
        Node = 16'h5898;

        #10;
        enable = 1'b1;
        G_parent = 16'h0002;
        G_old = 16'h0003;
        P_node = 16'h1133;
        Goal = 16'h9876;
        Node = 16'h1234;

        #10;
        $finish;
    end

endmodule