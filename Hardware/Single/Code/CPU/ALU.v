`include "./ALU_encode_def.v"

module ALU(alu_in1, alu_in2, alu_out, alu_signal, zero, ovf);
  input[31:0] alu_in1,alu_in2;
  input[4:0] alu_signal;
  output zero,ovf;
  output alu_out;
  
  wire[31:0] alu_out;
  
  reg[63:0] result;
  
  always @(*)
    begin
      case(alu_signal)
        `ALUSIGNAL_ADDU,
        `ALUSIGNAL_LW,
        `ALUSIGNAL_SW,
        `ALUSIGNAL_JMP,
        `ALUSIGNAL_JAL:
          result[32:0] = alu_in1 + alu_in2;
        `ALUSIGNAL_SUBU,
        `ALUSIGNAL_BEQ:
          result[31:0] = alu_in1 - alu_in2;
        `ALUSIGNAL_OR,
        `ALUSIGNAL_ORI:
          result[31:0] = alu_in1 | alu_in2;
        `ALUSIGNAL_AND:
          result[31:0] = alu_in1 & alu_in2;
        `ALUSIGNAL_NOR:
          result[31:0] = ~(alu_in1 | alu_in2);
        `ALUSIGNAL_SLT,
        `ALUSIGNAL_SLTU:
          result[31:0] = {31'd0,alu_in1 < alu_in2};        
        default:
          result[63:0] = 64'd0;
      endcase
    end           
  
  assign ovf = result[32];
  assign zero = ~(|result[31:0]); 
  assign alu_out = result[31:0]; 
  
endmodule