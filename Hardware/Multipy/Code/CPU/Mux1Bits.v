
module Mux1Bits(d1, d2, dout, s);
  parameter width=32;
  
  input[width:1] d1,d2;
  input s;
  output dout;
  
  wire[width:1] dout;
  
  wire[width:1] exs = {width{s}};
  
  assign
    dout = ((~exs)&d1)|(exs&d2);
    
endmodule

module Mux1(d1, d2, s, dout);  
  input d1,d2;
  input s;
  output dout;
  
  wire dout;
  
  wire exs = {s};
  
  assign
    dout = ((~exs)&d1)|(exs&d2);
    
endmodule
