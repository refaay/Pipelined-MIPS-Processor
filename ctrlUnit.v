// file: signext.v
// author: @refaay

`timescale 1ns/1ns

//module ctrlUnit(Op, Funct, MemtoReg, MemWrite, Branch, ALUSrc, RegDst, RegWrite, Jump, ALUControl); // changed for pipelined
module ctrlUnit(Op, Funct, MemtoReg, MemWrite, Branch, ALUSrc, RegDst, RegWrite, ALUControl);  
input [5:0] Op, Funct;
  //output reg MemtoReg, MemWrite, Branch, ALUSrc, RegDst, RegWrite, Jump; // changed for pipelined
  output reg MemtoReg, MemWrite, Branch, ALUSrc, RegDst, RegWrite;
  output reg [2:0] ALUControl;
  reg [1:0] ALUOp;
  always @ * begin
    case (Op)
    6'd0:  begin // R-type
      RegWrite <= 1'b1;
      RegDst <= 1'b1;
      ALUSrc <= 1'b0;
      Branch <= 1'b0;
      MemWrite <= 1'b0;
      MemtoReg <= 1'b0;
      ALUOp <= 2'b10;
      //Jump <= 1'b0;
    end 
    6'b100011: begin // lw
      RegWrite <= 1'b1;
      RegDst <= 1'b0;
      ALUSrc <= 1'b1;
      Branch <= 1'b0;
      MemWrite <= 1'b0;
      MemtoReg <= 1'b1;
      ALUOp <= 2'b00;
   //   Jump <= 1'b0;
    end
    6'b101011: begin // sw
      RegWrite <= 1'b0;
      RegDst <= 1'b0;
      ALUSrc <= 1'b1;
      Branch <= 1'b0;
      MemWrite <= 1'b1;
      MemtoReg <= 1'b0;
      ALUOp <= 2'b00;
     // Jump <= 1'b0;
    end
    6'b000100: begin // beq
      RegWrite <= 1'b0;
      RegDst <= 1'b0;
      ALUSrc <= 1'b0;
      Branch <= 1'b1;
      MemWrite <= 1'b0;
      MemtoReg <= 1'b0;
      ALUOp <= 2'b01;
     // Jump <= 1'b0;
    end
      6'b001000: begin // addi
      RegWrite <= 1'b1;
      RegDst <= 1'b0;
      ALUSrc <= 1'b1;
      Branch <= 1'b0;
      MemWrite <= 1'b0;
      MemtoReg <= 1'b0;
      ALUOp <= 2'b00;
    //  Jump <= 1'b0;
    end
      /* 6'b000010: begin // j // changed for pipelined
      RegWrite <= 1'b0;
      RegDst <= 1'bx;
      ALUSrc <= 1'bx;
      Branch <= 1'bx;
      MemWrite <= 1'b0;
      MemtoReg <= 1'bx;
      ALUOp <= 2'bxx;
      Jump <= 1'b1;
    end*/
    default: begin
      RegWrite <= 1'bx;
      RegDst <= 1'bx;
      ALUSrc <= 1'bx;
      Branch <= 1'bx;
      MemWrite <= 1'bx;
      MemtoReg <= 1'bx;
      ALUOp <= 2'bx;
    //  Jump <= 1'bx;
    end
  endcase
  end
  always@* begin
    case (ALUOp)
      2'b00: ALUControl <= 3'b010; // add
      2'b01: ALUControl <= 3'b110; // subtract
      2'b10: begin
        case(Funct)
        6'b100000: ALUControl <= 3'b010; // add
        6'b100010: ALUControl <= 3'b110; // subtract
        6'b100100: ALUControl <= 3'b000; // and
        6'b100101: ALUControl <= 3'b001; // or
        6'b101010: ALUControl <= 3'b111; // set less than
          default: ALUControl <= 3'bxxx;
        endcase
      end
      default: ALUControl <= 3'bxxx;
    endcase
  end
endmodule