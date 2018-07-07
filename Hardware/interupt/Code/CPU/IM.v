
module IM(address, instr, clk);
  input[31:0] address;
  input clk;
  output instr;
  
  wire[31:0] instr;
    
  reg[7:0] instrM[16383:0];
  
  //debug
  initial
  begin
{instrM[12291],instrM[12290],instrM[12289],instrM[12288]}=32'h34021234;
{instrM[12295],instrM[12294],instrM[12293],instrM[12292]}=32'h00000000;
{instrM[12299],instrM[12298],instrM[12297],instrM[12296]}=32'h00000000;
{instrM[12303],instrM[12302],instrM[12301],instrM[12300]}=32'h00000000;
{instrM[12307],instrM[12306],instrM[12305],instrM[12304]}=32'h00000000;
{instrM[12311],instrM[12310],instrM[12309],instrM[12308]}=32'h00000000;
{instrM[12315],instrM[12314],instrM[12313],instrM[12312]}=32'h00000000;
{instrM[12319],instrM[12318],instrM[12317],instrM[12316]}=32'h00000000;
{instrM[12323],instrM[12322],instrM[12321],instrM[12320]}=32'h00000000;
{instrM[12327],instrM[12326],instrM[12325],instrM[12324]}=32'h08000c0d;
{instrM[12331],instrM[12330],instrM[12329],instrM[12328]}=32'h4082a000;
{instrM[12335],instrM[12334],instrM[12333],instrM[12332]}=32'h4082a800;
{instrM[12339],instrM[12338],instrM[12337],instrM[12336]}=32'h4082b000;
{instrM[12343],instrM[12342],instrM[12341],instrM[12340]}=32'h08000c0d;
{instrM[12347],instrM[12346],instrM[12345],instrM[12344]}=32'h00000000;
{instrM[12351],instrM[12350],instrM[12349],instrM[12348]}=32'h00000000;
{instrM[12355],instrM[12354],instrM[12353],instrM[12352]}=32'h00000000;
{instrM[12359],instrM[12358],instrM[12357],instrM[12356]}=32'h00000000;
{instrM[12363],instrM[12362],instrM[12361],instrM[12360]}=32'h00000000;
{instrM[12367],instrM[12366],instrM[12365],instrM[12364]}=32'h00000000;
{instrM[12371],instrM[12370],instrM[12369],instrM[12368]}=32'h00000000;
{instrM[12375],instrM[12374],instrM[12373],instrM[12372]}=32'h00000000;
{instrM[12379],instrM[12378],instrM[12377],instrM[12376]}=32'h00000000;
{instrM[12383],instrM[12382],instrM[12381],instrM[12380]}=32'h00000000;
{instrM[12387],instrM[12386],instrM[12385],instrM[12384]}=32'h00000000;
{instrM[12391],instrM[12390],instrM[12389],instrM[12388]}=32'h00000000;
{instrM[12395],instrM[12394],instrM[12393],instrM[12392]}=32'h00000000;
{instrM[12399],instrM[12398],instrM[12397],instrM[12396]}=32'h00000000;
{instrM[12403],instrM[12402],instrM[12401],instrM[12400]}=32'h00000000;
{instrM[12407],instrM[12406],instrM[12405],instrM[12404]}=32'h00000000;

  end
  
  assign instr = {instrM[address+3],instrM[address+2],instrM[address+1],instrM[address]};    

endmodule
  
  
  

