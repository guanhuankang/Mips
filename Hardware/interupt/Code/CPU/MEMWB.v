
module MEMWB(clk,MEMWBW,rst4,WB,Rdfm,aluout,dst,OWB,ORdfm,Oaluout,Odst);
  input clk,rst4,MEMWBW;
  input WB,Rdfm,aluout,dst;
  wire[4:0] WB;
  wire[31:0] Rdfm;
  wire[31:0] aluout;
  wire[4:0] dst;
  output OWB,ORdfm,Oaluout,Odst;
  wire[4:0] OWB;
  wire[31:0] ORdfm;
  wire[31:0] Oaluout;
  wire[4:0] Odst;
  
  reg[73:0] reg_reg;
  
  always@(posedge clk)
  begin
    if(rst4==1)
      reg_reg <= 74'd0;
    if(rst4==0 && MEMWBW==1)
      reg_reg <= {WB,Rdfm,aluout,dst};
  end
  
  assign {OWB,ORdfm,Oaluout,Odst} = reg_reg;

  
endmodule
  
  