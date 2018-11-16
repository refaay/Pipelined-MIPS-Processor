// file: signext_tb.v
// author: @refaay
// Testbench for signext

`timescale 1ns/1ns

module signext_tb;

	//Inputs
	reg [15: 0] a;


	//Outputs
	wire [31: 0] y;


	//Instantiation of Unit Under Test
	signext uut (
		.a(a),
		.y(y)
	);


	initial begin
	//Inputs initialization
		a = 0;


	//Wait for the reset
		#10;
		a = 16'hffff;
		#10;
		a = 16'h0f0f;

	end

endmodule