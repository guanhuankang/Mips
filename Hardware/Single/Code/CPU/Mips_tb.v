
module Mips_tb();
reg clk,reset,MIO_ready,INT;
wire mem_w,CPU_MIO;
wire[31:0] inst_in;
wire[31:0] Data_in;
wire[31:0] PC_out;
wire[31:0] Addr_out;
wire[31:0] Data_out;
reg[10:0] cnd;

initial
begin
cnd = 0;
clk = 0;
reset = 1;
end

always @(posedge clk)
begin
  cnd <= cnd +1;
end
always @(negedge clk)
begin
if(cnd==2)reset<=0;
end

always #100 clk = ~clk;

SCPU mySCPU(.clk(clk),
			.reset(reset),
			.MIO_ready(MIO_ready),
			.inst_in(inst_in),
			.Data_in(Data_in),
			.mem_w(mem_w),
			.PC_out(PC_out),
			.Addr_out(Addr_out),
			.Data_out(Data_out), 
			.CPU_MIO(CPU_MIO),
			.INT(INT)
			);

DM myDM(Addr_out, Data_out, Data_in, mem_w, 1'b1, clk);
IM myIM(.address(PC_out), .instr(inst_in));

endmodule