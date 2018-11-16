// file: sll4_tb.v
// author: @refaay
// Testbench for sll4

`timescale 1ns/1ns

module sll4_tb;

	//Inputs
	reg [31: 0] a;


	//Outputs
	wire [31: 0] y;


	//Instantiation of Unit Under Test
	sll4 uut (
		.a(a),
		.y(y)
	);


	initial begin
	//Inputs initialization
		a = 0;


	//Wait for the reset
		#10;
		a = 2;

	end

endmodule