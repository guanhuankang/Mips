
module Addu(d1, d2, cin, dout, cout);
  input[31:0] d1,d2;
  input cin;
  output dout,cout;
  
  wire[31:0] dout;
  wire cout;
  
  assign {cout,dout} = d1 + d2 + cin;
endmodule
