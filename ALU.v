/*  
    © Copyright by Pham Ngoc Lam
    			   Nguyen Van Chien
    			   Duong Van Bien
    Hanoi University of Science and Technology
    School of Electronic and Telecommunication
    EDABK Laboratory, 611 Ta Quan Buu Library
*/
module ALU(
	input 	   [31:0] DataA	,
	input 	   [31:0] DataB	,
	input 	   [31:0] Imm	,
	input 	   [31:0] PC	,
	input 		 	  Bsel	,
	input 			  Asel  ,
	input 		 	  ALUSel,
	output reg [31:0] alu
	);

