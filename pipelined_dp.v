`timescale 1ns/1ns

module pipelined_datapath(/*AUTOARG*/
  
  // Outputs
  // zero_flg, pc, mem_data_addr, data_to_mem,
   // Inputs
   clk, rst
  //, mem_to_reg_ctrl, pc_src_ctrl, alu_src_ctrl, reg_dst_ctrl,
   //reg_write_en, jump_ctrl, alu_func_ctrl, instr, data_from_mem
   );
   //clock signal
   input          clk;
   //active-high reset
   input 	  rst;
   //input          mem_to_reg_ctrl;
   //input 	  pc_src_ctrl;
   //input [1:0] 	  alu_src_ctrl;
   //input          reg_dst_ctrl;
   //input          reg_write_en;
   //input 	  jump_ctrl;
   //input [2:0] 	  alu_func_ctrl;
   //output         zero_flg;
   //output [31:0]  pc;
   //input [31:0]   instr;
   //output [31:0]  mem_data_addr, data_to_mem;
   //input [31:0]   data_from_mem;
   ///////////////////////////////////////////
   ///Register signals
   ///////////////////////////////////////////
   // three ported register file
   // read two ports combinationally
   // write third port on rising edge of clock
   // register 0 hardwired to 0
   reg [31:0] rf[31:0];

   ///////////////////////////////////////////
   /// Reg file signals
   ///////////////////////////////////////////
   //Reg file write enable (active high)
   wire       we;
   // read addr 1, read addr 2, and write addr
   wire [4:0] ra1, ra2, wa;
   wire [31:0] wd;
   wire [31:0] rd1, rd2;
   ///////////////////////////////////////////
   /// Instr decoding signals
   ///////////////////////////////////////////
    //R-type fields
   wire [5:0]   opcode, RType_funct;
  wire [4:0] RType_rs, RType_rt, RType_rd, RType_shamt;
   //I-type fields
  wire [4:0]IType_rs, IType_rt;
  wire [15:0] IType_imm ;
   //J-type fields
   wire [25:0]JType_addr;
   ///////////////////////////////////////////
   /// fetch stage signals
   ///////////////////////////////////////////
   wire [31:0] 	 PC_Next_dp;
   reg [31:0] 	 PC_F_dp;
   wire [31:0] 	 PCPlus4_F_dp;
  wire [31:0] 	 Instr_F_dp;
   ///////////////////////////////////////////
   /// decode stage signals
   ///////////////////////////////////////////
   reg [31:0] 	 Instr_D_dp;
   reg [31:0] 	 PCPlus4_D_dp;
   wire [31:0] 	 RegRdData1_D_dp;
   wire [31:0] 	 RegRdData2_D_dp;
   wire [31:0] 	 SignImm_D_dp;
   wire [4:0] 	 DstAddrIType_D_dp;
   wire [4:0] 	 DstAddrRType_D_dp;
   wire RegWrite_D_cu, MemWrite_D_cu, ALUSrc_D_cu, MemtoReg_D_cu, RegDst_D_cu, Branch_D_cu;
   wire [2:0] ALUControl_D_cu;
   ///////////////////////////////////////////
   /// Excute stage signals
   ///////////////////////////////////////////
   //signals from decode
  //reg [31:0] 	 PCPlus4_E_dp;
   reg [31:0] 	 RegRdData1_E_dp;
   reg [31:0] 	 RegRdData2_E_dp;
   reg [31:0] 	 SignImm_E_dp;  
   reg [4:0] 	SrcAddrRType_E_dp;
   reg [4:0] 	 DstAddrIType_E_dp;
   reg [4:0] 	 DstAddrRType_E_dp;
  reg RegWrite_E_cu, MemWrite_E_cu, ALUSrc_E_cu, MemtoReg_E_cu, RegDst_E_cu, Branch_E_cu;
  reg [2:0] ALUControl_E_cu;
   //internal signals
   wire   ZFlag_E_dp;
  wire [31:0] ALUOut_E_dp;
  wire [4:0] WriteReg_E_dp;
  wire [31:0] PCBranch_D_dp;
  wire [31:0] SignImmShft_D_dp;
  wire [31:0] SrcB_E_dp;

   ///////////////////////////////////////////
   /// Memory stage signals
   ///////////////////////////////////////////
  reg   ZFlag_M_dp;
  reg [31:0] ALUOut_M_dp;
  reg [4:0] WriteReg_M_dp;
  //reg [31:0] PCBranch_M_dp;
  wire [31:0] ReadData_M_dp;
  reg [31:0] WriteData_M_dp, WriteData_M_temp_dp;
  reg RegWrite_M_cu, MemWrite_M_cu, MemtoReg_M_cu, Branch_M_cu;
  wire PCSrc_D_cu;
     ///////////////////////////////////////////
   /// write-back stage signals
   /////////////////////////////////////////// 
  reg [31:0] ALUOut_W_dp;
  reg [4:0] WriteReg_W_dp;
  wire [31:0] Result_W_dp;
  reg [31:0] ReadData_W_dp;
  reg RegWrite_W_cu, MemtoReg_W_cu;
  
   ///////////////////////////////////////////
   /// Instr decoding
   ///////////////////////////////////////////
   //R-type fields
   //assign opcode = instr[31:26];
   //assign RType_funct = instr[5:0];
   //assign RType_rs = instr[25:21];
   //assign RType_rt= instr[20:16];
   //assign RType_rd = instr[15:11];
   //assign RType_shamt = instr[10:6];
   //I-type fields
   //assign IType_rs = instr[25:21];
   //assign IType_rt = instr[20:16];
   //assign IType_imm = instr[15:0];
   //J-type fields
   //assign JType_addr = instr[25:0];

   ///////////////////////////////////////////
   /// Fetch stage
   ///////////////////////////////////////////
   //Next PC adder
  assign PCPlus4_F_dp = PC_F_dp + 32'd4;
   //Mux to choose between PCBranch and PCPlus4
  assign PC_Next_dp =  PCSrc_D_cu? PCBranch_D_dp : PCPlus4_F_dp;
   //PC register
  always @(posedge clk) begin
   if (rst)     PC_F_dp <= 32'd0;
    else if (~stallF) begin
      
    PC_F_dp <= PC_Next_dp;
    end
  end
  // Instruction Memory
    rom ROM (clk, PC_F_dp, Instr_F_dp); // Instruction Memory
   ///////////////////////////////////////////
   /// decoder register
   ///////////////////////////////////////////
  always @ (posedge clk) begin
    if (PCSrc_D_cu) begin
   // #1;
      Instr_D_dp <= 32'd0;
    PCPlus4_D_dp <= 32'd0;
    end
    else if (~stallD) begin
      //Instr_D_dp <= (PC_F_dp < 32'd4)? 32'dx :Instr_F_dp;
      Instr_D_dp <=Instr_F_dp;
    PCPlus4_D_dp <= PCPlus4_F_dp;
    end
  end
   ///////////////////////////////////////////
   /// decoder stage
   ///////////////////////////////////////////
  ctrlUnit CtrlUnit(Instr_D_dp[31:26], Instr_D_dp[5:0], MemtoReg_D_cu, MemWrite_D_cu, Branch_D_cu, ALUSrc_D_cu, RegDst_D_cu, RegWrite_D_cu, ALUControl_D_cu); // Control Unit (Op, Funct, MemtoReg, MemWrite, Branch, ALUSrc, RegDst, RegWrite, ALUControl)
  regFile32 Regs (clk, RegWrite_W_cu, Instr_D_dp[25:21], Instr_D_dp[20:16], WriteReg_W_dp, Result_W_dp, RegRdData1_D_dp, RegRdData2_D_dp); // Register File (clk, we, ra1, ra2, wa, wd, rd1, rd2)
  assign SignImm_D_dp = {{16{Instr_D_dp[15]}}, Instr_D_dp[15:0]};
  
  wire Equal_D_dp; // hazard
  wire [31:0] rd1comp, rd2comp;
  assign rd1comp = (forwardaD)?  ALUOut_M_dp:  RegRdData1_D_dp;
  assign rd2comp = (forwardbD)?  ALUOut_M_dp:  RegRdData2_D_dp;
  assign Equal_D_dp = (rd1comp == rd2comp);
  assign PCSrc_D_cu = (PC_F_dp < 32'd4)? 1'b0 : Branch_D_cu & Equal_D_dp;


   ///////////////////////////////////////////
   /// Execute register
   ///////////////////////////////////////////
  always @ (posedge clk) begin
    if (flushE) begin
      RegWrite_E_cu <= 1'b0;
    MemWrite_E_cu <= 1'b0;
    ALUSrc_E_cu <= 1'b0;
    MemtoReg_E_cu <= 1'b0;
    RegDst_E_cu <= 1'b0;
    Branch_E_cu <= 1'b0;
    ALUControl_E_cu <= 2'd0;
    SrcAddrRType_E_dp <= 5'd0;
    DstAddrIType_E_dp <= 5'd0;
    DstAddrRType_E_dp <= 5'd0;
    RegRdData1_E_dp <= 32'd0;
    RegRdData2_E_dp <= 32'd0;
    SignImm_E_dp <= 32'd0;
	//PCPlus4_E_dp <= 32'd0;
    end 
    else begin
    RegWrite_E_cu <= RegWrite_D_cu;
    MemWrite_E_cu <= MemWrite_D_cu;
    ALUSrc_E_cu <= ALUSrc_D_cu;
    MemtoReg_E_cu <= MemtoReg_D_cu;
    RegDst_E_cu <= RegDst_D_cu;
    Branch_E_cu <= Branch_D_cu;
    ALUControl_E_cu <= ALUControl_D_cu;
    SrcAddrRType_E_dp <= Instr_D_dp[25:21];
    DstAddrIType_E_dp <= Instr_D_dp[20:16];
    DstAddrRType_E_dp <= Instr_D_dp[15:11];
    RegRdData1_E_dp <= RegRdData1_D_dp;
    RegRdData2_E_dp <= RegRdData2_D_dp;
    SignImm_E_dp <= SignImm_D_dp;
	//PCPlus4_E_dp <= PCPlus4_D_dp;
    end
    end
	 //////////////////////////////////////////
   /// Execute stage
   ///////////////////////////////////////////
  assign WriteReg_E_dp = RegDst_E_cu? DstAddrRType_E_dp : DstAddrIType_E_dp;
  assign SrcB_E_dp = ALUSrc_E_cu? SignImm_E_dp : forwardbEOut;
  assign SignImmShft_D_dp = SignImm_D_dp << 2'd2;
  assign PCBranch_D_dp = PCPlus4_D_dp + SignImmShft_D_dp;
  alu32 ALU (forwardaEOut, SrcB_E_dp, ALUControl_E_cu, 5'd0, ALUOut_E_dp, ZFlag_E_dp); // ALU alu32(a, b, f, shamt, y, zero)
  wire [31:0] forwardaEOut, forwardbEOut;
  mux4 ForwardAE_mux(RegRdData1_E_dp, Result_W_dp, ALUOut_M_dp, 32'd0, forwardaE,forwardaEOut); // mux4(d0, d1, d2, d3, s, y)
  mux4 ForwardBE_mux(RegRdData2_E_dp, Result_W_dp, ALUOut_M_dp, 32'd0, forwardbE,forwardbEOut); // mux4(d0, d1, d2, d3, s, y)
	 //////////////////////////////////////////
   /// Memory register
   ///////////////////////////////////////////

  ///////////////////////////////////////////
   /// Memory stage signals
   ///////////////////////////////////////////
   //write your signals here
  always @ (posedge clk) begin
    ZFlag_M_dp <= ZFlag_E_dp;
    ALUOut_M_dp <= ALUOut_E_dp;
    WriteReg_M_dp <= WriteReg_E_dp;
   // PCBranch_M_dp <= PCBranch_E_dp;
    WriteData_M_temp_dp <= RegRdData2_E_dp;
    RegWrite_M_cu <= RegWrite_E_cu;
    MemWrite_M_cu <= MemWrite_E_cu;
    MemtoReg_M_cu <= MemtoReg_E_cu;
    Branch_M_cu <= Branch_E_cu;
  end
	 //////////////////////////////////////////
   /// Memory stage
   ///////////////////////////////////////////
  assign WriteData_M_dp = forwardM? ReadData_W_dp : WriteData_M_temp_dp;
  ram RAM (clk, MemWrite_M_cu, ALUOut_M_dp, WriteData_M_dp, ReadData_M_dp); // Data Memory (clk, we, adr, din, dout);
  
	 //////////////////////////////////////////
   /// Write register
   ///////////////////////////////////////////

   ///////////////////////////////////////////
   /// write-back stage signals
   /////////////////////////////////////////// 
  
  always @ (posedge clk) begin
    WriteReg_W_dp <= WriteReg_M_dp;
    ALUOut_W_dp <= ALUOut_M_dp;
    ReadData_W_dp <= ReadData_M_dp;
    RegWrite_W_cu <= RegWrite_M_cu;
    MemtoReg_W_cu <= MemtoReg_M_cu;
  end
  
	 //////////////////////////////////////////
	 /// Write stage
	 ///////////////////////////////////////////
	 assign Result_W_dp = MemtoReg_W_cu? ReadData_W_dp: ALUOut_W_dp;

  	//////////////////////////////////////////
	/// Hazards Unit
	///////////////////////////////////////////
  wire [1:0] forwardaE, forwardbE;
	wire forwardaD, forwardbD, forwardM, stallF, stallD, flushE;
  hazard Hazard_Unit(PC_F_dp, Instr_D_dp[25:21], Instr_D_dp[20:16], SrcAddrRType_E_dp, DstAddrIType_E_dp, WriteReg_E_dp, WriteReg_M_dp, WriteReg_W_dp, RegWrite_E_cu, RegWrite_M_cu, RegWrite_W_cu, MemtoReg_E_cu, MemtoReg_M_cu, MemtoReg_W_cu, Branch_D_cu, MemWrite_D_cu, MemWrite_M_cu, forwardaE, forwardbE, forwardaD, forwardbD, forwardM, stallF, stallD, flushE); // ( PC, rsD, rtD, rsE, rtE, writeregE, writeregM, writeregW, regwriteE, regwriteM, regwriteW, memtoregE, memtoregM,memtoregW, branchD, MemWriteD, MemWriteM, forwardaE, forwardbE, forwardaD, forwardbD, forwardM, stallF, stallD, flushE)
  
  
  
endmodule
