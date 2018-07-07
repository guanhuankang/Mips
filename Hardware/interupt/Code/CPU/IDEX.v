
module IDEX(clk,IDEXW,rst2,WB,M,EX,pcnext,rd1,rd2,zer,ser,rs,rt,rd,low26,instr,EXCEREG_in,
           OWB,OM,OEX,Opcnext,Ord1,Ord2,Ozer,Oser,Ors,Ort,Ord,Olow26,Oinstr,OEXCEREG);
  input clk,IDEXW,rst2;
  input WB,M,EX,pcnext,rd1,rd2,zer,ser,rs,rt,rd,low26,instr;
  input EXCEREG_in;
  wire[4:0] WB;
  wire[9:0] M;
  wire[9:0] EX;
  wire[31:0] pcnext;
  wire[31:0] rd1;
  wire[31:0] rd2;
  wire[31:0] zer;
  wire[31:0] ser;
  wire[4:0] rs;
  wire[4:0] rt;
  wire[4:0] rd;
  wire[25:0] low26;
  wire[5:0] instr;
  wire[128:0] EXCEREG_in;
  output OWB,OM,OEX,Opcnext,Ord1,Ord2,Ozer,Oser,Ors,Ort,Ord,Olow26,Oinstr,OEXCEREG;
  wire[4:0] OWB;
  wire[9:0] OM;
  wire[9:0] OEX;
  wire[31:0] Opcnext;
  wire[31:0] Ord1;
  wire[31:0] Ord2;
  wire[31:0] Ozer;
  wire[31:0] Oser;
  wire[4:0] Ors;
  wire[4:0] Ort;
  wire[4:0] Ord;
  wire[25:0] Olow26;
  wire[5:0] Oinstr;
  wire[128:0] OEXCEREG;
  
  reg[24:0] reg_sign;
  reg[31:0] reg_pc;
  reg[31:0] reg_rd1,reg_rd2;
  reg[31:0] reg_zer;
  reg[31:0] reg_ser;
  reg[31:0] reg_instr;
  reg[128:0] reg_excereg;
  
  always@(posedge clk)
  begin
    if(rst2==1)
      {reg_sign,reg_pc,reg_rd1,reg_rd2,reg_zer,reg_ser,reg_instr,reg_excereg} 
      <= {25'd0,32'd0,32'd0,32'd0,32'd0,32'd0,32'd0,EXCEREG_in};
    if(rst2==0 && IDEXW==1)
      //WB,M,EX,pcnext,rd1,rd2,zer,ser,rs,rt,rd,low26,
      {reg_sign,reg_pc,reg_rd1,reg_rd2,reg_zer,reg_ser,reg_instr,reg_excereg}
      <= {WB,M,EX,pcnext,rd1,rd2,zer,ser,instr,low26,EXCEREG_in};
  end
  
  assign {OWB,OM,OEX,Opcnext,Ord1,Ord2,Ozer,Oser,Ors,Ort,Ord,Olow26,Oinstr,OEXCEREG}
          = {reg_sign,reg_pc,reg_rd1,reg_rd2,reg_zer,reg_ser,reg_instr[25:21],
             reg_instr[20:16],reg_instr[15:11],reg_instr[25:0],reg_instr[31:26],reg_excereg};  
             
endmodule


