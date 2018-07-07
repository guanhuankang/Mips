
module MCU_tb();
  `timescale 1ns/1ps
  reg clk,rst;
  reg[31:0] instr;
  integer fp,i,cnd;
  
      wire PCWrite,IorD,MemRead,MemWrite,IRWrite,RegWrite,Branch,BNE,PCWriteCond;
      wire[1:0] MemtoReg,RegDst,ALUSrcA,PCSource,StoreX;
      wire[2:0] ALUSrcB,SEX;
      wire[4:0] ALUOP;
  
  initial
  begin
    fp = $fopen("text.txt","r");
    i=0;
    rst = 0;
    clk = 0;
    cnd = $fscanf(fp,"%x",instr);
  end
  
MCU myMCU(clk,instr[31:26],PCWrite,IorD,MemRead,MemWrite,MemtoReg,IRWrite,
RegDst,RegWrite,ALUSrcA,ALUSrcB,ALUOP,PCSource,BNE,SEX,StoreX,Branch,rst,instr[5:0],PCWriteCond); 
           
  always #100
  clk = ~clk;
  
  always@(posedge clk)
  begin
    $display("%x %x\t%x\t%x\t%x",instr,ALUSrcA,ALUSrcB,ALUOP,ALUSrcA);
    //cnd = $fscanf(fp,"%x",instr);
    if(cnd!=1)
      begin
        $display("Pass");
        $stop();
        $fclose(fp);
      end
    i <= i+1;  
  end
  
  
endmodule
    




