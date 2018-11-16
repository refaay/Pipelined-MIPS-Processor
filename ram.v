// file: ram.v
// author: @refaay

`timescale 1ns/1ns

module ram(clk, we, adr, din, dout);
    parameter N = 4*1024; // depth(number of locations)
    parameter M = 32; // width(width of each location)
    input clk, we;
  input [M-1:0] adr;
    input [M-1:0] din;
    output [M-1:0]dout;
  reg [M-1:0] RAM [0:N-1];
    assign dout = RAM[adr];
  always @(*) begin
    #1 if (we) RAM[adr] <= din; // #1 may be wrong, but solves race condition
    end
endmodule