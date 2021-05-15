/*  
    © Copyright by Pham Ngoc Lam
    			   Nguyen Van Chien
    			   Duong Van Bien
    Hanoi University of Science and Technology
    School of Electronic and Telecommunication
    EDABK Laboratory, 611 Ta Quan Buu Library
*/
module DMEM(
	input			  clk  ,
	input			  rst_n,
	input 	   [31:0] DataW,
	input 	   [31:0] alu  ,
	input 	   [31:0] PC   ,
	input 			  MemRW, // 1 = read ; 0 = write
	input 	   [1 :0] WBSel,
	output reg [31:0] DataD
	);

reg [31:0] DataR_mem	 ;
reg [31:0] Memory [0:31] ;
reg [31:0] i;
initial begin
	for (i = 0; i <= 32'd32; i = i + 1) begin
		Memory [i] = i;
	end
end

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		DataD <= 0;
	end
	else begin
		if (MemRW) begin
			DataR_mem <= Memory[alu];
		end
		else begin
			Memory[alu] <= DataW;
		end
	end
end

always @(alu, WBSel, DataW, PC) begin
	repeat (1) @(negedge clk);
	case(WBSel)
		2'b00: DataD = DataR_mem	;
		2'b01: DataD = alu			;
		2'b10: DataD = PC + 3'b100 	;
	endcase 
end
endmodule