`include "Instr_Def.v"
//Hazard detect unit
module HDU(instr,rs, rt, rd, MMR, rst2, PCWriteA, IFIDW);
  input[4:0] rs,rt,rd;
  input MMR;
  input[5:0] instr;
  output rst2,PCWriteA,IFIDW;
  wire rst2,PCWriteA,IFIDW;
  
  reg[2:0] res;
  always@(*)
  begin 
    if(MMR==1 && (rs==rd || rt==rd) && instr==`Instr_LW)
	begin
      res = 3'b110;
	end
    else
	begin
      res = 3'b001;	
	end
  end
  
  assign {rst2,PCWriteA,IFIDW} = res;  
endmodule