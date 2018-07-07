
module IM(address, instr, clk);
  input[31:0] address;
  input clk;
  output instr;
  
  wire[31:0] instr;
    
  reg[7:0] instrM[16383:0];
  
  //debug
  initial
  begin
{instrM[12291],instrM[12290],instrM[12289],instrM[12288]}=32'h08000c08;
{instrM[12295],instrM[12294],instrM[12293],instrM[12292]}=32'h00000020;
{instrM[12299],instrM[12298],instrM[12297],instrM[12296]}=32'h00000020;
{instrM[12303],instrM[12302],instrM[12301],instrM[12300]}=32'h00000020;
{instrM[12307],instrM[12306],instrM[12305],instrM[12304]}=32'h00000020;
{instrM[12311],instrM[12310],instrM[12309],instrM[12308]}=32'h00000020;
{instrM[12315],instrM[12314],instrM[12313],instrM[12312]}=32'h00000020;
{instrM[12319],instrM[12318],instrM[12317],instrM[12316]}=32'h00000020;
{instrM[12323],instrM[12322],instrM[12321],instrM[12320]}=32'h00000827;
{instrM[12327],instrM[12326],instrM[12325],instrM[12324]}=32'h00211820;
{instrM[12331],instrM[12330],instrM[12329],instrM[12328]}=32'h00631820;
{instrM[12335],instrM[12334],instrM[12333],instrM[12332]}=32'h00631820;
{instrM[12339],instrM[12338],instrM[12337],instrM[12336]}=32'h0060a027;
{instrM[12343],instrM[12342],instrM[12341],instrM[12340]}=32'h00631820;
{instrM[12347],instrM[12346],instrM[12345],instrM[12344]}=32'h00631820;
{instrM[12351],instrM[12350],instrM[12349],instrM[12348]}=32'h00631820;
{instrM[12355],instrM[12354],instrM[12353],instrM[12352]}=32'h00631820;
{instrM[12359],instrM[12358],instrM[12357],instrM[12356]}=32'h00631820;
{instrM[12363],instrM[12362],instrM[12361],instrM[12360]}=32'h00633020;
{instrM[12367],instrM[12366],instrM[12365],instrM[12364]}=32'h00c61820;
{instrM[12371],instrM[12370],instrM[12369],instrM[12368]}=32'h00632020;
{instrM[12375],instrM[12374],instrM[12373],instrM[12372]}=32'h00846820;
{instrM[12379],instrM[12378],instrM[12377],instrM[12376]}=32'h01ad4020;
{instrM[12383],instrM[12382],instrM[12381],instrM[12380]}=32'h0020102a;
{instrM[12387],instrM[12386],instrM[12385],instrM[12384]}=32'h00421820;
{instrM[12391],instrM[12390],instrM[12389],instrM[12388]}=32'h00631820;
{instrM[12395],instrM[12394],instrM[12393],instrM[12392]}=32'h34030004;
{instrM[12399],instrM[12398],instrM[12397],instrM[12396]}=32'hac630000;
{instrM[12403],instrM[12402],instrM[12401],instrM[12400]}=32'h8c650000;
{instrM[12407],instrM[12406],instrM[12405],instrM[12404]}=32'h00a52820;
{instrM[12411],instrM[12410],instrM[12409],instrM[12408]}=32'h00a52820;
{instrM[12415],instrM[12414],instrM[12413],instrM[12412]}=32'hac650000;
{instrM[12419],instrM[12418],instrM[12417],instrM[12416]}=32'h8c660000;
{instrM[12423],instrM[12422],instrM[12421],instrM[12420]}=32'h00a52820;
{instrM[12427],instrM[12426],instrM[12425],instrM[12424]}=32'h00a52820;
{instrM[12431],instrM[12430],instrM[12429],instrM[12428]}=32'haca50000;
{instrM[12435],instrM[12434],instrM[12433],instrM[12432]}=32'h8c660000;
{instrM[12439],instrM[12438],instrM[12437],instrM[12436]}=32'h00cd3824;
{instrM[12443],instrM[12442],instrM[12441],instrM[12440]}=32'h00a32820;
{instrM[12447],instrM[12446],instrM[12445],instrM[12444]}=32'h10a00007;
{instrM[12451],instrM[12450],instrM[12449],instrM[12448]}=32'h8c680000;
{instrM[12455],instrM[12454],instrM[12453],instrM[12452]}=32'hac680000;
{instrM[12459],instrM[12458],instrM[12457],instrM[12456]}=32'h8c690000;
{instrM[12463],instrM[12462],instrM[12461],instrM[12460]}=32'hac690000;
{instrM[12467],instrM[12466],instrM[12465],instrM[12464]}=32'h8c6a0000;
{instrM[12471],instrM[12470],instrM[12469],instrM[12468]}=32'h012a482a;
{instrM[12475],instrM[12474],instrM[12473],instrM[12472]}=32'h110a0001;
{instrM[12479],instrM[12478],instrM[12477],instrM[12476]}=32'h08000c08;
{instrM[12483],instrM[12482],instrM[12481],instrM[12480]}=32'h34010001;
{instrM[12487],instrM[12486],instrM[12485],instrM[12484]}=32'h00011022;
{instrM[12491],instrM[12490],instrM[12489],instrM[12488]}=32'hac020080;
{instrM[12495],instrM[12494],instrM[12493],instrM[12492]}=32'h08000c30;

  end
  
  assign instr = {instrM[address+3],instrM[address+2],instrM[address+1],instrM[address]};    

endmodule
  
  
  


