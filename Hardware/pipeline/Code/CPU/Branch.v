module Branch(bs, zero, alurs, jrs);
  input zero,alurs;
  input[2:0] bs;
  output jrs;
  wire jrs;
  
  wire b = bs[1];
  wire s = bs[0]; 
   
  assign jrs = ((zero&(~b)&(~s))|((~zero)&s)|(b&s)|(b&alurs))&bs[2];
  
endmodule
