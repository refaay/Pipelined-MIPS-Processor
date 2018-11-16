// file: SCProcessor.v
// author: @refaay

`timescale 1ns/1ns

module SCProcessor(clk, rst);
  parameter N = 4*1024; // depth(number of locations)
  parameter M = 32; // width(width of each location)
  input clk, rst; // Sequential Inputs
  wire RegWrite, MemWrite, ALUZero, PCIncCo, ALUSrc, MemtoReg, RegDst, Branch, PCSrc, PCBranchCo, Jump;
  wire [2:0] ALUControl;
  wire [4:0] A3;
  wire [M-1:0]Instr, RD1, RD2, SignImm, ALUResult, RAMOut, PCIn, PCOut, SrcB, WD3, PCPlus4, PCBranch, PCBranchTemp, PCJump, SignImm4; // Needed Buses
  assign PCSrc = Branch&ALUZero;
  flopr_param PC (clk, rst, PCIn, PCOut); // PC Flip Flop(clk, rst, d, q)
  rom ROM (clk, PCOut, Instr); // Instruction Memory
  regFile32 Regs (clk, RegWrite, Instr[25:21], Instr[20:16], A3, WD3, RD1, RD2); // Register File (clk, we, ra1, ra2, wa, wd, rd1, rd2)
  signext SignExt(Instr[15:0], SignImm); // Immediate Sign Extender
  alu32 ALU (RD1, SrcB, ALUControl[2:0], Instr[10:6], ALUResult, ALUZero); // ALU alu32(a, b, f, shamt, y, zero)
  ram RAM (clk, MemWrite, ALUResult, RD2, RAMOut); // Data Memory (clk, we, adr, din, dout);
  adder PCInc (PCOut, 32'd4, 1'd0, PCPlus4, PCIncCo); // PC+4 (a, b, ci, s, co)
  mux2 ALUSrcBMux (RD2, SignImm, ALUSrc, SrcB); // Sourse B select (d0, d1, s, y)
  mux2 MemtoRegMux (ALUResult, RAMOut, MemtoReg, WD3); // MemtoReg select (d0, d1, s, y)
  mux2 #(5) RegDstMux (Instr[20:16], Instr[15:11], RegDst, A3); // Destination reg select (d0, d1, s, y)
  assign PCJump = {PCPlus4[31:28], Instr[25:0]<<2};
  mux2 PCSrcMux (PCPlus4, PCBranch, PCSrc, PCBranchTemp); // PC Source select (d0, d1, s, y)
  mux2 PCJumpMux (PCBranchTemp, PCJump, Jump, PCIn); // PC Source select (d0, d1, s, y)
  sll4 Branch4sll (SignImm, SignImm4); // Branch immediate *4 (a, y)
  adder PCBranchAdd (SignImm4, PCPlus4, 1'd0, PCBranch, PCBranchCo); // Branch calculation (a, b, ci, s, co)
  ctrlUnit CtrlUnit(Instr[31:26], Instr[5:0], MemtoReg, MemWrite, Branch, ALUSrc, RegDst, RegWrite, Jump, ALUControl); // Control Unit (Op, Funct, MemtoReg, MemWrite, Branch, ALUSrc, RegDst, RegWrite, Jump, ALUControl)
  always @(posedge clk) begin // Synchronus Processing
    if (rst) begin // Reset logic goes here
            
        end
        else begin // Sequential logic goes here
            
        end
    end
endmodule