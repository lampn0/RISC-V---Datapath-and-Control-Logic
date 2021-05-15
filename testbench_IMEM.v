/*  
    © Copyright by Pham Ngoc Lam
    			   Nguyen Van Chien
    			   Duong Van Bien
    Hanoi University of Science and Technology
    School of Electronic and Telecommunication
    EDABK Laboratory, 611 Ta Quan Buu Library
*/
`timescale 1ns/1ps
module testbench_IMEM();
reg  [31:0] PC  ;
wire [31:0] inst;

IMEM IMEM_test(
	.PC		(PC		),
	.inst	(inst	)
	);

initial begin
	PC = 32'b0;
end
endmodule