//lb lw lbu ...
module LSE(SLSE, dmrd, res);
  input[2:0] SLSE;
  input[31:0] dmrd;
  
  output res;
  wire[31:0] res;
  
  wire[31:0] lb = {{24{dmrd[7]}},dmrd[7:0]};
  wire[31:0] lbu = {24'd0,dmrd[7:0]};
  wire[31:0] lh = {{16{dmrd[15]}},dmrd[15:0]};
  wire[31:0] lhu = {16'd0,dmrd[15:0]};
  
  Mux3Bits mlse(lb,lh,dmrd,dmrd,lbu,lhu,dmrd,dmrd,res,SLSE);
  
endmodule