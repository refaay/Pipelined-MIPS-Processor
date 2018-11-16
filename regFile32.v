// file: regFile32.v
// author: @refaay

`timescale 1ns/1ns

module regFile32(clk, we, ra1, ra2, wa, wd, rd1, rd2);
    input clk, we;
    input [4:0] ra1, ra2, wa;
    input [31:0] wd;
    output reg [31:0] rd1, rd2;
  	reg [31:0] regFile [0:31];
  assign regFile[0] = 32'd0;  
  /*  always @ * begin
     rd1 = regFile[ra1];
     rd2 = regFile[ra2];
      #1 if (we) regFile[wa] = wd; // #1 may be wrong, but solves race condition
    end */
  
  always @ (posedge clk) begin
    #1 if (we) regFile[wa] <= wd; 
    end 
  always @ (negedge clk or posedge clk) begin
   rd1 <= regFile[ra1];
   rd2 <= regFile[ra2];
  end
  
endmodule