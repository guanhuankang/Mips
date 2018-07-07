//Erasure when predict wrong
module  Erasure(isj, rst1, rst2, rst3, clk, rst);
  input isj,clk,rst;
  output rst1,rst2,rst3;
  wire rst1,rst2,rst3;
  
  assign {rst1,rst2,rst3} = {3{isj|rst}};

endmodule
