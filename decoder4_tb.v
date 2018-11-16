// file: decoder4_tb.v
// author: @refaay
// Testbench for decoder4

`timescale 1ns/1ns

module decoder4_tb;

	//Inputs
	reg [3: 0] a;


	//Outputs
	wire [15: 0] y;


	//Instantiation of Unit Under Test
	decoder4 uut (
		.a(a),
		.y(y)
	);

    integer i;
	initial begin
	//Inputs initialization
		a = 0;


	//Wait for the reset
		#10;
		for (i = 0; i<16; i = i+1)
		#10 a = i;

	end

endmodule