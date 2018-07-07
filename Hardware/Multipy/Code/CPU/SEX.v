`include "StoreLoad_Def.v"

module LWX(mdr, SEX, mout);
  input[31:0] mdr;
  input[2:0] SEX;
  output mout;
  
  wire[31:0] mout;
  reg[31:0] mmout;
  
  always@(*)
  begin
    case(SEX)
      `LoadByte:
        mmout = {{24{mdr[7]}},mdr[7:0]};
      `LoadHalf:
        mmout = {{16{mdr[15]}},mdr[15:0]};
      `LoadWord:
        mmout = mdr;
      `LoadByteU:
        mmout = {{24'd0},mdr[7:0]};
      `LoadHalfU:
        mmout = {{16'd0},mdr[15:0]};
      default:
        mmout = mdr;
    endcase
  end
  
  assign mout = mmout;
  
endmodule
