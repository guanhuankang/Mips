
module EXMEM(clk,EXMEMW,rst3,WB,M,Jaddr,addres,rd1,zero,aluout,rd2,dst,pc,
              OWB,OM,OJaddr,Oaddres,Ord1,Ozero,Oaluout,Ord2,Odst,Opc);
    input clk,EXMEMW,rst3;
    input WB,M,Jaddr,addres,rd1,zero,aluout,rd2,dst,pc;
    wire[4:0] WB;
    wire[9:0] M;
    wire[31:0] Jaddr;
    wire[31:0] addres;
    wire[31:0] rd1;
    wire zero;
    wire[31:0] aluout;
    wire[31:0] rd2;
    wire[4:0] dst;
    wire[31:0] pc;
    output OWB,OM,OJaddr,Oaddres,Ord1,Ozero,Oaluout,Ord2,Odst,Opc;
    wire[4:0] OWB;
    wire[9:0] OM;
    wire[31:0] OJaddr;
    wire[31:0] Oaddres;
    wire[31:0] Ord1;
    wire Ozero;
    wire[31:0] Oaluout;
    wire[31:0] Ord2;
    wire[4:0] Odst;
    wire[31:0] Opc;
    
    reg[212:0] reg_reg;
    
    always@(posedge clk)
    begin
      if(rst3==1)
        reg_reg <= 213'd0;
      if(rst3==0 && EXMEMW==1)
        reg_reg <= {WB,M,Jaddr,addres,rd1,zero,aluout,rd2,dst,pc};
    end
    
    assign {OWB,OM,OJaddr,Oaddres,Ord1,Ozero,Oaluout,Ord2,Odst,Opc} = reg_reg;
    

  endmodule
      
      