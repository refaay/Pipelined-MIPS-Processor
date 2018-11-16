// file: mux2_tb.v
// author: @refaay
// Testbench for mux2

`timescale 1ns/1ns

module mux2_tb;

	//Inputs
	reg [0: 0] d0;
	reg [0: 0] d1;
	reg s;


	//Outputs
	wire [0: 0] y;


	//Instantiation of Unit Under Test
	mux2 uut (
		.d0(d0),
		.d1(d1),
		.s(s),
		.y(y)
	);


	initial begin
	//Inputs initialization
		d0 = 0;
		d1 = 0;
		s = 0;


	//Wait for the reset
		#10;
		d0 = 0;
		d1 = 1;
		s = 0;
		#10;
		d0 = 0;
		d1 = 1;
		s = 1;

	end

endmodule