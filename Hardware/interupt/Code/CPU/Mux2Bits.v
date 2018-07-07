
module Mux2Bits(m0,m1,m2,m3,mout,ctrl);
  parameter width=32;
  
  input[width:1] m0,m1,m2,m3;
  input[1:0] ctrl;
  output mout;
  
  wire[width:1] mout;
  wire[width:1] tmp1,tmp2;
  
  assign tmp1 = (m0&{width{~ctrl[0]}}) | (m1&({width{ctrl[0]}}));
  assign tmp2 = (m2&{width{~ctrl[0]}}) | (m3&({width{ctrl[0]}}));
  assign mout = (tmp1&{width{~ctrl[1]}}) | (tmp2&({width{ctrl[1]}})); 
  
endmodule

