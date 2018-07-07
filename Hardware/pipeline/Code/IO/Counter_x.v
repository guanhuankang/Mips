`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:13:28 07/01/2012 
// Design Name: 
// Module Name:    Counter_8253 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Counter_x(input clk,
					input rst,
					input clk0,
					input clk1,
					input clk2,
					input counter_we,
					input [31:0] counter_val,
					input [1:0] counter_ch,				//Counter channel set

					output counter0_OUT,
					output counter1_OUT,
					output counter2_OUT,
					output [31:0] counter_out
					
					);
reg [32:0] counter0,counter1,counter2;
reg [31:0] counter0_Lock,counter1_Lock,counter2_Lock;
reg [23:0] counter_Ctrl;
reg sq0,sq1,sq2,M0,M1,M2,clr0,clr1,clr2;

//Counter read or write & set		counter_ch=SC1 SC0; counter_Ctrl=XX M2 M1 M0 X
		
	always @ (posedge clk or posedge rst) begin 
		if (rst )
			begin counter0_Lock <=0;counter1_Lock <=0;counter2_Lock <=0;counter_Ctrl<=0; end
		else	 	
			if (counter_we) begin
				case(counter_ch)
					2'h0: begin counter0_Lock <= counter_val;  M0<=1; end	//f0000000: bit1 bit0 =00
					2'h1: begin counter1_Lock <= counter_val;  M1<=1; end //f0000000: bit1 bit0 =01 
					2'h2: begin counter2_Lock <= counter_val;  M2<=1; end //f0000000: bit1 bit0 =10
					2'h3: begin counter_Ctrl <= counter_val[23:0];    end //counter_Ctrl=XX M2 M1 M0 X
				endcase
				end
			else begin counter0_Lock <=counter0_Lock;
						  counter1_Lock <=counter1_Lock;
						  counter2_Lock <=counter2_Lock;
						  counter_Ctrl<=counter_Ctrl;
						  if(clr0) M0<=0;
						  if(clr1) M1<=0;
						  if(clr2) M2<=0;						  
					end
	end

// Counter channel 0			
	always @ (posedge clk0 or posedge rst) begin 
		if (rst )
			begin counter0<=0; sq0<=0; end
		else
			case(counter_Ctrl[2:1])
				2'b00: begin if (M0) begin counter0 <= {1'b0,counter0_Lock}; clr0<=1; end 
								 else if  (counter0[32]==0)begin counter0 <= counter0 - 1'b1; clr0<=0; end
						 end  
				2'b01: begin if (counter0[32]==0) counter0 <= counter0 - 1'b1; else counter0 <={1'b0,counter0_Lock}; end
				2'b10: begin sq0<=counter0[32];
						 if (sq0!=counter0[32]) counter0[31:0] <= {1'b0,counter0_Lock[31:1]}; else counter0 <= counter0 - 1'b1;end  
				2'b11: counter0 <= counter0 - 1'b1; 
			endcase
	end
	
	assign counter0_OUT=counter0[32];
	assign counter1_OUT=counter1[32];
	assign counter2_OUT=counter2[32];
	assign counter_out = counter0[31:0];

endmodule
