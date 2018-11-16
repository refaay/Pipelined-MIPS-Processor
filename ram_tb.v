// file: ram_tb.v
// author: @refaay
// Testbench for ram

`timescale 1ns/1ns

module ram_tb;

	//Inputs
	reg clk;
	reg we;
	reg [4095: 0] adr;
	reg [7: 0] din;


	//Outputs
	wire [7: 0] dout;


	//Instantiation of Unit Under Test
	ram uut (
		.clk(clk),
		.we(we),
		.adr(adr),
		.din(din),
		.dout(dout)
	);

    always #5 clk = !clk;

	initial begin
	//Inputs initialization
		clk = 0;
		we = 0;
		adr = 0;
		din = 0;


	//Wait for the reset
		#10;
		we = 1;
		adr = 5;
		din = 10;
		#10;
		we = 0;
		adr = 2;
		din = 15;
		#10;
		we = 1;
		adr = 2;
		#10;
		adr = 5;

	end

endmodule