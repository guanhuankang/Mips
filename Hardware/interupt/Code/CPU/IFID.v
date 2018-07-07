
module IFID(clk,IFIDW,rst1,pcin,instr,Opcin,Oinstr);
  input clk,IFIDW,rst1;
  input[31:0] pcin,instr;
  output Opcin,Oinstr;
  wire[31:0] Opcin,Oinstr;
  
  reg[31:0] reg_pc,reg_instr;
  
  always@(posedge clk)
  begin
    if(rst1==1)
      {reg_pc,reg_instr} <= 64'd0;
    if(rst1==0 && IFIDW==1)
      {reg_pc,reg_instr} <= {pcin,instr};
  end
  
  assign {Opcin,Oinstr} = {reg_pc,reg_instr};    
  
endmodule
