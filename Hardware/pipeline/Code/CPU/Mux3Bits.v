

module Mux3Bits(m0,m1,m2,m3,m4,m5,m6,m7,mout,ctrl);
  parameter width=32;
  input[width:1] m0,m1,m2,m3,m4,m5,m6,m7;
  input[2:0] ctrl;
  output mout;
  
  wire[width:1] mout;
  wire[width:1] tmp1,tmp2,tmp3,tmp4;
  wire[width:1] tmp5,tmp6;
  
  assign tmp1 = (m0&{width{~ctrl[0]}}) | (m1&({width{ctrl[0]}}));
  assign tmp2 = (m2&{width{~ctrl[0]}}) | (m3&({width{ctrl[0]}}));
  assign tmp3 = (m4&{width{~ctrl[0]}}) | (m5&({width{ctrl[0]}}));
  assign tmp4 = (m6&{width{~ctrl[0]}}) | (m7&({width{ctrl[0]}}));
  assign tmp5 = (tmp1&{width{~ctrl[1]}}) | (tmp2&({width{ctrl[1]}}));
  assign tmp6 = (tmp3&{width{~ctrl[1]}}) | (tmp4&({width{ctrl[1]}}));
  assign mout = (tmp5&{width{~ctrl[2]}}) | (tmp6&({width{ctrl[2]}})); 
  
endmodule


