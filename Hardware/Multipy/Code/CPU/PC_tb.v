
module PC_tb();
  reg[31:0] pcin;
  reg PCWrite;
  wire[31:0] pcout;
  reg rst;
  reg clk;
  integer d;
  initial
  begin
    d = 0;
    clk = 0;
    rst = 0;
    PCWrite = 0;
    pcin = 32'h0000_3000;
  end
  
  PC myPC(clk,pcin,PCWrite,pcout,rst);
  
  always #100 
  clk = ~clk;
  
  always @(negedge clk)
  rst<=0;
  
  always@(posedge clk)
  begin
    if(d==0)
    begin
      rst<=1;
    end
    if(d==3)
      rst<=1;
    d <= d+1;
    $display("PC:%x  d:%x",pcout,d);
    PCWrite <= 1;
    pcin <= pcin+4;
  end
  
endmodule
