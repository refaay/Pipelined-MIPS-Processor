// file: alu32.v
// author: @refaay

`timescale 1ns/1ns

module alu32(a, b, f, shamt, y, zero);
	input signed [31:0] a;
	input signed [31:0] b;
	input [2:0] f;
	input [4:0] shamt;
	output reg [31:0] y;
	output zero;

assign zero = (y == 32'd0);

always @ * begin
case (f) 
4'd0: y <= a&b; // And
4'd1: y <= a|b; // Or
4'd2: y <= a+b; // Add 
//4'd3: 
//4'd4: y <= a^b; // Xor
//4'd5: y <= a << shamt; // logical shift left by amount
4'd6: y <= a-b; // Sub 
 //y <= a >> shamt; // logical shift right by amount
4'd7: y <= (a<b)? 32'd1: 32'd0;
  //y <= a <<< shamt; // arithmetic shift left by amount
//4'd8: y <= a >>> shamt; // arithmetic shift right by amount
default: y <= 32'd0;
endcase
end

endmodule