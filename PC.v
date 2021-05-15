/*  
    © Copyright by Pham Ngoc Lam
    			   Nguyen Van Chien
    			   Duong Van Bien
    Hanoi University of Science and Technology
    School of Electronic and Telecommunication
    EDABK Laboratory, 611 Ta Quan Buu Library
*/
module PC(
	input			  clk   ,
	input 			  rst_n ,
	input 	   [31:0] alu   ,
	input 			  PCSel ,
	output reg [31:0] PC    
	);

wire [31:0] PCnext;
wire [31:0] add	  ;
assign add = PC +3'b100;
assign PCnext = (PCSel) ? alu : add; 
always @(posedge clk or negedge rst_n) begin
	if (~rst_n) begin
		PC <= 0;
	end
	else begin
		repeat (2) @(posedge clk);
		PC <= PCnext;
	end	
end
endmodule