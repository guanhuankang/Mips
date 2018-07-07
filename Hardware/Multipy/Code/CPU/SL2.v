
module SL2(sl_in, sl_out);
  input[31:0] sl_in;
  output sl_out;
  
  wire[31:0] sl_out;
  
  assign sl_out = {sl_in[29:0],2'b00};
  
endmodule
