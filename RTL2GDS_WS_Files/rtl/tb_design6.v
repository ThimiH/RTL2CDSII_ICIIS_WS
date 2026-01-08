`timescale 1ns/1ps

module tb_design6;
    localparam WIDTH = 4;

    reg clk;
    reg rst_n;
    reg start;
    reg [WIDTH-1:0] A, B, C, D;
    wire [WIDTH+1:0] F;
    wire valid;

    design6_seq #(.WIDTH(WIDTH)) dut (
        .clk(clk),
        .rst_n(rst_n),
        .start(start),
        .A(A),
        .B(B),
        .C(C),
        .D(D),
        .F(F),
        .valid(valid)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        $dumpfile("design6.vcd");
        $dumpvars(0, tb_design6);
    end

    initial begin
        rst_n = 0;
        start = 0;
        A = 0; B = 0; C = 0; D = 0;
        repeat (2) @(posedge clk);
        rst_n = 1;

        @(posedge clk);
        A = 4'd3; B = 4'd5; C = 4'd7; D = 4'd2;
        start = 1;
        @(posedge clk);
        start = 0;

        wait (valid);
        if (F !== (A + B + C + D)) begin
            $display("ERROR: Expected %0d, got %0d", A + B + C + D, F);
        end else begin
            $display("PASS: Result %0d valid", F);
        end

        repeat (5) @(posedge clk);
        $finish;
    end
endmodule
