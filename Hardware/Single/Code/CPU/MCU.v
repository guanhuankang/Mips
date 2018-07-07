`include "./Instr_def.v"

module MCU(clk,instr,ALUOP,RegDst,WAddr,RegWrite,ALUSrc1,ALUSrc2,Branch,Jump,MemRead,MemWrite,MemToReg,protect);
  input clk;
  input[5:0] instr;
  input protect;
  output ALUOP,RegDst,WAddr,RegWrite,ALUSrc1,ALUSrc2,Branch,Jump,MemRead,MemWrite,MemToReg;
  
  wire[1:0] ALUOP;
  wire[1:0] RegDst;
  wire[4:0] WAddr;
  wire RegWrite;
  wire ALUSrc1;
  wire[1:0] ALUSrc2;
  wire Branch;
  wire Jump;
  wire MemRead;
  wire MemWrite;
  wire MemToReg;
/*  
  reg[17:0] r_type;
  reg[17:0] beq;
  reg[17:0] ori;
  reg[17:0] lw;
  reg[17:0] sw;
  reg[17:0] jal;
 */
 reg[17:0] output_signal;
  
  always @(*)
  begin
    case(instr)
      `INSTR_R_TYPE:
        output_signal = 18'b0010_00000_1100_00000;
      `INSTR_I_BEQ :
        output_signal = 18'b01_00_00000_0100_10_000;
      `INSTR_I_ORI:
        output_signal = 18'b1100_00000_1110_00000;
      `INSTR_I_LW:
        output_signal = 18'b1000_00000_1110_00101;
      `INSTR_I_SW:
        output_signal = 18'b1000_00000_0110_000_10;
      `INSTR_J_JAL:
        output_signal = 18'b1001_11111_1001_01000;
      `INSTR_J_JMP:
        output_signal = 18'b1000_00000_0000_01000;
      default:
        output_signal = 18'd0;
    endcase
  end
  
  assign {ALUOP,RegDst,WAddr,RegWrite,ALUSrc1,ALUSrc2,Branch,Jump,MemRead,MemWrite,MemToReg} = {18{~protect}}&output_signal;
  
endmodule
      
  
