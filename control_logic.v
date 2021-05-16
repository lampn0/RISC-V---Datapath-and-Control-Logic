module control_logic (
	input 								clk 				,    // Clock
	input 								clk_en 				, // Clock Enable
	input 								rst_n 				,  // Asynchronous reset active low
	input								inst_30 			,
	input	[2:0]						inst_14_12 			,
	input	[4:0]						inst_6_2 			,
	input								BrEq				,
	input								BrLT				,
	output 								PCSel 				,
	output 	[2:0]						ImmSel 				,  
	output 								BrUn 				,
	output 								ASel 				, 		
	output 								BSel 				,
	output 	[3:0]						ALUSel 				,
	output 								MemRW  				,  
	output 								RegWEn 				,  
	output 	[1:0]						WBSel

);
parameter							LUI		 = 0			,
									AUIPC	 = 1			,
									JAL		 = 2			,
									JALR	 = 3			,
									BEQ		 = 4			,
									BNE		 = 5			,
									BLT		 = 6			,
									BGE 	 = 7			,
									BLTU	 = 8			,
									BGEU     = 9			,
									LB     	 = 10			,
									LH       = 11			,
									LW    	 = 12			,
									LBU   	 = 13			,
									LHU   	 = 14			,
									SB    	 = 15			,
									SH    	 = 16			,
									SW    	 = 17			,
									ADDI   	 = 18			,
									SLTI   	 = 19			,
									SLTIU  	 = 20			,
									XORI  	 = 21			,
									ORI    	 = 22			,
									ANDI   	 = 23			,
									SLLI   	 = 24			,
									SRLI  	 = 25			,
									SRAI  	 = 26			,
									ADD    	 = 27			,
									SUB    	 = 28			,
									SLL      = 29			,
									SLT    	 = 30			,
									SLTU   	 = 31			,
									XOR    	 = 32			,
									SRL      = 33			,
									SRA    	 = 34			,
									OR     	 = 35			,
									AND    	 = 36			,
									FENCE    = 37			,
									ECALL    = 38			,
									EBREAK   = 39			;
initial		begin 
	$readmemb("ControlROM.txt",control_word);
end

reg		[14:0]				control_word[0:39]				;
reg		[14:0]				control_word_out				;

assign 	PCSel						= control_word_out[14]					;
assign 	ImmSel						= control_word_out[13:11] 				;
assign 	BrUn						= control_word_out[10]					;
assign 	ASel 						= control_word_out[9] 					;
assign 	BSel 						= control_word_out[8]					;
assign 	ALUSel						= control_word_out[7:4]					;
assign 	MemRW						= control_word_out[3]  					;
assign 	RegWEn						= control_word_out[2]					;
assign 	WBSel						= control_word_out[1:0]					;


always @(posedge clk or negedge rst_n) begin : proc_isa
	if(~rst_n) begin
		control_word_out <= 15'b0;
	end else if(clk_en) begin
		case ({inst_30, inst_14_12, inst_6_2})
			9'b000001101: control_word_out <= control_word[LUI]  		;				
			9'b000000101: control_word_out <= control_word[AUIPC]  		;
			9'b000011011: control_word_out <= control_word[JAL]  		;
			9'b000011001: control_word_out <= control_word[JALR]  		;
			9'b000011000: begin 
				if (BrEq) begin
					control_word_out <= control_word[BEQ];
				end else begin 
					control_word_out <= control_word[BEQ] - 15'b100000000000000;
				end
			end
			9'b000111000: begin 
				if (BrEq) begin
					control_word_out <= control_word[BNE ] - 15'b100000000000000;	
				end else begin 
					control_word_out <= control_word[BNE ];
				end
			end 
			9'b010011000:
				if (BrLT) begin
					control_word_out <= control_word[BLT ] ;	
				end else begin 
					control_word_out <= control_word[BLT ] - 15'b100000000000000;
				end
			9'b010111000: control_word_out <= control_word[BGE ] ;
			9'b011011000:
				if (BrLT) begin
					control_word_out <= control_word[BLTU ] ;	
				end else begin 
					control_word_out <= control_word[BLTU ] - 15'b100000000000000;
				end
			9'b011111000: control_word_out <= control_word[BGEU  ] ;
			9'b000000000: control_word_out <= control_word[LB    ] ;
			9'b000100000: control_word_out <= control_word[LH    ] ;
			9'b001000000: control_word_out <= control_word[LW    ] ;
			9'b010000000: control_word_out <= control_word[LBU   ] ;
			9'b010100000: control_word_out <= control_word[LHU   ] ;
			9'b000001000: control_word_out <= control_word[SB    ] ;
			9'b000101000: control_word_out <= control_word[SH    ] ;
			9'b001001000: control_word_out <= control_word[SW    ] ;
			9'b000000100: control_word_out <= control_word[ADDI  ] ;
			9'b001000100: control_word_out <= control_word[SLTI  ] ;
			9'b001100100: control_word_out <= control_word[SLTIU ] ;
			9'b010000100: control_word_out <= control_word[XORI  ] ;
			9'b011000100: control_word_out <= control_word[ORI   ] ;
			9'b011100100: control_word_out <= control_word[ANDI  ] ;
			9'b000100100: control_word_out <= control_word[SLLI  ] ;
			9'b010100100: control_word_out <= control_word[SRLI  ] ;
			9'b110100100: control_word_out <= control_word[SRAI  ] ;
			9'b000001100: control_word_out <= control_word[ADD   ] ;
			9'b100001100: control_word_out <= control_word[SUB   ] ;
			9'b000101100: control_word_out <= control_word[SLL   ] ;
			9'b001001100: control_word_out <= control_word[SLT   ] ;
			9'b001101100: control_word_out <= control_word[SLTU  ] ;
			9'b010001100: control_word_out <= control_word[XOR   ] ;	
			9'b010101100: control_word_out <= control_word[SRL   ] ;
			9'b110101100: control_word_out <= control_word[SRA   ] ;			
			9'b011001100: control_word_out <= control_word[OR    ] ;	
			9'b011101100: control_word_out <= control_word[AND   ] ;
			9'b000000011: control_word_out <= control_word[FENCE ] ;
			9'b000011100: control_word_out <= control_word[ECALL ] ;
			9'b000011100: control_word_out <= control_word[EBREAK] ;
			default : control_word_out <= 15'b0;
		endcase
	end
end

endmodule
