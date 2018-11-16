// file: flopr_param_tb.v
// author: @refaay
// Testbench for flopr_param

`timescale 1ns/1ns

module flopr_param_tb;

	//Inputs
	reg clk;
	reg rst;
	reg [2: 0] d;


	//Outputs
	wire [2: 0] q;


	//Instantiation of Unit Under Test
	flopr_param uut (
		.clk(clk),
		.rst(rst),
		.d(d),
		.q(q)
	);

    always #5 clk = !clk;
	initial begin
	//Inputs initialization
		clk = 0;
		rst = 1;
		d = 0;


	//Wait for the reset
		#10;
		rst = 0;
		d = 1;
		#10;
		d = 2;
		#10;
		rst = 1;

	end

endmodule