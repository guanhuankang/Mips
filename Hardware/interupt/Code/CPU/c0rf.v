

module c0rf(input rst,
			input clk,
			input INT,
			input[31:0] wepc,
			input[31:0] wcause,
			input[31:0] wstatus,
			input[4:0]  raddr,
			input[4:0]  waddr,
			input[31:0] wdata,
			input       c0w,
			input       back,
			output[31:0] rdata,
			output[31:0] Status,
			output[31:0] EPC,
			output[31:0] Cause);
  
  reg[31:0] regfiles[31:0];
  reg[37:0] b1;
  reg[37:0] b2;
  
  always @(posedge clk ,posedge rst)
  begin
    if(rst==1)
      begin 
      regfiles[0]	= 0;regfiles[1]	= 0;regfiles[2]	= 0;regfiles[3]	= 0;
      regfiles[4]	= 0;regfiles[5]	= 0;regfiles[6]	= 0;regfiles[7]	= 0;
      regfiles[8]	= 0;regfiles[9]	= 0;regfiles[10]	= 0;regfiles[11]	= 0;
      regfiles[12]	= 0;regfiles[13]	= 0;regfiles[14]	= 0;regfiles[15]	= 0;
      regfiles[16]	= 0;regfiles[17]	= 0;regfiles[18]	= 0;regfiles[19]	= 0;
      regfiles[20]	= 0;regfiles[21]	= 0;regfiles[22]	= 0;regfiles[23]	= 0;
      regfiles[24]	= 0;regfiles[25]	= 0;regfiles[26]	= 0;regfiles[27]	= 0;
      regfiles[28]	= 0;regfiles[29]	= 0;regfiles[30]	= 0;regfiles[31]	= 0;
	  b1 = 0; b2 = 0;
	  end
	else
	  begin
		if(INT==1)
		begin
		  $display("wepc:%x  wcause:%x",wepc,wcause);
		  regfiles[14] = wepc;
		  regfiles[13] = wcause;
		  regfiles[12] = wstatus;
		//back
			if(b1[0]==1 && b2[0]!=1)
			regfiles[b1[5:1]] = b1[37:6];
			else if(b1[0]!=1 && b2[0]==1)
			regfiles[b2[5:1]] = b2[37:6];
			else if(b1[0]==1 && b2[0]==1)
			begin
			  if(b1[5:1]==b2[5:1])regfiles[b2[5:1]] = b2[37:6];
			  else
			  begin
			  regfiles[b1[5:1]] = b1[37:6];
			  regfiles[b2[5:1]] = b2[37:6];
			  end
			end
			else
			 ;
		//back
		end
		else if(back==1)
		begin
		//back
			if(b1[0]==1 && b2[0]!=1)
			regfiles[b1[5:1]] = b1[37:6];
			else if(b1[0]!=1 && b2[0]==1)
			regfiles[b2[5:1]] = b2[37:6];
			else if(b1[0]==1 && b2[0]==1)
			begin
			  if(b1[5:1]==b2[5:1])regfiles[b2[5:1]] = b2[37:6];
			  else
			  begin
			  regfiles[b1[5:1]] = b1[37:6];
			  regfiles[b2[5:1]] = b2[37:6];
			  end
			end
			else
			 ;
		//back
		end
		else
		begin
	      b2 = b1;
		  b1 = {regfiles[waddr],waddr,c0w};
		  if(c0w==1)
		    regfiles[waddr] = wdata;
		end
	  end
  end
  
  
  assign Status = regfiles[12];
  assign Cause = regfiles[13];
  assign EPC = regfiles[14];
  assign rdata = regfiles[raddr];
   
  //test
  always @(negedge clk)
  begin
    if(rst!=1)
      begin
	    $display("--***************----back:%x----*************--",back);
        $display("0-%x 1-%x 2-%x 3-%x 4-%x 5-%x 6-%x 7-%x ",regfiles[0],regfiles[1],regfiles[2],regfiles[3],regfiles[4],regfiles[5],regfiles[6],regfiles[7]);
        $display("8-%x 9-%x 10-%x 11-%x 12-%x 13-%x 14-%x 15-%x ",regfiles[8],regfiles[9],regfiles[10],regfiles[11],regfiles[12],regfiles[13],regfiles[14],regfiles[15]);
        $display("16-%x 17-%x 18-%x 19-%x 20-%x 21-%x 22-%x 23-%x ",regfiles[16],regfiles[17],regfiles[18],regfiles[19],regfiles[20],regfiles[21],regfiles[22],regfiles[23]);
        $display("24-%x 25-%x 26-%x 27-%x 28-%x 29-%x 30-%x 31-%x ",regfiles[24],regfiles[25],regfiles[26],regfiles[27],regfiles[28],regfiles[29],regfiles[30],regfiles[31]);
		$display("b1:%x  b2:%x",b1,b2);
        $display("---*********************----RF--%x------REGWrite-%x--data-%x--*********-----",waddr,c0w,wdata);
      end
  end
endmodule
  

