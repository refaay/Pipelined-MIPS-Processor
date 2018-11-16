// file: SCProcessor_tb.v
// author: @refaay
// Testbench for SCProcessor

`timescale 1ns/1ns

module SCProcessor_tb;

	//Inputs
	reg clk;
	reg rst;


	//Outputs


	//Instantiation of Unit Under Test
	SCProcessor uut (
		.clk(clk),
		.rst(rst)
	);

	 always #5 clk = !clk;
	initial begin
	//Inputs initialization
		clk = 0;
		rst = 1;


	//Wait for the reset
		
      #20;
      rst = 0;
      $dumpfile("dump.vcd"); 
      $dumpvars;
      /*
      #5;
      $display("PC=%h", uut.PC.q);
      #5;
      $display("PC=%h", uut.PC.q);
      $display("$2=%h", uut.Regs.regFile[2]);
      $display("$3=%h", uut.Regs.regFile[3]);
      $display("$7=%h", uut.Regs.regFile[7]);
      $display("$4=%h", uut.Regs.regFile[4]);
      $display("$5=%h", uut.Regs.regFile[5]);
      #5;
      $display("PC=%h", uut.PC.q);
      #5;
      $display("PC=%h", uut.PC.q);
      $display("$2=%h", uut.Regs.regFile[2]);
      $display("$3=%h", uut.Regs.regFile[3]);
      $display("$7=%h", uut.Regs.regFile[7]);
      $display("$4=%h", uut.Regs.regFile[4]);
      $display("$5=%h", uut.Regs.regFile[5]);
      #5;
      $display("PC=%h", uut.PC.q);
      #5;
      $display("PC=%h", uut.PC.q);
      $display("$2=%h", uut.Regs.regFile[2]);
      $display("$3=%h", uut.Regs.regFile[3]);
      $display("$7=%h", uut.Regs.regFile[7]);
      $display("$4=%h", uut.Regs.regFile[4]);
      $display("$5=%h", uut.Regs.regFile[5]);
      #5;
      $display("PC=%h", uut.PC.q);
      #5;
      $display("PC=%h", uut.PC.q);
      $display("$2=%h", uut.Regs.regFile[2]);
      $display("$3=%h", uut.Regs.regFile[3]);
      $display("$7=%h", uut.Regs.regFile[7]);
      $display("$4=%h", uut.Regs.regFile[4]);
      $display("$5=%h", uut.Regs.regFile[5]);
      #5;
      $display("PC=%h", uut.PC.q);
      #5;
      $display("PC=%h", uut.PC.q);
      $display("$2=%h", uut.Regs.regFile[2]);
      $display("$3=%h", uut.Regs.regFile[3]);
      $display("$7=%h", uut.Regs.regFile[7]);
      $display("$4=%h", uut.Regs.regFile[4]);
      $display("$5=%h", uut.Regs.regFile[5]);
      #5;
      $display("PC=%h", uut.PC.q);
      #5;
      $display("PC=%h", uut.PC.q);
      $display("$2=%h", uut.Regs.regFile[2]);
      $display("$3=%h", uut.Regs.regFile[3]);
      $display("$7=%h", uut.Regs.regFile[7]);
      $display("$4=%h", uut.Regs.regFile[4]);
      $display("$5=%h", uut.Regs.regFile[5]);
      #5;
      $display("PC=%h", uut.PC.q);
      #5;
      $display("PC=%h", uut.PC.q);
      $display("$2=%h", uut.Regs.regFile[2]);
      $display("$3=%h", uut.Regs.regFile[3]);
      $display("$7=%h", uut.Regs.regFile[7]);
      $display("$4=%h", uut.Regs.regFile[4]);
      $display("$5=%h", uut.Regs.regFile[5]);
      #5;
      $display("PC=%h", uut.PC.q);
      #5;
      $display("PC=%h", uut.PC.q);
      $display("$2=%h", uut.Regs.regFile[2]);
      $display("$3=%h", uut.Regs.regFile[3]);
      $display("$7=%h", uut.Regs.regFile[7]);
      $display("$4=%h", uut.Regs.regFile[4]);
      $display("$5=%h", uut.Regs.regFile[5]);
      #5;
      $display("PC=%h", uut.PC.q);
      #5;
      $display("PC=%h", uut.PC.q);
      $display("$2=%h", uut.Regs.regFile[2]);
      $display("$3=%h", uut.Regs.regFile[3]);
      $display("$7=%h", uut.Regs.regFile[7]);
      $display("$4=%h", uut.Regs.regFile[4]);
      $display("$5=%h", uut.Regs.regFile[5]);
      #5;
      $display("PC=%h", uut.PC.q);
      #5;
      $display("PC=%h", uut.PC.q);
      $display("$2=%h", uut.Regs.regFile[2]);
      $display("$3=%h", uut.Regs.regFile[3]);
      $display("$7=%h", uut.Regs.regFile[7]);
      $display("$4=%h", uut.Regs.regFile[4]);
      $display("$5=%h", uut.Regs.regFile[5]);
      #5;
      $display("PC=%h", uut.PC.q);
      #5;
      $display("PC=%h", uut.PC.q);
      $display("$2=%h", uut.Regs.regFile[2]);
      $display("$3=%h", uut.Regs.regFile[3]);
      $display("$7=%h", uut.Regs.regFile[7]);
      $display("$4=%h", uut.Regs.regFile[4]);
      $display("$5=%h", uut.Regs.regFile[5]);
      #5;
      $display("PC=%h", uut.PC.q);
      #5;
      $display("PC=%h", uut.PC.q);
      $display("$2=%h", uut.Regs.regFile[2]);
      $display("$3=%h", uut.Regs.regFile[3]);
      $display("$7=%h", uut.Regs.regFile[7]);
      $display("$4=%h", uut.Regs.regFile[4]);
      $display("$5=%h", uut.Regs.regFile[5]);
      $display("Mem[80]=%h", uut.RAM.RAM[80]);
      #5;
      $display("PC=%h", uut.PC.q);
      #5;
      $display("PC=%h", uut.PC.q);
      $display("$2=%h", uut.Regs.regFile[2]);
      $display("$3=%h", uut.Regs.regFile[3]);
      $display("$7=%h", uut.Regs.regFile[7]);
      $display("$4=%h", uut.Regs.regFile[4]);
      $display("$5=%h", uut.Regs.regFile[5]);
      $display("Mem[80]=%h", uut.RAM.RAM[80]);
      #5;
      $display("PC=%h", uut.PC.q);
      #5;
      $display("PC=%h", uut.PC.q);
      $display("$2=%h", uut.Regs.regFile[2]);
      $display("$3=%h", uut.Regs.regFile[3]);
      $display("$7=%h", uut.Regs.regFile[7]);
      $display("$4=%h", uut.Regs.regFile[4]);
      $display("$5=%h", uut.Regs.regFile[5]);
      $display("Mem[80]=%h", uut.RAM.RAM[80]);
      */
      #1000;
      $display("Mem[84]=%h", uut.RAM.RAM[84]);
		$finish;

	end

endmodule