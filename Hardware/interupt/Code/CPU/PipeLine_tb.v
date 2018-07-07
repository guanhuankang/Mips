
module pipeline41_tb();
reg clk,reset,MIO_ready,INT;
wire mem_w,CPU_MIO;
wire[31:0] inst_in;
wire[31:0] Data_in;
wire[31:0] PC_out;
wire[31:0] Addr_out;
wire[31:0] Data_out;
reg[10:0] cnd;
  `timescale 1ns/1ps
initial
begin
cnd = 0;
clk = 0;
reset = 1;
INT = 0;
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

SCPU mySCPU(		.clk(clk),
					.Data_in(Data_in),
					.inst_in(inst_in),
					.INT(INT),
					.MIO_ready(MIO_ready),
					.reset(reset),
					.Addr_out(Addr_out),
					.CPU_MIO(CPU_MIO),
					.Data_out(Data_out),
					.mem_w(mem_w),
					.PC_out(PC_out)
				);
			
IM myIM(PC_out, inst_in, clk);
DM myDM(Addr_out, Data_out, Data_in, mem_w, 1'b1, 2'b11, clk);
endmodule