
module Mux_2(d1, d2, s, dout);
  parameter width=32;
  
  input[width:1] d1,d2;
  input s;
  output dout;
  
  wire[width:1] dout;
  
  wire[width:1] exs = {width{s}};
  
  assign
    dout = ((~exs)&d1)|(exs&d2);
    
endmodule

module Mux_4(d1, d2, d3, d4, s, dout);
  parameter width=32;
  
  input[width:1] d1,d2,d3,d4;
  input[1:0] s;
  output dout;
  
  wire[width:1] dout;
  
  wire[width:1] exs = {width{s[0]}};
  wire[width:1] exs1 = {width{s[1]}};
  wire[width:1] tmp_1;
  wire[width:1] tmp_2;
  
  assign  tmp_1 = ((~exs)&d1)|(exs&d2);
  assign  tmp_2 = ((~exs)&d3)|(exs&d4);
  assign  dout  = ((~exs1)&tmp_1)|(exs1&tmp_2);
        
endmodule
  