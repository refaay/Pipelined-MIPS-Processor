// file: decoder4.v
// author: @refaay

`timescale 1ns/1ns

module decoder4(a, y);
input [3:0] a;
output [15:0] y;
assign y = 1 << a;

endmodule