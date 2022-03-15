module Obsidian_WriteBack_Stage( WB_ID, MEM_WB, clk);
	output reg [37:0] WB_ID;	//WB_ID[37] RegWrite
								//WB_ID[36:5] latch for word muxed from either memory or passed through by ALU
								//WB_ID[4:0] latch for address destination from original instruction
	input [70:0] MEM_WB;		//The register bank that is the output from the previous stage
								//MEM_WB[70] RegWrite
								//MEM_WB[69] MemtoReg
								//MEM_WB[68:37] latch for the word coming from memory
								//MEM_WB[36:5] latch for word coming from ALU
								//MEM_WB[4:0] latch for address destination from original instruction
	input clk;					//clock enabling the latching and releasing of data from stage to stage
	
	always @ (posedge clk)
	begin
		WB_ID[37] <= MEM_WB[70]; 	//Write back enable line
		WB_ID[4:0] <= MEM_WB[4:0]; 	//this is the address select for the writeback
									//from the original instruction passed through
	end
	
	always @ (posedge clk)
	begin
		if(MEM_WB[69] == 1)
		begin
			WB_ID[36:5] <= MEM_WB[68:37];	//will latch/pass the word coming from memory
		end
		if(MEM_WB[69] == 0)
		begin
			WB_ID[36:5] <= MEM_WB[36:5];	//will latch/pass the word coming from ALU
		end
	end
	
endmodule