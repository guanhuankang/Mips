`include "ALUOPCtrl_Def.v"

module ALU_tb();
  `timescale 1ns/1ps
  
  reg[31:0] srcA,srcB;
  reg[4:0] ALUOPCtrl;
  reg clk;
  reg[31:0] aluout_standard;
  reg zero_s,ovf_s;
  wire zero,ovf;
  wire[31:0] aluout;
  
  integer fp,cnd,i;
  
  initial
  begin
    fp = $fopen("alu.txt","r");
    cnd = 0;
    i=0;
    clk = 0;
    cnd = $fscanf(fp,"%x%x%x%x%x%x",srcA,srcB,ALUOPCtrl,zero_s,ovf_s,aluout_standard);
  end
  
  ALU myArithmetic(srcA,srcB,ALUOPCtrl,zero,ovf,aluout);
  
  always #100
  clk = ~clk;
  
  always@(posedge clk)
  begin
    $display("%d aluout-standard:%x aluout:%x zero:%x s-%x ovf:%x s-%x",ALUOPCtrl,aluout_standard,aluout,zero,zero_s,ovf,ovf_s);
    i <= i+1;
    if((aluout != aluout_standard)||(zero!=zero_s)||(ovf!=ovf_s))
      begin
        $fclose(fp);
        $display("fail at %x",i);
        $stop;
      end

    cnd = $fscanf(fp,"%x%x%x%x%x%x",srcA,srcB,ALUOPCtrl,zero_s,ovf_s,aluout_standard);
    if(cnd!=6)
      begin
        $display("pass alu");
        $fclose(fp);
        $stop;
      end
  end
  
  
endmodule
    

