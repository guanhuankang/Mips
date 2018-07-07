//shift left 2,plus pc high 4 bits = 32;
module SL226(sl226_in, pcin, sl226_out);
  input[25:0] sl226_in;
  wire[25:0] sl226_in;
  input[31:0] pcin;
  
  output sl226_out;
  wire[31:0] sl226_out;
  
  assign sl226_out = {pcin[31:28],sl226_in,{2'b00}};
  
endmodule
