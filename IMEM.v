/*  
    © Copyright by Pham Ngoc Lam
    			   Nguyen Van Chien
    			   Duong Van Bien
    Hanoi University of Science and Technology
    School of Electronic and Telecommunication
    EDABK Laboratory, 611 Ta Quan Buu Library
*/
module IMEM(
	input 	   [31:0] PC  ,
	output reg [31:0] inst
	);
 							 // 				  	     	31   25  24 20  19 15  14   10  7  6     0
localparam [31:0] x0h = 32'd0 , // add  x8 , x12  , x14 --> 0000000  01110  01100  000  01000  0110011
				  x1h = 32'd4 , // sub  x10, x12  , x11 --> 0100000  01011  01100  000  01010  0110011
				  x2h = 32'd8 , // addi x15, x1   , -50 -->  111111001110   00001  000  01111  0010011
				  x3h = 32'd12, // lw   x14, 8(x2) 	 	-->  000000001000   00010  010  01110  0000011
				  x4h = 32'd16, // sw   x14, 8(x2)      -->  000000001110   00010  010  01000  0100011
				  x5h = 32'd20; // beq  x19, x10 ,offset--> 0 000000 01010  10011  000 1000 0  1100011

always @(PC) begin
	case(PC[31:0])
		x0h: begin
			inst = 32'b00000000111001100000010000110011;
		end
		x1h: begin
			inst = 32'b01000000101101100000010100110011;
		end
		x2h: begin
			inst = 32'b11111100111000001000011110010011;
		end
		x3h: begin
			inst = 32'b00000000100000010010011100000011;
		end
		x4h: begin
			inst = 32'b00000000111000010010010000100011;
		end
		x5h: begin
			inst = 32'b00000000101010011000100001100011;
		end
	endcase
end

endmodule