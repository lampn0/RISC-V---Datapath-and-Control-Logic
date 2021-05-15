/*  
    © Copyright by Pham Ngoc Lam
    			   Nguyen Van Chien
    			   Duong Van Bien
    Hanoi University of Science and Technology
    School of Electronic and Telecommunication
    EDABK Laboratory, 611 Ta Quan Buu Library
*/
module REG(
	input 			  clk   ,
	input 			  rst_n ,
	input      [31:0] DataD ,
	input      [31:0] inst  ,
	input 			  RegWEn,
	output reg [31:0] DataA ,
	output reg [31:0] DataB
	);

reg [31:0] register_x [0:31];
reg [4:0] i;
initial begin
	for (i = 0; i < 5'd30; i = i + 1) begin
		register_x [i] = i;
	end
end

always @(posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		DataA <= 32'b0;
		DataB <= 32'b0;
	end
	else begin
		DataA <= register_x[inst[19:15]];
		DataB <= register_x[inst[24:20]];
		//repeat (1) @(posedge clk);
		if (RegWEn) begin
			register_x[inst[11:7]] <= DataD;
		end
	end
end
endmodule