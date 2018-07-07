
module DM(address, dm_in, dm_out, MemWrite, MemRead, clk);
  input[31:0] address,dm_in;
  input MemWrite, MemRead, clk;
  output dm_out;
  
  wire[31:0] dm_out;
  
  reg[7:0] datamemory[2047:0];
  
  always @(posedge clk)
  begin
   if(MemWrite==1)
    {datamemory[address[31:0]],datamemory[address[31:0]+1],datamemory[address[31:0]+2],datamemory[address[31:0]+3]} <= dm_in;
  end   
  
  assign dm_out = {32{MemRead}}&{datamemory[address[31:0]],datamemory[address[31:0]+1],datamemory[address[31:0]+2],datamemory[address[31:0]+3]};
  
  //test
  integer i;
  always @(posedge clk)
  begin
    if(datamemory[128]==8'hff)
      begin
        $display("************************\nDataMemory:\n");
$display("0-%x",{datamemory[0],datamemory[1],datamemory[2],datamemory[3]});

$display("1-%x",{datamemory[4],datamemory[5],datamemory[6],datamemory[7]});

$display("2-%x",{datamemory[8],datamemory[9],datamemory[10],datamemory[11]});

$display("3-%x",{datamemory[12],datamemory[13],datamemory[14],datamemory[15]});

$display("4-%x",{datamemory[16],datamemory[17],datamemory[18],datamemory[19]});

$display("5-%x",{datamemory[20],datamemory[21],datamemory[22],datamemory[23]});

$display("6-%x",{datamemory[24],datamemory[25],datamemory[26],datamemory[27]});

$display("7-%x",{datamemory[28],datamemory[29],datamemory[30],datamemory[31]});

$display("8-%x",{datamemory[32],datamemory[33],datamemory[34],datamemory[35]});

$display("9-%x",{datamemory[36],datamemory[37],datamemory[38],datamemory[39]});

$display("10-%x",{datamemory[40],datamemory[41],datamemory[42],datamemory[43]});

$display("11-%x",{datamemory[44],datamemory[45],datamemory[46],datamemory[47]});

$display("12-%x",{datamemory[48],datamemory[49],datamemory[50],datamemory[51]});

$display("13-%x",{datamemory[52],datamemory[53],datamemory[54],datamemory[55]});

$display("14-%x",{datamemory[56],datamemory[57],datamemory[58],datamemory[59]});

$display("15-%x",{datamemory[60],datamemory[61],datamemory[62],datamemory[63]});

$display("16-%x",{datamemory[64],datamemory[65],datamemory[66],datamemory[67]});

$display("17-%x",{datamemory[68],datamemory[69],datamemory[70],datamemory[71]});

$display("18-%x",{datamemory[72],datamemory[73],datamemory[74],datamemory[75]});

$display("19-%x",{datamemory[76],datamemory[77],datamemory[78],datamemory[79]});

$display("20-%x",{datamemory[80],datamemory[81],datamemory[82],datamemory[83]});

$display("21-%x",{datamemory[84],datamemory[85],datamemory[86],datamemory[87]});

$display("22-%x",{datamemory[88],datamemory[89],datamemory[90],datamemory[91]});

$display("23-%x",{datamemory[92],datamemory[93],datamemory[94],datamemory[95]});

$display("24-%x",{datamemory[96],datamemory[97],datamemory[98],datamemory[99]});

$display("25-%x",{datamemory[100],datamemory[101],datamemory[102],datamemory[103]});

$display("26-%x",{datamemory[104],datamemory[105],datamemory[106],datamemory[107]});

$display("27-%x",{datamemory[108],datamemory[109],datamemory[110],datamemory[111]});

$display("28-%x",{datamemory[112],datamemory[113],datamemory[114],datamemory[115]});

$display("29-%x",{datamemory[116],datamemory[117],datamemory[118],datamemory[119]});

$display("30-%x",{datamemory[120],datamemory[121],datamemory[122],datamemory[123]});

$display("31-%x",{datamemory[124],datamemory[125],datamemory[126],datamemory[127]});
        $display("************************\nDataMemory:\n");
        //quit
        $display("Exec END");
        $stop;
      end
  end      
endmodule
  
