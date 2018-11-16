// file: mux2.v
// author: @refaay

`timescale 1ns/1ns

module mux2(d0, d1, s, y);
parameter n = 32;
input [n-1:0] d0, d1;
input s;
output [n-1:0] y;

genvar i;
generate
for (i=0; i<n; i=i+1) begin: addbit
assign y[i] = ~s & d0[i] | s & d1[i];
end
endgenerate

endmodule