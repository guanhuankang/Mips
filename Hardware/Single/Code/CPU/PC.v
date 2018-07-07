
module PC(clk, write_in, read_out, pc_reset);
  input[31:0] write_in;
  input clk,pc_reset;
  output read_out;
  
  wire[31:0] read_out;
  
  reg[31:0] pc;
  
  always @(posedge clk , posedge pc_reset)
    begin
      $display("pc:%x (Come from PC) writein:%x",pc,write_in);
      if(pc_reset == 1)
        pc <= 0;        
      else
        pc <= write_in;
    end
    
  assign read_out = pc;
  
endmodule