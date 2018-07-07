/* {PCWrite 1,IorD 2,MemRead 3,MemWrite 4,MemtoReg 6,
      IRWrite 7,RegDst 9,RegWrite 10,ALUSrcA 12,ALUSrcB 15,ALUOP 20,PCSource 22,BNE 23,SEX 26,StoreX 28,Branch 29} */
      
//Signal --> (--*--)is Invalid(Expected ZERO)
`define  MCU_Rst 30'b10100010000000100_0100000000000
`define  MCU_0 30'b10100010000000100_0100000000000
`define  MCU_1 30'b00000000000001100_0100000000000
`define  MCU_2 30'b00000000000101000_0100000000000
`define  MCU_3 30'b01100000000000000_0000000000000
`define  MCU_4 30'b01010000000000000_0000000000000
`define  MCU_5 30'b00000100010000000_0000000000000
`define  MCU_6 30'b00000000000000010_0000000000000
`define  MCU_7 30'b00000000110000000_0000000000000
`define  MCU_8 30'b00000000000100000_0000000000000
`define  MCU_9 30'b00000000010000000_0000000000000
`define  MCU_10 30'b00000000000110000_0000100000010
`define  MCU_11 30'b00000000000100000_0000100000001
`define  MCU_12 30'b10000000000000000_0001000000000
`define  MCU_13 30'b10001001010000000_0001000000000
`define  MCU_14 30'b10001000110000000_0001100000000
`define  MCU_15 30'b10000000000000000_0001100000000


`define MCU_16 0 //reserve
`define MCU_17 0 //reserve

//Status-->Invalid
`define Status_Rst 4'h0 //reset
`define Status_0 4'h0 //IF
`define Status_1 4'h1 //ID
`define Status_2 4'h2 //Load/Store
`define Status_3 4'h3 //L4
`define Status_4 4'h4 //S4
`define Status_5 4'h5 //L5
`define Status_6 4'h6 //R-type
`define Status_7 4'h7 //R4
`define Status_8 4'h8 //I_R 25-32
`define Status_9 4'h9 //I 4
`define Status_10 4'ha //Branch
`define Status_11 4'hb //Beq/Bne
`define Status_12 4'hc //J
`define Status_13 4'hd //JAL
`define Status_14 4'he //JALR
`define Status_15 4'hf //JR

`define Status_16 5'h10 //reserve
`define Status_17 5'h11 //reserve

