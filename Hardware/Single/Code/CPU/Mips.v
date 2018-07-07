
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:38:43 04/28/2009 
// Design Name: 
// Module Name:    single_cycle_Cpu_9 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

module SCPU(	input clk,		
					input [31:0]Data_in,	
					input [31:0]inst_in,	
					input INT,//
					input MIO_ready,
									
					input reset,									
					output[31:0]Addr_out,
					output CPU_MIO,
					output[31:0]Data_out, 
					output mem_w,
					output[31:0]PC_out
				);

  //blocks assign
  wire PC_rst;
  wire RF_rst;
  wire protect;
  assign PC_rst = reset;
  assign RF_rst = reset;
  assign protect = reset;
  
  wire[31:0] RF_r1, RF_r2, DM_r, PC_read, Instr;
  
  //wires
  wire[31:0] pci,pco,pcai,pcao;
  wire[31:0] bus;
  wire[31:0] slo1;//high 4 bits invalid
  wire[31:0] ji;
  wire[31:0] rfo,rfo1,alui,alui1,aluo,dmo,dmo1;
  wire[4:0] rfi;
  wire[31:0] seo,slo,slo2,beqo;
  
  //signals
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
  wire ALUovf;
  wire ALUzero;
  wire PCSrc;
  wire[4:0] ALUSignal;

  //modules
  PC    myPC(clk,pci,pco,PC_rst);
  //IM    myIM(pco,bus,IM_worR,IM_wdata,clk);
  assign PC_out = pco;
  assign bus = inst_in;
  RF    myRF(bus[25:21],bus[20:16],rfi,rfo,rfo1,dmo1,RegWrite,clk,RF_rst);
  SE    mySE(bus[15:0],seo);
  ALU   myALU(alui,alui1,aluo,ALUSignal,ALUzero,ALUovf);
  //DM    myDM(aluo,rfo1,dmo,MemWrite,MemRead,clk);
  assign Addr_out = aluo;
  assign Data_out = rfo1;
  assign dmo = Data_in;
  assign mem_w = MemWrite;

  SL    mySL_1(seo,slo);
  SL    mySL_2({6'd0,bus[25:0]},slo1);
  MCU   myMCU(clk,bus[31:26],ALUOP,RegDst,WAddr,RegWrite,ALUSrc1,ALUSrc2,Branch,Jump,MemRead,MemWrite,MemToReg,protect);
  Mux_2 myMux2_1(pco,rfo,ALUSrc1,alui);
  Mux_2 myMux2_2(aluo,dmo,MemToReg,dmo1);
  Mux_2 #(32) myMux2_3(pcao,slo2,PCSrc,beqo);
  Mux_2 #(32) myMux2_4(beqo,ji,Jump,pci);
  Mux_4 #(5) myMux4_1(bus[20:16],WAddr,bus[15:11],bus[4:0],RegDst,rfi);//d4 is not required
  Mux_4 #(32) myMux4_2(rfo1,32'd4,seo,seo,ALUSrc2,alui1);//d4 is not required
  
  ALUCtrl myALUCtrl(clk,bus[5:0],ALUOP,ALUSignal);
  
  //wire to wire
  assign ji = {pcao[31:28],slo1[27:0]};
  assign pcao = pco + pcai;
  assign slo2 = slo + pcao;
  assign pcai = 32'd4;
  assign PCSrc = Branch & ALUzero;
  
  //expose the output signals
  assign RF_r1 = rfo;
  assign RF_r2 = rfo1;
  assign DM_r = dmo;
  assign PC_read = pco;
  assign Instr = bus;
  
  /*always @(posedge clk)
    $display("PCSrc %x Jump %x pcao %x pcai %x pco %x",PCSrc,Jump,pcao,pcai,pco);
  
  always @(posedge clk)
  begin
    $display("MCU:%x",{ALUOP,RegDst,WAddr,RegWrite,ALUSrc1,ALUSrc2,Branch,Jump,MemRead,MemWrite,MemToReg,protect});
    $display("ALUSignal:%x",ALUSignal);
    $display("bus:%x",bus);
  end
  */
endmodule
