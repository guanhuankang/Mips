
module PC(clk, pc_in, PCWrite, pc_out, rst);
  input clk,PCWrite,rst;
  input[31:0] pc_in;
  output pc_out;
  
  wire[31:0] pc_out;
  reg[31:0] pc;
  
  always@(posedge clk , posedge rst)
  begin
    if(rst==1)
      pc <= 32'h0000_3000;
    else
      if(PCWrite==1)
        pc <= pc_in;
  end
  
/*   always@(negedge clk)
  begin
    $display("---------------------------------------------------------------");
    $display("PC %x PCWrite:%x",pc,PCWrite);
  end */
  
  assign pc_out = pc;      
endmodule
