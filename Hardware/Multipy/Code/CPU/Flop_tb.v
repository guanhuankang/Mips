
module Flop_tb;
  `timescale 1ns/1ps
  
  reg[31:0] a;
  wire[31:0] out;
  reg ctrl;
  reg rst;
  reg clk;
  
  initial
  begin
    rst = 0;
    clk = 1;
    a = 100;
    ctrl = 0;
  end
  
  Flop flop(clk,a,out,ctrl,rst);
  
  always #100
    begin
    clk = ~clk;
    $display("Test:clk:%x",clk);
    end
  
  always@(posedge clk, negedge clk)
  begin
    if(a<=100)rst<=1;else rst<=0;
    a <= a+1;
    $display("a:%x rst:%x clk:%x",a,rst,clk);
  end
  
  always @(posedge clk)
  begin
    $display("ANS:%x  a:%x rst:%x",out,a,rst);
  end
endmodule
    
