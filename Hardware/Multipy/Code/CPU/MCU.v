`include "MCU_Def.v"
`include "Instr_Def.v"
`include "funccode_Def.v"

module MCU(clk,instr,PCWrite,IorD,MemRead,MemWrite,MemtoReg,
           IRWrite,RegDst,RegWrite,ALUSrcA,ALUSrcB,ALUOP,PCSource,BNE,SEX,StoreX,Branch,rst,funccode,PCWriteCond);
      input clk,rst;
      input[5:0] instr,funccode;
      output PCWrite,IorD,MemRead,MemWrite,MemtoReg,
           IRWrite,RegDst,RegWrite,ALUSrcA,ALUSrcB,ALUOP,PCSource,BNE,SEX,StoreX,Branch,PCWriteCond;
           
      wire PCWrite,IorD,MemRead,MemWrite,IRWrite,RegWrite,Branch,BNE,PCWriteCond;
      wire[1:0] MemtoReg,RegDst,ALUSrcA,PCSource,StoreX;
      wire[2:0] ALUSrcB,SEX;
      wire[4:0] ALUOP;
      
      reg[3:0] status;
      /* {PCWrite 1,IorD 2,MemRead 3,MemWrite 4,MemtoReg 6,
           IRWrite 7,RegDst 9,RegWrite 10,ALUSrcA 12,ALUSrcB 15,ALUOP 20,PCSource 22,BNE 23,SEX 26,StoreX 28,Branch 29,PCWriteCond 30} */
      reg[29:0] outSign;
      
      
      assign {PCWrite,IorD,MemRead,MemWrite,MemtoReg,
           IRWrite,RegDst,RegWrite,ALUSrcA,ALUSrcB,ALUOP,PCSource,BNE,SEX,StoreX,Branch,PCWriteCond} = outSign;
/*       always@(negedge clk)
      begin
        $display("Current Status:%x Signal:%x",status,outSign);
      end */
      //000_000
      reg[11:0] RJType;
      always@(*)
        case(funccode)
          `Func_Jalr:
            RJType = 12'he00;
          `Func_Jr:
            RJType = 12'hf00;
          default:
            RJType = 12'h670;
        endcase
          
      //EXStatus
      reg[2:0] LogicImm;
      reg[11:0] EXStatus;
      always@(*)
        case(instr)
          `Instr_LB,
          `Instr_LBU,
          `Instr_LH,
          `Instr_LHU,
          `Instr_LW:
            EXStatus = 12'h235;
          `Instr_SB,
          `Instr_SH,
          `Instr_SW:
            EXStatus = 12'h240;
          `Instr_R_Type,
          `Instr_JALR,
          `Instr_JR:
            EXStatus = RJType;
          `Instr_ADDI,
          `Instr_ADDUI,
          `Instr_SLTI,
          `Instr_SLTUI,
          `Instr_LUI:
          begin
            EXStatus = 12'h890;
            LogicImm = 3'b010;
          end
          `Instr_ANDI,
          `Instr_ORI,
          `Instr_XORI:
          begin
            EXStatus = 12'h890;
            LogicImm = 3'b101;
          end       
          `Instr_BLEZ,
          `Instr_BGTZ,
          `Instr_BLTZ,
          `Instr_BGEZ:
            EXStatus = 12'ha00;
          `Instr_BNE,
          `Instr_BEQ:
            EXStatus = 12'hb00;
          `Instr_J:
            EXStatus = 12'hc00;
          `Instr_JAL:
            EXStatus = 12'hd00;
          default:
          begin
            EXStatus = 12'h000;
            LogicImm = 3'b010;
          end
        endcase
      
      //Status    
      always@(posedge clk, posedge rst)
      begin
        if(rst==1)
          begin
            status <= `Status_Rst;
          end
        else
          case(status)
            `Status_Rst:
              status <= `Status_1;
            `Status_0:
              status <= `Status_1;
            `Status_1:
              status <= EXStatus[11:8];
            `Status_2:
              status <= EXStatus[7:4];
            `Status_3:
              status <= `Status_5;
            `Status_4:
              status <= `Status_0;
            `Status_5:
              status <= `Status_0;
            `Status_6:
              status <= `Status_7;
            `Status_7:
              status <= `Status_0;
            `Status_8:
              status <= `Status_9;
            `Status_9:
              status <= `Status_0;
            `Status_10:
              status <= `Status_0;
            `Status_11:
              status <= `Status_0;
            `Status_12:
              status <= `Status_0;
            `Status_13:
              status <= `Status_0;
            `Status_14:
              status <= `Status_0;
            `Status_15:
              status <= `Status_0;
            default:
              status <= `Status_Rst;
          endcase   
      end
      /* {PCWrite 1,IorD 2,MemRead 3,MemWrite 4,MemtoReg 6,
           IRWrite 7,RegDst 9,RegWrite 10,ALUSrcA 12,ALUSrcB 15,ALUOP 20,PCSource 22,BNE 23,SEX 26,StoreX 28,Branch 29,PCWriteCond} */
      reg[1:0] SoS;
      always@(*)
      case(funccode)
        `Func_Sll,
        `Func_Srl,
        `Func_Sra:
          SoS = 2'b10;
        `Func_Sllv,
        `Func_Srlv,
        `Func_Srav:
          SoS = 2'b01;     
        default:
          SoS = 2'b01;
      endcase
        
      //Logic Status<->outSignal
      always@(*)
      begin
        case(status)
          `Status_Rst:
            outSign = `MCU_Rst;
          `Status_0:
            outSign = `MCU_0;
          `Status_1:
            outSign = `MCU_1;
          `Status_2:
            outSign = `MCU_2;
          `Status_3:
            outSign = `MCU_3;  
          `Status_4:
            outSign = `MCU_4 | {24'h000_000,2'b00,instr[1:0],2'b0};
          `Status_5:
            outSign = `MCU_5 | {20'h00_000,3'b000,instr[2:0],4'h0};
          `Status_6:
            outSign = `MCU_6 | {8'h00,2'b00,SoS,16'h0000,2'b0};
          `Status_7:
            outSign = `MCU_7;
          `Status_8:
            outSign = `MCU_8 | {12'h000,LogicImm,instr[4:0],8'h00,2'b0};
          `Status_9:
            outSign = `MCU_9;
          `Status_10:
            outSign = `MCU_10 | {12'h000,3'b0,instr[4:0],8'h00,2'b0};
          `Status_11:
            outSign = `MCU_11 | {12'h000,3'b0,instr[4:0],2'b00,instr[0],7'b000_0000};
          `Status_12:
            outSign = `MCU_12;
          `Status_13:
            outSign = `MCU_13;
          `Status_14:
            outSign = `MCU_14;
          `Status_15:
            outSign = `MCU_15;
          `Status_Rst:
            outSign = `MCU_Rst;
          default:
            outSign = `MCU_Rst;
        endcase
      end
      
endmodule