
module MCU_tb();
  reg[31:0] instr;
  integer fp,cnd;
  reg clk;
  wire[24:0] res;
  
  initial
  begin
    fp = $fopen("text_bin.txt","r");
    cnd = 0;
    clk = 0;
    cnd = $fcanf(fp,"%x",instr);
  end
  
  always #100
   clk = ~clk;
   
  MCU myTM(instr,res[24:20],res[19:10],res[9:0]);
  
  always@(posedge clk)
  begin
    $display("%x\t%x\t%x",res[24:20],res[19:10],res[9:0]);
    cnd = $fscanf(fp,"%x",instr);
    if(cnd==0)
      $stop();
  end
  
endmodule
      
    