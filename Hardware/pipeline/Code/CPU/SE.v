
module SE(se_in, se_out);
  input[15:0] se_in;
  output se_out;
  
  wire[31:0] se_out;
  
  assign se_out = {{16{se_in[15]}},se_in};
endmodule

