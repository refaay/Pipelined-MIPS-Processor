// file: sll4.v
// author: @refaay

`timescale 1ns/1ns

module sll4(a, y);
input [31:0] a;
output [31:0] y;
assign y = a << 2;
endmodule