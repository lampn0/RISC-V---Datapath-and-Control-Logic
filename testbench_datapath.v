/*  
    © Copyright by Pham Ngoc Lam
    			   Nguyen Van Chien
    			   Duong Van Bien
    Hanoi University of Science and Technology
    School of Electronic and Telecommunication
    EDABK Laboratory, 611 Ta Quan Buu Library
*/
`timescale 1ns/1ps
module testbench_datapath();
reg			clk	  ;
reg			rst_n ;
reg			PCSel ;
reg	 [2 :0]	ImmSel;
reg			RegWEn;
reg			BrUn  ;
reg			BSel  ;
reg			ASel  ;
reg			MemRW ;
reg	 [1 :0]	WBSel ;

top_datapath dut(
	.clk	(clk	),
	.rst_n 	(rst_n 	),
	.PCSel 	(PCSel 	),
	.ImmSel	(ImmSel	),
	.RegWEn	(RegWEn	),
	.BrUn  	(BrUn  	),
	.BSel  	(BSel  	),
	.ASel  	(ASel  	),
	.MemRW 	(MemRW 	),
	.WBSel 	(WBSel 	)
	);

always #10 clk = ~clk;
initial begin
	clk	  	= 0;
	rst_n 	= 0;
    repeat (1) @(posedge clk);
    // test case add
	rst_n 	= 1;
	PCSel 	= 0;
	ImmSel	= 3'b000;
	RegWEn	= 1;
	BrUn  	= 0;
	BSel  	= 0;
	ASel  	= 0;
	MemRW 	= 1;
	WBSel 	= 2'b01;
	repeat (3) @(posedge clk);
	// test case sub
	PCSel 	= 0;
	ImmSel	= 3'b000;
	RegWEn	= 1;
	BrUn  	= 0;
	BSel  	= 0;
	ASel  	= 0;
	MemRW 	= 2'b01;
	WBSel 	= 2'b01;
	repeat (3) @(posedge clk);
	// test case addi
	PCSel 	= 0;
	ImmSel	= 3'b001;
	RegWEn	= 0;
	BrUn  	= 0;
	BSel  	= 1;
	ASel	= 0;
	MemRW 	= 1;
	WBSel 	= 2'b01;
	repeat (3) @(posedge clk);
	// test case lw
	PCSel 	= 0;
	ImmSel	= 3'b001;
	RegWEn	= 1;
	BrUn  	= 0;
	BSel  	= 1;
	ASel  	= 0;
	MemRW 	= 0;
	WBSel 	= 2'b0;
	repeat (3) @(posedge clk);
	// test case sw
	PCSel 	= 0;
	ImmSel	= 3'b10;
	RegWEn	= 0;
	BrUn  	= 0;
	BSel  	= 1;
	ASel  	= 0;
	MemRW 	= 0;
	WBSel 	= 2'b0;
	repeat (3) @(posedge clk);
	// test case beq not taken
	PCSel 	= 0;
	ImmSel	= 3'b011;
	RegWEn	= 0;
	BrUn  	= 0;
	BSel  	= 1;
	ASel  	= 1;
	MemRW 	= 1;
	WBSel 	= 2'b0;
end
endmodule