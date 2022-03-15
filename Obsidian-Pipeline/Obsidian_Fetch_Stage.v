//will need to account for branching still

module Obsidian_Fetch_Stage(IF_ID, clk);
	output reg[63:0] IF_ID;
	input clk;
	
	reg[31:0] PC; 	//address selection for 2^32 address in Instruction Memory
	
	//--------------------------------------
	//Temporary Instruction Register
	//Used as a place holder for now
	//--------------------------------------
	
	reg [31:0] instrMem [0:64];
	
	initial
		begin
		instrMem[0] = {11'h458, 5'b00001, 6'b000000, 5'b00000, 5'b00011};
		instrMem[1] = 32'h0000_0000;
		//instrMem[2] = 32'haaaa_aaaa;
		end
	//--------------------------------------
	
	
	initial
		begin
		PC = 0;
		end
		
	always @ (posedge clk)
	begin
		IF_ID[63:32] = PC;
		IF_ID[31:0] <= instrMem[PC];		//populate IF_ID register with instruction from
										//instruction memory using PC as address location
		PC = PC + 1;					//counts up one address place because memory is 1 word wide
	end
	
endmodule
