
module Flop(clk,din,dout,ctrl,rst);
  parameter width=32;
  input[width:1] din;
  input clk,ctrl,rst;
  output dout;
  wire[width:1] dout;
  
  reg[width:1] content;
  
  always @(posedge clk , posedge rst)
  begin
    if(rst==1)
      content <= {width{1'b0}};
    else
      if(ctrl==1)
        content <= din;
  end
  
  assign dout = content;
endmodule
  
