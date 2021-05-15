/*  
    © Copyright by Pham Ngoc Lam
    			   Nguyen Van Chien
    			   Duong Van Bien
    Hanoi University of Science and Technology
    School of Electronic and Telecommunication
    EDABK Laboratory, 611 Ta Quan Buu Library
*/
module top_datapath(
	input 				clk	  ,
	input 				rst_n ,
	input 				PCSel ,
	input 		[2 :0]	ImmSel,
	input 				RegWEn,
	input 				BrUn  ,
	input 				BSel  ,
	input 				ASel  ,
	input 				MemRW ,
	input 		[1 :0]	WBSel ,
	output reg  [31:0]  inst  
	);

wire [31:0]	PC    	;
wire [31:0] alu 	;
wire [31:0] Imm 	;
wire [31:0] DataA 	;
wire [31:0] DataB	;
wire [31:0] DataD	;
wire [31:0] add 	;
wire [31:0] inst_tmp;
wire 		BrEq 	;
wire		BrLT 	;

assign inst = inst_tmp;

PC PC1(
	.clk  	(clk  	),
	.rst_n	(rst_n	),
	.alu  	(alu  	),
	.PCSel	(PCSel	),
	.PC   	(PC   	)
	);

IMEM IMEM1(
	.PC		(PC		),
	.inst	(inst_tmp)
	);

ImmGen ImmGen1(
	.inst  	(inst_tmp),
	.ImmSel	(ImmSel	 ),
	.Imm   	(Imm   	 )
	);

REG REG1(
	.clk   	(clk   	 ),	
	.rst_n 	(rst_n 	 ),	
	.DataD 	(DataD 	 ),
	.inst 	(inst_tmp),	
	.RegWEn	(RegWEn	 ),	
	.DataA 	(DataA 	 ),
	.DataB 	(DataB 	 )
	);

BranchComp BranchComp1(
	.DataA 	(DataA 		),
	.DataB 	(DataB 		),
	.PC    	(PC    		),
	.Imm   	(Imm   		),
	.BrUn  	(BrUn  		),
	.BSel  	(BSel  		),
	.ASel  	(ASel  		),
	.inst	(inst_tmp	),
	.BrEq  	(BrEq  		),
	.BrLT  	(BrLT  		),
	.alu   	(alu   		)
	);

DMEM DMEM1(
	.clk  	(clk  	),
	.rst_n	(rst_n	),
	.DataW	(DataB	),
	.alu  	(alu  	),
	.PC  	(PC  	),
	.MemRW	(MemRW	),
	.WBSel	(WBSel	),
	.DataD	(DataD	)
	);

endmodule