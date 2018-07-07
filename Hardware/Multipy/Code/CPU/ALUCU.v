`include "ALUOP_Def.v"
`include "ALUOPCtrl_Def.v"
`include "funccode_Def.v"
`include "RT_Def.v"


module ALUCU(clk,ALUOP,funccode,ALUOPCtrl,ALUrt);
  input clk;
  input[4:0] ALUOP,ALUrt;
  input[5:0] funccode;
  output ALUOPCtrl;
  wire[4:0] ALUOPCtrl;
  
  reg[4:0] tmp,Rtmp,Btmp;
  
  always@(*)
  begin
    case(ALUrt)
      `RT_Bltz:
        Btmp = `ALU_Slt;
      `RT_Bgez:
        Btmp = `ALU_Ge;
      default:
        Btmp = `ALU_Invalid;
    endcase  
  end
  
  always@(*)
  begin
    case(funccode)
      `Func_Add:
        Rtmp = `ALU_Add;
      `Func_Addu:
        Rtmp = `ALU_Addu;
      `Func_Sub:
        Rtmp = `ALU_Sub;
      `Func_Subu:
        Rtmp = `ALU_Subu;
      `Func_Sll:
        Rtmp = `ALU_Sll;
      `Func_Srl:
        Rtmp = `ALU_Srl;
      `Func_Sra:
        Rtmp = `ALU_Sra;
      `Func_Sllv:
        Rtmp = `ALU_Sll;
      `Func_Srlv:
        Rtmp = `ALU_Srl;
      `Func_Srav:
        Rtmp = `ALU_Sra;
      `Func_And:
        Rtmp = `ALU_And;
      `Func_Or:
        Rtmp = `ALU_Or;
      `Func_Xor:
        Rtmp = `ALU_Xor;
      `Func_Nor:
        Rtmp = `ALU_Nor;
      `Func_Slt:
        Rtmp = `ALU_Slt;
      `Func_Sltu:
        Rtmp = `ALU_Sltu;
      `Func_Jalr:
        Rtmp = `ALU_Jalr;
      `Func_Jr:
        Rtmp = `ALU_Jr;
      `Func_Else:
        Rtmp = `ALU_Invalid;
      default:
        Rtmp = 6'b0;
      endcase        
  end
  
  always@(*)
  begin
    case(ALUOP)
      `ALUOP_Addi,
      `ALUOP_Load,
      `ALUOP_Store:
        tmp = `ALU_Add;
      `ALUOP_Addiu:
        tmp = `ALU_Addu;
      `ALUOP_Slti:
        tmp = `ALU_Slt;
      `ALUOP_Sltiu:
        tmp = `ALU_Sltu;
      `ALUOP_Andi:
        tmp = `ALU_And;
      `ALUOP_Ori:
        tmp = `ALU_Or;
      `ALUOP_Xori:
        tmp = `ALU_Xor;
      `ALUOP_Lui:
        tmp = `ALU_Lui;
      `ALUOP_Beq,
      `ALUOP_Bne:
        tmp = `ALU_Subu;
      `ALUOP_Blez:
        tmp = `ALU_Le;
      `ALUOP_Bgtz:
        tmp = `ALU_Gt;
      `ALUOP_Bltz,
      `ALUOP_Bgez:
        tmp = Btmp;
      `ALUOP_R_Type:
        tmp = Rtmp;
      `ALUOP_Invalid:
        tmp = `ALU_Invalid;
      default:
        tmp = `ALU_Invalid;
      endcase
    end
    
    
  assign ALUOPCtrl = tmp;
  
  endmodule