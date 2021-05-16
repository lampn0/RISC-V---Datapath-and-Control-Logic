module tb ();
reg 								clk 				;    // Clock
reg 								clk_en 				; // Clock Enable
reg 								rst_n 				;  // Asynchronous reset active low
reg 	[31:0]						inst 				;
reg 								BrEq				;
reg 								BrLT 				;	
wire 								PCSel 				;
wire 	[2:0]						ImmSel 				;  
wire 								BrUn 				;
wire 								ASel 				; 		
wire 								BSel 				;
wire 	[3:0]						ALUSel 				;
wire 								MemRW  				;  
wire 								RegWEn 				;  
wire 	[1:0]						WBSel				;

control_logic C(
	.clk       			(clk)				,	
	.clk_en    			(clk_en)			,		
	.rst_n     			(rst_n)				,	
	.inst_30   			(inst[30])			,		
	.inst_14_12			(inst[14:12])		,			
	.inst_6_2  			(inst[6:2])			,
	.BrEq      			(BrEq)				,
	.BrLT      			(BrLT)				,
	.PCSel     			(PCSel)				,		
	.ImmSel    			(ImmSel)			,		
	.BrUn      			(BrUn)				,	
	.ASel      			(ASel)				,	
	.BSel      			(BSel)				,	
	.ALUSel    			(ALUSel)			,		
	.MemRW     			(MemRW)				,	
	.RegWEn    			(RegWEn)			,		
	.WBSel     			(WBSel)					
	);

initial		begin 
	clk 		= 		1		;
	clk_en 		= 		0		;
	rst_n		= 		1		;
	inst 		= 		32'b0000000111001100000010000110011;
end

always #10 clk = ~clk;
initial		begin 
	@(posedge clk);
	rst_n 		= 		0;
	clk_en 		=		1;
	@(posedge clk);
	rst_n 		=		1;
	if (~C.control_word_out==0) begin
		$stop;
	end
end

endmodule
