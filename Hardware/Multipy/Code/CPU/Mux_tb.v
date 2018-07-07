
module Mux_tb();
  reg[4:0] m0,m1,m2,m3,m4,m5,m6,m7;
  reg[2:0] ctrl[7:0];
  wire[4:0] mout[7:0];
  
  initial
  begin
    m0 = 32'd9;
    m1 = 32'd2;
    m2 = 32'd3;
    m3 = 32'd6;
    m4 = 32'd1;
    m5 = 32'd4;
    m6 = 32'd5;
    m7 = 32'd9;
    ctrl[0] = 3'b000;
    ctrl[1] = 3'b001;
    ctrl[2] = 3'b010;
    ctrl[3] = 3'b011;
    ctrl[4] = 3'b100;
    ctrl[5] = 3'b101;
    ctrl[6] = 3'b110;
    ctrl[7] = 3'b111;
  end
  
  Mux3Bits #(5) Mux1(m0,m1,m2,m3,m4,m5,m6,m7,mout[0],ctrl[0]);
  Mux3Bits #(5) Mux2(m0,m1,m2,m3,m4,m5,m6,m7,mout[1],ctrl[1]);
  Mux3Bits #(5) Mux3(m0,m1,m2,m3,m4,m5,m6,m7,mout[2],ctrl[2]);
  Mux3Bits #(5) Mux4(m0,m1,m2,m3,m4,m5,m6,m7,mout[3],ctrl[3]);
  Mux3Bits #(5) Mux5(m0,m1,m2,m3,m4,m5,m6,m7,mout[4],ctrl[4]);
  Mux3Bits #(5) Mux6(m0,m1,m2,m3,m4,m5,m6,m7,mout[5],ctrl[5]);
  Mux3Bits #(5) Mux7(m0,m1,m2,m3,m4,m5,m6,m7,mout[6],ctrl[6]);
  Mux3Bits #(5) Mux8(m0,m1,m2,m3,m4,m5,m6,m7,mout[7],ctrl[7]);
  
  always #100
  begin
    $display("ANS:%x",mout[0]);
    $display("ANS:%x",mout[1]);
    $display("ANS:%x",mout[2]);
    $display("ANS:%x",mout[3]);
    $display("ANS:%x",mout[4]);
    $display("ANS:%x",mout[5]);
    $display("ANS:%x",mout[6]);
    $display("ANS:%x",mout[7]);
  end
  
endmodule 
