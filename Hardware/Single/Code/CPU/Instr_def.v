//OPS INSTR
`define INSTR_R_TYPE   6'b000_000
`define INSTR_I_BEQ    6'b000_100
`define INSTR_I_ORI    6'b001_101
`define INSTR_I_LW     6'b100_011
`define INSTR_I_SW     6'b101_011
`define INSTR_J_JAL    6'b000_011
`define INSTR_J_JMP    6'b000_010

//FUNC
`define FUNC_ADDU 6'b10_0001
`define FUNC_SUBU 6'b10_0011
`define FUNC_AND 6'b10_0100
`define FUNC_ADD 6'b10_0000
`define FUNC_OR 6'b10_0101
`define FUNC_NOR 6'b10_0111
`define FUNC_SLTU 6'b10_1011
`define FUNC_SLT 6'b10_1010

