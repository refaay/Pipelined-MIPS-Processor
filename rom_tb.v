// file: rom_tb.v
// author: @refaay
// Testbench for rom

`timescale 1ns/1ns

module rom_tb;

	//Inputs
	reg clk;
	reg [31: 0] adr;


	//Outputs
	wire [31: 0] dout;


	//Instantiation of Unit Under Test
	rom uut (
		.clk(clk),
		.adr(adr),
		.dout(dout)
	);


		always #10 clk = !clk;
  	initial begin
      $dumpfile("dump.vcd");
      $dumpvars;
    end

	initial begin
	//Inputs initialization
		adr = 0;
        clk = 0;

	//Wait for the reset
		#20;
		$display("dout=%h", dout);
      #20;
      adr = 1;
		$display("dout=%h", dout);
       #20;
      adr = 2;
		$display("dout=%h", dout);
       #20;
      adr = 3;
		$display("dout=%h", dout);
       #20;
      adr = 4;
		$display("dout=%h", dout);
       #20;
      adr = 5;
		$display("dout=%h", dout);
		$finish;

	end

endmodule