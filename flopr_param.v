// file: flopr_param.v
// author: @refaay

`timescale 1ns/1ns

module flopr_param(clk, rst, d, q);
    parameter n = 32;
    input clk, rst;
    input [n-1:0] d;
    output reg [n-1:0] q;

    always @(posedge clk) begin
        if (rst) begin
            //Reset logic goes here.
            q<= 0;
        end
        else begin
            //Sequential logic goes here.
            q <= d;
        end
    end
endmodule