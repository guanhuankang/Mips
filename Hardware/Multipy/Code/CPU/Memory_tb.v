
module memory_tb();
  reg clk,MemRead,MemWrite;
  reg[1:0] StoreX;
  reg[31:0] address,writedata;
  wire[31:0] readdata;
  integer i,j;
  initial
  begin
    i = 1;
    j = 1;
    clk = 0;
    StoreX = 2'b00;
    address = 32'd0;
    writedata = 32'd1;
    MemWrite = 1;
    MemRead = 0;
  end
  
  Memory myMemory(clk,address,writedata,readdata,MemRead,MemWrite,StoreX);
  
  always #100
  clk <= ~clk;
  
  always @(posedge clk)
  begin
    if(i<=16384 && j==1)
      begin
        address <= i;
        writedata <= i+1;
        i <= i+1;
      end
    else if(i==16385)
      begin
        MemWrite <= 0;
        MemRead <= 1;
        address <= 0;
        i <= 0;
        j <= 2;
      end
    else
        begin
        $display("%x %x",address,readdata);
        i <= i+1;
        address <= address+1;
        end
  end
  
endmodule