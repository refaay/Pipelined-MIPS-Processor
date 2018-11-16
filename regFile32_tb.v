// file: regFile32_tb.v
// author: @refaay
// Testbench for regFile32

`timescale 1ns/1ns

module regFile32_tb;

	//Inputs
	reg clk;
	reg we;
	reg [4: 0] ra1;
	reg [4: 0] ra2;
	reg [4: 0] wa;
	reg [31: 0] wd;


	//Outputs
	wire [31: 0] rd1;
	wire [31: 0] rd2;


	//Instantiation of Unit Under Test
	regFile32 uut (
		.clk(clk),
		.we(we),
		.ra1(ra1),
		.ra2(ra2),
		.wa(wa),
		.wd(wd),
		.rd1(rd1),
		.rd2(rd2)
	);

    always #5 clk = !clk;
	initial begin
	//Inputs initialization
		clk = 0;
		we = 0;
		ra1 = 0;
		ra2 = 0;
		wa = 0;
		wd = 0;


	//Wait for the reset
		#10;
		we = 1;
		wa = 5;
		wd = 10;
		#10;
		wa = 2;
		wd = 15;
		#10;
		we = 1;
		ra1 = 2;
		ra2 = 5;
		

	end

endmodule