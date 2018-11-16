// file: mux4_tb.v
// author: @refaay
// Testbench for mux4

`timescale 1ns/1ns

module mux4_tb;

	//Inputs
	reg [1: 0] d0;
	reg [1: 0] d1;
	reg [1: 0] d2;
	reg [1: 0] d3;
	reg [1: 0] s;


	//Outputs
	wire [1: 0] y;


	//Instantiation of Unit Under Test
	mux4 uut (
		.d0(d0),
		.d1(d1),
		.d2(d2),
		.d3(d3),
		.s(s),
		.y(y)
	);


	initial begin
	//Inputs initialization
		d0 = 0;
		d1 = 0;
		d2 = 0;
		d3 = 0;
		s = 0;


	//Wait for the reset
		#10;
		d0 = 0;
		d1 = 1;
		d2 = 2;
		d3 = 3;
		s = 0;
		#10;
		d0 = 0;
		d1 = 1;
		d2 = 2;
		d3 = 3;
		s = 1;
		#10;
		d0 = 0;
		d1 = 1;
		d2 = 2;
		d3 = 3;
		s = 2;
		#10;
		d0 = 0;
		d1 = 1;
		d2 = 2;
		d3 = 3;
		s = 3;

	end

endmodule