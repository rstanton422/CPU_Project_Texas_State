module stage4_pipeline_tb;
	wire [37:0] WB_ID;
	reg [63:0] IF_ID;
	reg clk;
	
	parameter 	Branch = 32'hffff_ffff,
	            opcode = 11'h7C2,
	            Rm = 5'b00010,
	            shamt = 6'b000001,
	            Rn = 5'b00001,
	            Rd = 5'b00100;
			
	top_mod DUT(
	WB_ID,
	IF_ID,
	clk
	);
	
	initial
		begin
			clk = 0;
		forever
			begin
				#10 clk = ~clk;
			end
		end
	
	initial
		begin
		
		$dumpfile("4_stages.vcd");
		$dumpvars(0, stage4_pipeline_tb);
		
		$monitor($time,,"Clock = %b, IF_ID = %b	|	WB_ID = %b", clk, IF_ID, WB_ID);
		#5 IF_ID = {Branch, opcode, Rm, shamt, Rn, Rd};
		#180 $finish;
		end
endmodule
	

module top_mod(WB_ID, IF_ID, clk);
	output [37:0] WB_ID;
	input [63:0] IF_ID;
	input clk;
	
	wire [70:0] MEM_WB_wire;
	wire [106:0] EX_MEM_wire;
	wire [156:0] ID_EX_wire;
	
	
	Obsidian_Decode_Stage DECst(
	.ID_EX(ID_EX_wire),
	.WB_ID(WB_ID),
	.IF_ID(IF_ID),
	.clk(clk)
	);
	
	
	Obsidian_Execute_Stage EXst(
	.EX_MEM(EX_MEM_wire),
	.ID_EX(ID_EX_wire),
	.clk(clk)
	);
	
	Obsidian_Memory_Stage MEMst(
	.MEM_WB(MEM_WB_wire),
	.EX_MEM(EX_MEM_wire),
	.clk(clk)
	);
	
	Obsidian_WriteBack_Stage WBst(
	.MEM_WB(MEM_WB_wire),
	.WB_ID(WB_ID),
	.clk(clk)
	);
	

	
endmodule
