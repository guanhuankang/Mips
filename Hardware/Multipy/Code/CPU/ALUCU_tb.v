
module ALUCU_tb();
  `timescale 1ns/1ps
  reg[4:0] ALUOP;
  reg[5:0] funccode;
  reg clk;
  wire[4:0] ALUOPCtrl;
  reg[4:0] ALUOPCtrl_s;
  integer fp,i,cnd;
  
  initial
  begin
    fp = $fopen("ALUCU.txt","r");
    cnd = 0;
    i=0;
    clk = 0;
    cnd = $fscanf(fp,"%x%x%x",funccode,ALUOP,ALUOPCtrl_s);
  end
  
  ALUCU myALUCU(clk,ALUOP,funccode,ALUOPCtrl);
  
  always #100
  clk = ~clk;
  
  always@(posedge clk)
  begin
    $display("ALUOPCtrl_s:%x %x ; Func:%x AO:%x",ALUOPCtrl_s,ALUOPCtrl,funccode,ALUOP);
    i <= i+1;
    if(ALUOPCtrl != ALUOPCtrl_s)
      begin
        $fclose(fp);
        $display("fail at %x",i);
        $stop;
      end

    cnd = $fscanf(fp,"%x%x%x",funccode,ALUOP,ALUOPCtrl_s);
    if(cnd!=3)
      begin
        $display("pass ALUCU");
        $fclose(fp);
        $stop;
      end
  end
  
  
endmodule
    


