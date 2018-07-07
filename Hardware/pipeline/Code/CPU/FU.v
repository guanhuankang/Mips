//forwarding unit
module FU(rs,rt,exrd,exw,mrd,mw,fa,fb);
  input[4:0] rs,rt,exrd,mrd;
  input exw,mw;
  output fa,fb;
  wire[1:0] fa,fb;
  
  reg[1:0] ffa,ffb;
  
  always@(*)
  begin
    if(exw==1 && exrd==rs && rs!=5'd0)
      ffa = 2'b01;
    else if(mw==1 && mrd==rs && rs!=5'd0)
      ffa = 2'b10;
    else
      ffa = 2'b00;
      
    if(exw==1 && exrd==rt && rt!=5'd0)
      ffb = 2'b01;
    else if(mw==1 && mrd==rt && rt!=5'd0)
      ffb = 2'b10;
    else
      ffb = 2'b00;
  end
  
  assign fa = ffa;
  assign fb = ffb;   
    
endmodule