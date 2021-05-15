/*  
    © Copyright by Pham Ngoc Lam
    			   Nguyen Van Chien
    			   Duong Van Bien
    Hanoi University of Science and Technology
    School of Electronic and Telecommunication
    EDABK Laboratory, 611 Ta Quan Buu Library
*/
module ImmGen(
	input 	   [31:0] inst  ,
	input 	   [2 :0] ImmSel,
	output reg [31:0] Imm   
 	);

localparam [2:0] R = 3'd0,
				 I = 3'd1,
				 S = 3'd2,
				 B = 3'd3,
				 J = 3'd4,
				 U = 3'd5;

always @(inst or ImmSel) begin
	case (ImmSel)
		R: begin
			Imm = 32'b0;
		end
		I: begin
			if (inst [31:30] == 0) begin
				Imm = {21'b0, inst[31:20]};
			end
			else begin
				Imm = {21'b111111111111111111111, inst[31:20]};
			end
		end
		S: begin
			if (inst [31:30] == 0) begin
				Imm = {21'b0, inst[31:25], inst[11:7]};
			end
			else begin
				Imm = {21'b111111111111111111111, inst[31:25], inst[11:7]};
			end
		end
		B: begin
			if (inst [31:30] == 0) begin
				Imm = {20'b0, inst[31], inst[7], inst[30:25], inst[11:8], 1'b0};
			end
			else begin
				Imm = {20'b11111111111111111111, inst[31], inst[7], inst[30:25], inst[11:8], 1'b0};
			end
		end
		J: begin
			if (inst [31:30] == 0) begin
				Imm = {11'b0, inst[31], inst[19:12], inst[20], inst[30:21], 1'b0};
			end
			else begin
				Imm = {11'b11111111111, inst[31], inst[19:12], inst[20], inst[30:21], 1'b0};
			end
		end
		U: begin
			if (inst [31:30] == 0) begin
				Imm = {12'b0, inst[31:12]};
			end
			else begin
				Imm = {12'b111111111111, inst[31:12]};
			end
		end
	endcase
end
endmodule