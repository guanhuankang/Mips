`include "Ctrl_encode_def.v"
`include "ALU_encode_def.v"
`include "Instr_def.v"

//clk invalid
module ALUCtrl(clk, instr, ALUOP, alu_signal);
  input[5:0] instr;
  input[1:0] ALUOP;
  input clk;
  output alu_signal;
  
  reg[4:0] alu_signal;
  
  reg[4:0] r_type;
  
  always @(*)
    begin
    case(instr)
      `FUNC_ADD:
        r_type = `ALUSIGNAL_ADD;
      `FUNC_ADDU:
        r_type = `ALUSIGNAL_ADDU;
      `FUNC_SUBU:
        r_type = `ALUSIGNAL_SUBU;
      `FUNC_AND:
        r_type = `ALUSIGNAL_AND;
      `FUNC_OR:
        r_type = `ALUSIGNAL_OR;
      `FUNC_NOR:
        r_type = `ALUSIGNAL_NOR;
      `FUNC_SLTU:
        r_type = `ALUSIGNAL_SLTU;
      `FUNC_SLT:
        r_type = `ALUSIGNAL_SLT;
    endcase
  end
  
  always @(*)
    case(ALUOP)
      `ALUOP_R_TYPE:
        alu_signal = r_type;
      `ALUOP_I_BEQ:
        alu_signal = `ALUSIGNAL_BEQ;
      `ALUOP_I_ORI:
        alu_signal = `ALUSIGNAL_ORI;
      `ALUOP_I_LW:
        alu_signal = `ALUSIGNAL_LW;
      `ALUOP_I_SW:
        alu_signal = `ALUSIGNAL_SW;
      `ALUOP_J_JAL:
        alu_signal = `ALUSIGNAL_JAL;
      `ALUOP_J_JMP:
        alu_signal = `ALUSIGNAL_JMP;
      default:
        alu_signal = 5'b00_000;
    endcase
    
endmodule
  
          
               
        