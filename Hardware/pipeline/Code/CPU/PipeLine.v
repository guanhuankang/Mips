
module SCPU(		input clk,
					input[31:0] Data_in,
					input[31:0] inst_in,
					input       INT,
					input       MIO_ready,
					input       reset,
					output[31:0] Addr_out,
					input       CPU_MIO,
					output[31:0] Data_out,
					input       mem_w,
					output[31:0] PC_out
				);

//module PipeLine(clk,rst);
//  input clk,rst;

  //block signal
  wire rst;
  assign rst = reset;
  
  
  wire IFIDW,rst1;
  wire IDEXW,rst2;
  wire EXMEMW,rst3;
  wire MEMWBW,rst4;
  
  wire[31:0] R11,R12,R21,R22;
  
  wire[4:0] R3WB,R4WB;
  wire[9:0] R3M,R3EX,R4M,R4EX;
  wire[31:0] R31,R32,R33,R34,R35;
  wire[31:0] R41,R42,R43,R44,R45;
  wire[4:0] R36,R37,R38;
  wire[4:0] R46,R47,R48;
  wire[25:0] R39,R49;
  wire[5:0] R3a,R4a;
  
  wire[4:0] R5WB,R6WB;
  wire[9:0] R5M,R6M;
  wire R54,R64;
  wire[4:0] R57,R67;
  wire[31:0] R51,R52,R53,R55,R56,R58;
  wire[31:0] R61,R62,R63,R65,R66,R68;
  
  wire[4:0] R7WB,R8WB;
  wire[31:0] R71,R72,R81,R82;
  wire[4:0] R73,R83;
  wire PCWriteA;
  
  
  IFID myIFID(clk,IFIDW,rst1,R11,R12,R21,R22);
  assign R3a = R22[31:26];
  IDEX myIDEX(clk,IDEXW,rst2,R3WB,R3M,R3EX,R31,R32,R33,R34,R35,R36,R37,R38,R39,R3a,
        R4WB,R4M,R4EX,R41,R42,R43,R44,R45,R46,R47,R48,R49,R4a);
  EXMEM myEXMEM(clk,EXMEMW,rst3,R5WB,R5M,R51,R52,R53,R54,R55,R56,R57,R58,
              R6WB,R6M,R61,R62,R63,R64,R65,R66,R67,R68);
  MEMWB myMEMWB(clk,MEMWBW,rst4,R7WB,R71,R72,R73,R8WB,R81,R82,R83);
  
  wire[31:0] JMout;
  wire[31:0] pcin,pcout; 
  wire PCSrc;
  wire PCWrite = 1'b1;  
  Mux2Bits myMux1pcin(R11,JMout,pcout,JMout,pcin,{PCWriteA,PCSrc});
  PC myPC(clk, pcin, PCWrite, pcout, rst);
  
  assign R11 = pcout + 32'd4;
  //module IM(address, instr, clk);
  //IM myIM(pcout, R12, clk);
  assign PC_out = pcout;
  assign R12 = inst_in;
  
  
  wire rst21,rst22;
  wire[31:0] wdata;
  HDU myHDU(R4a,R22[25:21], R22[20:16], R47, R4M[3], rst21, PCWriteA, IFIDW);
  assign rst2 = rst21|rst22;
  MCU myMCU(R22, R3WB, R3M, R3EX);
  assign R31 = R21;
  RF myRF(R22[25:21], R22[20:16], R83, R32, R33, wdata, R8WB[4], clk,rst);
  ZE myZE(R22[15:0], R34);
  SE mySE(R22[15:0], R35);
  assign {R36,R37,R38} = R22[25:11];
  assign R39 = R22[25:0];
  
  wire[31:0] DVout;
  wire[31:0] result;
  wire[31:0] SrcARS,SrcBRT;
  wire[1:0] fa,fb;
  wire[31:0] shamt = {27'd0,R49[10:6]};
  wire[31:0] alu1,alu2;
  wire[31:0] SL2out;
  wire[4:0] ALUOPCtrl;
  wire ovf;
  assign {R5WB,R5M} = {R4WB,R4M};
  assign result = wdata;
  SL226 mySL226(R49, R41, R51);
  Mux2Bits myForwA(R42,DVout,result,32'd0,SrcARS,fa);
  Mux2Bits myForwB(R43,DVout,result,32'd0,SrcBRT,fb);
  Mux1Bits mySrcA(SrcARS,shamt,alu1,R4EX[9]);
  Mux2Bits mySrcB(SrcBRT,32'd0,R45,R44,alu2,R4EX[8:7]);
  assign R53 = SrcARS;
  assign R56 = SrcBRT;
  assign R58 = R41;
  SL2 mySL2(R45, SL2out);
  assign R52 = SL2out+R41;
  ALU myALU(alu1, alu2, ALUOPCtrl, R54, ovf, R55);
  ALUCU myALUCU(clk,R4EX[6:2],R49[5:0],ALUOPCtrl);
  // ALUCU(clk,ALUOP,funccode,ALUOPCtrl);

  Mux2Bits #5 myDst(R47,R48,5'b11_111,5'b00_000,R57,R4EX[1:0]);
  FU myFU(R46,R47,R67,R6WB[4],R83,R8WB[4],fa,fb);
  
  assign R7WB = R6WB;
  assign R72 = DVout;
  assign R73 = R67;
  Erasure myErasure(PCSrc, rst1, rst22, rst3, clk, rst);
  Mux2Bits myJM(R62,R61,R63,R62,JMout,R6M[6:5]);
  Branch myBranch(R6M[9:7], R64, R65[0], PCSrc);
  Mux1Bits myDV(R65,R68,DVout,R6M[4]);
  //module DM(address, dm_in, dm_out, MemWrite, MemRead, SBHW, clk);
  //DM myDM(R65, R66, R71, R6M[2], R6M[3], R6M[1:0], clk);
  assign Addr_out = R65;
  assign Data_out = R66;
  assign R71 = Data_in;
  assign mem_w = R6M[2];
  
  wire[31:0] LSEout;
  Mux1Bits myMTR(R82,LSEout,wdata,R8WB[3]);
  LSE myLSE(R8WB[2:0], R81, LSEout);
  
  assign rst4 = rst;
  assign {IDEXW,EXMEMW,MEMWBW} = 3'b111;

endmodule