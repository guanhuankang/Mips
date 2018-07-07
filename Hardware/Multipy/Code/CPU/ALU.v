`include "ALUOPCtrl_Def.v"
module ALU(srcA, srcB, ALUOPCtrl, zero, ovf, aluout);
  input[31:0] srcA,srcB;
  input[4:0] ALUOPCtrl;
  output zero,ovf,aluout;
  wire zero,ovf;
  wire[31:0] aluout;
  
  //zero,ovf,32bitsOfAluout total 34bits
  reg[33:0] arithmetic;
  reg[33:0] shift;
  reg[33:0] logic;
  reg[33:0] lui;
  reg[33:0] comparison;
  reg[33:0] slt;
  reg[33:0] result;
  
  /////////////////////////////////////////////
  always@(*)
  begin
    case(ALUOPCtrl)
      `ALU_Add,
      `ALU_Addu,
      `ALU_Sub,
      `ALU_Subu:
        result = arithmetic;
        
      `ALU_Sll,
      `ALU_Srl,
      `ALU_Sra:
        result = shift;
        
      `ALU_And,
      `ALU_Or,
      `ALU_Xor,
      `ALU_Nor:
        result = logic;  
        
      `ALU_Slt,
      `ALU_Sltu:
        result = slt; 
         
      `ALU_Lui:
        result = lui;      
      
      `ALU_Le,
      `ALU_Ge,
      `ALU_Gt:
        result = comparison;
        
      default:
       result = 34'd0;
    endcase
  end
  
  assign {zero,ovf,aluout} = result;
  
  /////////////////////////////////////////////
  //arithmetic
  wire imsign = srcA[31]^srcB[31];
  wire[32:0] sum = srcA+srcB;
  wire[32:0] minus = {1'b0,srcA}+{1'b0,~srcB}+{31'd1};
  wire tmp = sum[31]^srcA[31];
  wire tmp1 = minus[31]^srcA[31];
  wire NzeroS = (|sum[31:0]);
  wire NzeroM = (|minus[31:0]);
  wire ovf0 = (~imsign)&tmp;
  wire ovf1 = imsign&tmp1;
  wire ovf2 = (|srcB)&(~minus[32]);
  
  wire[33:0] myadd = {~(ovf0|NzeroS),ovf0,sum[31:0]};
  wire[33:0] myaddu = {~(NzeroS|sum[32]),sum[32],sum[31:0]};
  wire[33:0] mysub = {~(ovf1|NzeroM),ovf1,minus[31:0]};
  wire[33:0] mysubu = {~(ovf2|NzeroM),ovf2,minus[31:0]};
  
  
  always@(*)
  begin
    case(ALUOPCtrl)
      `ALU_Add:
        arithmetic = myadd;
      `ALU_Addu:
        arithmetic = myaddu;
      `ALU_Sub:
        arithmetic = mysub;
      `ALU_Subu:
        arithmetic = mysubu;
      default:
        arithmetic = 32'd0;
    endcase
  end

  //shift
  wire[31:0] mysll = srcB<<srcA[4:0];
  wire[31:0] mysrl = srcB>>srcA[4:0];
  wire[31:0] myshift = ~({32{srcB[31]}}>>(srcA[4:0]));
  wire[31:0] mysra = ({32{~srcB[31]}}&mysrl)|({32{srcB[31]}}&(mysrl|myshift)) ;
  always@(*)
  begin
    case(ALUOPCtrl)
      `ALU_Sll:
        shift[31:0] = mysll;
      `ALU_Srl:
        shift[31:0] = mysrl;
      `ALU_Sra:
        shift[31:0] = mysra;
      default:
        shift[31:0] = 32'd0;
    endcase
    shift[33:32] = {~(|shift[31:0]),1'b0};
  end
  
  //logic
  always@(*)
  begin
    case(ALUOPCtrl)
      `ALU_And:
        logic[31:0] = srcA & srcB;
      `ALU_Or:
        logic[31:0] = srcA | srcB;
      `ALU_Xor:
        logic[31:0] = srcA ^ srcB;
      `ALU_Nor:
        logic[31:0] = ~(srcA | srcB);
      default:
        logic[31:0] = 32'd0;
    endcase
    logic[33:32] = {~(|logic[31:0]),1'b0};
  end
  
  //slt
  wire[31:0] tmp11 = {32{((~imsign)&srcA[31])}};
  wire[31:0] A = (tmp11&(~srcA)) | ((~tmp11) & srcA);
  wire[31:0] B = (tmp11&(~srcB)) | ((~tmp11) & srcB);
  wire C = A<B?1'd1:1'd0;
  wire myslttmp = (imsign&srcA[31])|((~imsign)&C);
  wire[31:0] myslt = {31'd0,myslttmp};
  
  always@(*)
  begin
    case(ALUOPCtrl)
      `ALU_Slt:
        slt[31:0] = myslt;
      `ALU_Sltu:
        slt[31:0] = srcA < srcB;
      default:
        slt[31:0] = 32'd0;
    endcase
    slt[33:32] = 2'b0;
  end
  
  //lui
  always@(*)
  begin
    case(ALUOPCtrl)
      `ALU_Lui:
        lui[31:0] = srcB<<16;
      default:
        lui[31:0] = 32'd0;
    endcase
    lui[33:32] = {~(|lui[31:0]),1'b0};
  end
  
  //////////////////////////////////////
  //comparison
  wire compar = myslt[0]|mysub[33];
  always@(*)
  begin
    case(ALUOPCtrl)
      `ALU_Le:
        comparison = {31'd0,compar};
      `ALU_Gt:
        comparison = {31'd0,~compar};
      `ALU_Ge:
        comparison = {31'd0,(~myslt[0])};
      default:
        comparison[31:0] = 32'd0;
    endcase
    comparison[33:32] = 2'b0;
  end
  
endmodule
