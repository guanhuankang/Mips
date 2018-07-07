module test_branch();
  reg[1:0] bs;
  reg zero,alurs;
  reg[3:0] hello;
  wire jrs;
  
  initial
   hello = 0;
     
  always #100
  begin
   {bs,zero,alurs} = hello;
   hello <= hello+1;
  end
  
  Branch myB(bs,zero,alurs,jrs);
  
  always #100
   $display("%x",jrs);
   
endmodule