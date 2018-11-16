// file: alu32_tb.v
// author: @refaay
// Testbench for alu32

`timescale 1ns/1ns

module alu32_tb;

	//Inputs
	reg signed [31:0] a;
	reg signed [31:0] b;
	reg [3: 0] f;
	reg [4: 0] shamt;


	//Outputs
	wire [31: 0] y;
	wire zero;


	//Instantiation of Unit Under Test
	alu32 uut (
		.a(a),
		.b(b),
		.f(f),
		.shamt(shamt),
		.y(y),
		.zero(zero)
	);

    integer i;
	initial begin
	//Inputs initialization
		a = 0;
		b = 0;
		f = 0;
		shamt = 0;

    
	//Wait for the reset
		#10;
        a = 32'hffffffff;
        b = 32'd4;
        shamt = 5'd2;
        for (i = 0; i < 32; i = i + 1) begin
        f = i;
        #10;
        end
        
	end

endmodule