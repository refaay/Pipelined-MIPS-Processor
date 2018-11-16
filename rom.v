// file: rom.v
// author: @refaay

`timescale 1ns/1ns

module rom(clk, adr, dout);
    parameter N = 64; // depth(number of locations)
    parameter M = 32; // width(width of each location)
  input clk;
  input [M-1:0] adr;
    output reg [M-1:0] dout;
  reg [M-1:0] ROM [0:N-1];
    initial begin
    $readmemh ("Instructions.txt", ROM);
    end
  always @*begin
    dout <= ROM[adr>>2];
  end
endmodule
