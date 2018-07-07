
module intmodule(input[31:0] INT32,
				 input[31:0] Status,
				 input[31:0] epcin,
				 output[31:0] wepc,
				 output[31:0] wcause,
				 output[31:0] wstatus,
				 output 	  INT);
	
	wire[31:0] valids = (~Status)&INT32;
	wire[31:0] tmp = valids&(~valids+32'd1);
	assign INT = |valids;
	assign wepc = epcin;
	assign wstatus = Status|tmp;
	reg[31:0] cau;
	always@(*)
	begin
	if(tmp==32'd1)cau=0;
	else if(tmp==32'd2)cau=1;
	else if(tmp==32'd4)cau=2;
	else if(tmp==32'd8)cau=3;
	else if(tmp==32'd16)cau=4;
	else if(tmp==32'd32)cau=5;
	else if(tmp==32'd64)cau=6;
	else if(tmp==32'd128)cau=7;
	else if(tmp==32'd256)cau=8;
	else if(tmp==32'd512)cau=9;
	else if(tmp==32'd1024)cau=10;
	else if(tmp==32'h800)cau=11;
	else if(tmp==32'h1000)cau=12;
	else if(tmp==32'h2000)cau=13;
	else if(tmp==32'h4000)cau=14;
	else if(tmp==32'h8000)cau=15;
	else if(tmp==32'h10000)cau=16;
	else if(tmp==32'h20000)cau=17;
	else if(tmp==32'h40000)cau=18;
	// There is too long ....blur blur blur
	else cau=19;
	end
	assign wcause = cau<<2;

endmodule