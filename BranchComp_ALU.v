/*  
    © Copyright by Pham Ngoc Lam
    			   Nguyen Van Chien
    			   Duong Van Bien
    Hanoi University of Science and Technology
    School of Electronic and Telecommunication
    EDABK Laboratory, 611 Ta Quan Buu Library
*/
module BranchComp(
	input 	   [31:0] DataA ,
	input 	   [31:0] DataB ,
	input	   [31:0] PC    ,
	input 	   [31:0] Imm   ,
	input 			  BrUn  ,
	input 			  BSel  ,
	input 	   		  ASel  ,
	input 	   [31:0] inst	,
	output reg 		  BrEq  ,
	output reg 		  BrLT  ,
	output reg [31:0] alu   
	);

wire [31:0] muxA;
wire [31:0]	muxB;

always @(DataA, DataB, BrUn) begin
	if (DataA == DataB) begin
		BrEq = 1'b1;
		BrLT = 1'b0;
	end
	else if ((DataA < DataB) && BrUn == 1'b1) begin
		BrEq = 1'b0;
		BrLT = 1'b1;
	end
	else if ((DataA[30:0] < DataB[30:0]) && BrUn == 1'b0) begin
		BrEq = 1'b0;
		BrLT = 1'b1;
	end
end

assign muxA = (ASel ) ? PC 	 : DataA;
assign muxB = (~BSel) ? DataB: Imm  ;

always @(DataA, DataB, PC, Imm, inst) begin
	if (inst[6:0] == 7'b0110011) begin
		case({inst[31:25], inst[14:12]}) 
			10'b0000000000: alu = muxA + muxB ; // add
			10'b0100000000: alu = muxA - muxB ; // sub
			10'b0000000100: alu = muxA ^ muxB ; // xor
			10'b0000000110: alu = muxA | muxB ; // or
			10'b0000000110: alu = muxA & muxB ; // and
		endcase
	end
	else if (inst[6:0] == 7'b0010011) begin
		case(inst[14:12])
			3'b000: alu = muxA + muxB ; // addi
			3'b001: alu = muxA << muxB; // slli
			3'b100: alu = muxA ^ muxB ; // xori
			3'b110: alu = muxA | muxB ; // ori
			3'b111: alu = muxA & muxB ; // andi
		endcase
	end
	else if (inst[6:0] == 7'b0000011) begin
		case(inst[14:12])
			3'b000: alu = muxA + muxB ; // lw = add
		endcase
	end
	else if (inst[6:0] == 7'b0100011) begin
		case(inst[14:12])
			3'b000: alu = muxA + muxB ; // sw = add
		endcase
	end
	else if (inst[6:0] == 7'b1100011) begin
		case(inst[14:12])
			3'b000: alu = muxA + muxB ; // beq = add
		endcase
	end
end
endmodule