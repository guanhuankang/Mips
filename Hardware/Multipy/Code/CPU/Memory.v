`include "StoreLoad_Def.v"

module Memory(clk, address, writedata, readdata, MemRead, MemWrite, StoreX);
  input[31:0] address,writedata;
  input MemRead,MemWrite,clk;
  input[1:0] StoreX;
  output readdata;
  
  wire[31:0] readdata;
  
  reg[7:0] memory[16483:0];//16K Bytes
  
  initial
  begin
  //{memory[0x0000_300c],memory[0x0000_3008],memory[0x0000_3004],memory[0x0000_3000]}=0x00001122;
{memory[12291],memory[12290],memory[12289],memory[12288]}=32'h014a5026;
{memory[12295],memory[12294],memory[12293],memory[12292]}=32'h016b5826;
{memory[12299],memory[12298],memory[12297],memory[12296]}=32'h356b0001;
{memory[12303],memory[12302],memory[12301],memory[12300]}=32'h000b6021;
{memory[12307],memory[12306],memory[12305],memory[12304]}=32'h018c6021;
{memory[12311],memory[12310],memory[12309],memory[12308]}=32'h0000a827;
{memory[12315],memory[12314],memory[12313],memory[12312]}=32'h02aca824;
{memory[12319],memory[12318],memory[12317],memory[12316]}=32'h00156040;
{memory[12323],memory[12322],memory[12321],memory[12320]}=32'h018c6021;
{memory[12327],memory[12326],memory[12325],memory[12324]}=32'h018c6021;
{memory[12331],memory[12330],memory[12329],memory[12328]}=32'h018c6021;
{memory[12335],memory[12334],memory[12333],memory[12332]}=32'h018c6021;
{memory[12339],memory[12338],memory[12337],memory[12336]}=32'h018c6021;
{memory[12343],memory[12342],memory[12341],memory[12340]}=32'h02318826;
{memory[12347],memory[12346],memory[12345],memory[12344]}=32'h022b9021;
{memory[12351],memory[12350],memory[12349],memory[12348]}=32'h01ce7026;
{memory[12355],memory[12354],memory[12353],memory[12352]}=32'h016b7821;
{memory[12359],memory[12358],memory[12357],memory[12356]}=32'h01ef7821;
{memory[12363],memory[12362],memory[12361],memory[12360]}=32'h014b6821;
{memory[12367],memory[12366],memory[12365],memory[12364]}=32'h000b5021;
{memory[12371],memory[12370],memory[12369],memory[12368]}=32'h000d5821;
{memory[12375],memory[12374],memory[12373],memory[12372]}=32'hadcd0000;
{memory[12379],memory[12378],memory[12377],memory[12376]}=32'h01cf8021;
{memory[12383],memory[12382],memory[12381],memory[12380]}=32'hae100000;
{memory[12387],memory[12386],memory[12385],memory[12384]}=32'h8e0e0000;
{memory[12391],memory[12390],memory[12389],memory[12388]}=32'h01cc882b;
{memory[12395],memory[12394],memory[12393],memory[12392]}=32'h1232fff7;
{memory[12399],memory[12398],memory[12397],memory[12396]}=32'h0810001b;

  end
  
  assign readdata = {memory[address[31:0]+3],memory[address[31:0]+2],memory[address[31:0]+1],memory[address[31:0]]};
  
  always@(posedge clk)
  begin   
$display("************************\nmemory:\n");
$display("0-%x",{memory[0],memory[1],memory[2],memory[3]});

$display("1-%x",{memory[4],memory[5],memory[6],memory[7]});

$display("2-%x",{memory[8],memory[9],memory[10],memory[11]});

$display("3-%x",{memory[12],memory[13],memory[14],memory[15]});

$display("4-%x",{memory[16],memory[17],memory[18],memory[19]});

$display("5-%x",{memory[20],memory[21],memory[22],memory[23]});

$display("6-%x",{memory[24],memory[25],memory[26],memory[27]});

$display("7-%x",{memory[28],memory[29],memory[30],memory[31]});

$display("8-%x",{memory[32],memory[33],memory[34],memory[35]});

$display("9-%x",{memory[36],memory[37],memory[38],memory[39]});

$display("10-%x",{memory[40],memory[41],memory[42],memory[43]});

$display("11-%x",{memory[44],memory[45],memory[46],memory[47]});

$display("12-%x",{memory[48],memory[49],memory[50],memory[51]});

$display("13-%x",{memory[52],memory[53],memory[54],memory[55]});

$display("14-%x",{memory[56],memory[57],memory[58],memory[59]});

$display("15-%x",{memory[60],memory[61],memory[62],memory[63]});

$display("16-%x",{memory[64],memory[65],memory[66],memory[67]});

$display("17-%x",{memory[68],memory[69],memory[70],memory[71]});

$display("18-%x",{memory[72],memory[73],memory[74],memory[75]});

$display("19-%x",{memory[76],memory[77],memory[78],memory[79]});

$display("20-%x",{memory[80],memory[81],memory[82],memory[83]});

$display("21-%x",{memory[84],memory[85],memory[86],memory[87]});

$display("22-%x",{memory[88],memory[89],memory[90],memory[91]});

$display("23-%x",{memory[92],memory[93],memory[94],memory[95]});

$display("24-%x",{memory[96],memory[97],memory[98],memory[99]});

$display("25-%x",{memory[100],memory[101],memory[102],memory[103]});

$display("26-%x",{memory[104],memory[105],memory[106],memory[107]});

$display("27-%x",{memory[108],memory[109],memory[110],memory[111]});

$display("28-%x",{memory[112],memory[113],memory[114],memory[115]});

$display("29-%x",{memory[116],memory[117],memory[118],memory[119]});

$display("30-%x",{memory[120],memory[121],memory[122],memory[123]});

$display("31-%x",{memory[124],memory[125],memory[126],memory[127]});
$display("************************\nmemory:\n");
	
    if(MemWrite==1 && clk==1)
      begin
        if(StoreX==2'b00)
          begin
            memory[address[31:0]] <= writedata[7:0];
            $display("Memory:%x address:%x Store Byte",writedata[7:0],address);
          end
        else begin
          if(StoreX==2'b01)
          begin
            {memory[address[31:0]+1],memory[address[31:0]]} <= writedata[15:0];
            $display("Memory:%x address:%x Store Half",writedata[15:0],address);
          end
          else begin
           if(StoreX==2'b11)
           begin
             {memory[address[31:0]+3],memory[address[31:0]+2],memory[address[31:0]+1],memory[address[31:0]]} <= writedata[31:0];
            $display("Memory:%x address:%x Store Word",writedata,address);
           end  
          end
        end        
      end
  end


endmodule