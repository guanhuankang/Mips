
module SCPU(	input clk,			//
					input [31:0]Data_in,	
					input INT,
					input MIO_ready,
					input reset,
					output[31:0]Addr_out,
					output CPU_MIO,
					output[31:0]Data_out, 									
					output mem_w							
					//input [31:0]inst_in,
					//output[31:0]PC_out,
				);
  wire rst,PCrst;
  wire[1:0] _StoreX = 2'b11;
  
  //block signal
  assign rst = reset;
  assign PCrst = reset;
  
  wire[31:0] pcin,pcout,ALUoutout,Memaddrin,IRin,IRout,MDRout,SEXout,SEout,SL2out,ALUout;
  wire[31:0] SL2out1,ALUinA,ALUinB,FAin,FBin,FAout,FBout,M2out,LogicImm;
  wire[31:0] const4 = 32'd4;
  wire[31:0] const0 = 32'd0;
  wire const1 = 1'b1;
  wire[4:0] MRegDstout;
  wire[31:0] MMemtoRegout;
  wire[1:0] M3out;
  
  wire PCWrite,IorD,MemRead,MemWrite,IRWrite,RegWrite,Branch,BNE,PCWriteCond,M1out;
  wire[1:0] MemtoReg,RegDst,ALUSrcA,PCSource,StoreX;
  wire[2:0] ALUSrcB,SEX;
  wire[4:0] ALUOP;
  wire[4:0] ALUOPCtrl;
  wire zero,ovf;
  
  wire B1,B2,B3,B4;
  //assign SL2out1 = {pcout[31:28],SL2out1[27:0]};
  assign SL2out1 = {pcout[31:28],IRout[25:0],2'b00};
  assign B4 = B2|B3|PCWrite;
  assign B2 = B1&PCWriteCond;
  assign B3 = Branch & ALUout[0];
  assign B1 = zero ^ BNE;
  // PC(clk, pc_in, PCWrite, pc_out, rst);
  PC myPC(clk, pcin, B4, pcout, PCrst);
  //module Memory(clk, address, writedata, readdata, MemRead, MemWrite, StoreX);
  //Memory myMemory(clk, Memaddrin, M2out, IRin, MemRead, M1out, M3out);
  assign Addr_out = Memaddrin;
  assign Data_out = FBout;
  assign IRin = Data_in;
  assign mem_w = MemWrite;
  
  RF myRF(IRout[25:21], IRout[20:16], MRegDstout,FAin, FBin, MMemtoRegout, RegWrite, clk,rst);
  SE mySE(IRout[15:0], SEout);
  SL2 mySL2(SEout, SL2out);
  //SL226 mySL226(IRout[25:0], SL2out1[27:0]);
  ALU myALU(ALUinA, ALUinB, ALUOPCtrl, zero, ovf, ALUout);
  LWX myLWX(MDRout, SEX, SEXout);
  ALUCU myALUCU(clk,ALUOP,IRout[5:0],ALUOPCtrl,IRout[20:16]);
  MCU myMCU(clk,IRout[31:26],PCWrite,IorD,MemRead,MemWrite,MemtoReg,
           IRWrite,RegDst,RegWrite,ALUSrcA,ALUSrcB,ALUOP,PCSource,BNE,SEX,StoreX,Branch,rst,IRout[5:0],PCWriteCond);
  ZE myZE(IRout[15:0], LogicImm);  
  Flop IR(clk,IRin,IRout,IRWrite,rst);
  Flop MDR(clk,IRin,MDRout,const1,rst);
  Flop FA(clk,FAin,FAout,const1,rst);
  Flop FB(clk,FBin,FBout,const1,rst);
  Flop FlopALUout(clk,ALUout,ALUoutout,const1,rst);

  Mux1Bits #(2) M3(StoreX,_StoreX,M3out,rst);
  Mux2Bits #(5) MRegDst(IRout[20:16],IRout[15:11],5'b11_111,5'b00_000,MRegDstout,RegDst);
  Mux1Bits #(32) MIorD(pcout,ALUoutout,Memaddrin,IorD);
  Mux2Bits #(32) MMemtoReg(ALUoutout,SEXout,pcout,32'b00_000,MMemtoRegout,MemtoReg);
  Mux2Bits #(32) MSrcA(pcout,FAout,{27'd0,IRout[10:6]},32'b00_000,ALUinA,ALUSrcA);
  Mux3Bits #(32) MSrcB(FBout,const4,SEout,SL2out,const0,LogicImm,const0,const0,ALUinB,ALUSrcB);
  Mux2Bits #(32) MPCsource(ALUout,ALUoutout,SL2out1,FAout,pcin,PCSource);
  
endmodule
  