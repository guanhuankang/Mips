

module RF(raddr1, raddr2, waddr,rdata1, rdata2, wdata, RegWrite, clk,rst);
  input[4:0] raddr1,raddr2,waddr;
  input[31:0] wdata;
  input RegWrite,clk,rst;
  output rdata1, rdata2;
  
  wire[31:0] rdata1,rdata2;
  
  reg[31:0] regfiles[31:0];
  
/*   always @(*)
    regfiles[0] <= 0; */
  
  always @(posedge clk ,posedge rst)
    if(rst==1)
      begin 
      regfiles[0]	<= 0;regfiles[1]	<= 0;regfiles[2]	<= 0;regfiles[3]	<= 0;
      regfiles[4]	<= 0;regfiles[5]	<= 0;regfiles[6]	<= 0;regfiles[7]	<= 0;
      regfiles[8]	<= 0;regfiles[9]	<= 0;regfiles[10]	<= 0;regfiles[11]	<= 0;
      regfiles[12]	<= 0;regfiles[13]	<= 0;regfiles[14]	<= 0;regfiles[15]	<= 0;
      regfiles[16]	<= 0;regfiles[17]	<= 0;regfiles[18]	<= 0;regfiles[19]	<= 0;
      regfiles[20]	<= 0;regfiles[21]	<= 0;regfiles[22]	<= 0;regfiles[23]	<= 0;
      regfiles[24]	<= 0;regfiles[25]	<= 0;regfiles[26]	<= 0;regfiles[27]	<= 0;
      regfiles[28]	<= 0;regfiles[29]	<= 0;regfiles[30]	<= 0;regfiles[31]	<= 0;
      end       
    else if(RegWrite == 1 && waddr[4:0]!=0)
      regfiles[waddr[4:0]] <= wdata;
  
  assign rdata1 = regfiles[raddr1[4:0]];
  assign rdata2 = regfiles[raddr2[4:0]];
 /* assign testbench = {regfiles[0],regfiles[1],regfiles[2],regfiles[3],
                      regfiles[4],regfiles[5],regfiles[6],regfiles[7],
                      regfiles[8],regfiles[9],regfiles[10],regfiles[11],
                      regfiles[12],regfiles[13],regfiles[14],regfiles[15],
                      regfiles[16],regfiles[17],regfiles[18],regfiles[19],
                      regfiles[20],regfiles[21],regfiles[22],regfiles[23],
                      regfiles[24],regfiles[25],regfiles[26],regfiles[27],
                      regfiles[28],regfiles[29],regfiles[30],regfiles[31]};*/
  //test
  /*
  always @(negedge clk)
  begin
    if(exec == 2'b10)
      begin
        $display("0-%x 1-%x 2-%x 3-%x 4-%x 5-%x 6-%x 7-%x ",regfiles[0],regfiles[1],regfiles[2],regfiles[3],regfiles[4],regfiles[5],regfiles[6],regfiles[7]);
        $display("8-%x 9-%x 10-%x 11-%x 12-%x 13-%x 14-%x 15-%x ",regfiles[8],regfiles[9],regfiles[10],regfiles[11],regfiles[12],regfiles[13],regfiles[14],regfiles[15]);
        $display("16-%x 17-%x 18-%x 19-%x 20-%x 21-%x 22-%x 23-%x ",regfiles[16],regfiles[17],regfiles[18],regfiles[19],regfiles[20],regfiles[21],regfiles[22],regfiles[23]);
        $display("24-%x 25-%x 26-%x 27-%x 28-%x 29-%x 30-%x 31-%x ",regfiles[24],regfiles[25],regfiles[26],regfiles[27],regfiles[28],regfiles[29],regfiles[30],regfiles[31]);
        $display("-------------------------------RF--%x----------------------------------------",exec);
      end
  end
*/
endmodule
  
