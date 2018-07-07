
module ZE(ze_in, ze_out);
  input[15:0] ze_in;
  output ze_out;
  wire[31:0] ze_out;
  
  assign ze_out = {16'd0,ze_in};
  
endmodule