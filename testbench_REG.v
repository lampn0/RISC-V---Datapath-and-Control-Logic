/*  
    © Copyright by Pham Ngoc Lam
    			   Nguyen Van Chien
    			   Duong Van Bien
    Hanoi University of Science and Technology
    School of Electronic and Telecommunication
    EDABK Laboratory, 611 Ta Quan Buu Library
*/

`timescale 1ns/1ps
module testbench_REG();
reg			clk	  ;
reg			rst_n ;
reg  [31:0]	DataD ;
reg  [31:0]	inst  ;
reg 		RegWEn;
wire [31:0] DataA ;
wire [31:0] DataB ;

REG REG_test(
	.clk   	(clk	),
	.rst_n 	(rst_n 	),
	.DataD 	(DataD 	),
	.inst  	(inst  	),
	.RegWEn	(RegWEn	),
	.DataA 	(DataA 	),
	.DataB 	(DataB 	)
	);

always #10 clk = ~clk;
initial begin
	clk	  	= 0;
	rst_n 	= 0;
    #10
	rst_n 	= 1;
	DataD	= 100;
	inst	= 32'b00000000111001100000010000110011;
	RegWEn	= 1;
end
endmodule