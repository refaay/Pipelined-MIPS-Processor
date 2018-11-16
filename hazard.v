module hazard(
  input [31:0] PC,
input [4:0] rsD, rtD, rsE, rtE,
input [4:0] writeregE, writeregM, writeregW,
input regwriteE, regwriteM, regwriteW,
input memtoregE, memtoregM, memtoregW, branchD, MemWriteD, MemWriteM,
output reg [1:0] forwardaE, forwardbE,
output reg forwardaD, forwardbD, forwardM, stallF, stallD, flushE
);
  reg lwstall, branchstall;
  always @ (*) begin
    if (PC < 32'd8) begin
      forwardaD <= 1'd0;
      forwardbD <= 1'd0;
      stallF <= 1'd0;
      stallD <= 1'd0;
      flushE <= 1'd0;
      forwardaE <= 2'd0;
      forwardbE <= 2'd0;
    end
    else begin
    if ((rsE != 0) && (rsE == writeregM) && regwriteM) forwardaE <= 2'b10;
    else if ((rsE != 0) && (rsE == writeregW) && regwriteW) forwardaE <= 2'b01;
	else forwardaE <= 2'b00;
    
    if ((rtE != 0) && (rtE == writeregM) && regwriteM) forwardbE <= 2'b10;
    else if ((rtE != 0) && (rtE == writeregW) && regwriteW) forwardbE <= 2'b01;
	else forwardbE <= 2'b00;
    
      lwstall <= ((rsD == rtE) || (rtD == rtE)) && memtoregE && ~MemWriteD;
    
    forwardaD <= (rsD != 0) && (rsD == writeregM) && regwriteM;
    forwardbD <= (rtD != 0) && (rtD == writeregM) && regwriteM;
    
    branchstall <= (branchD && regwriteE && (writeregE == rsD || writeregE == rtD)) ||		(branchD && memtoregM && (writeregM == rsD || writeregM == rtD));
      
      forwardM <= memtoregW && MemWriteM && (writeregW == writeregM); // For sw after lw, last may not be equal
   /*
      flushE <= lwstall;
    stallF <= lwstall;
    stallD <= lwstall; 
*/
    flushE <= (lwstall || branchstall);
    stallF <= (lwstall || branchstall);
    stallD <= (lwstall || branchstall); 

    end
  end
  
  
endmodule