module Fetch_DEC_EXE_tb;
	reg clk;
	
	
	wire [63:0] IF_ID_wire;
	wire [156:0] ID_EX_wire;
	wire [106:0] EX_MEM_wire;
	wire [70:0] MEM_WB_wire;
	wire [37:0] WB_ID_wire;
	
	Obsidian_Fetch_Stage fetch(
	.IF_ID(IF_ID_wire),
	.clk(clk)
	);
	always @ (posedge clk)
	begin
	$display("IF_ID = %b", IF_ID_wire);
	end
	
	Obsidian_Decode_Stage decode(
	.ID_EX(ID_EX_wire),
	.IF_ID(IF_ID_wire),
	.WB_ID(WB_ID_wire),
	.clk(clk)
	);
	
	always @ (posedge clk)
	begin
	$display("ID_EX = %b", ID_EX_wire);
	end
	
	Obsidian_Execute_Stage exec(
	.EX_MEM(EX_MEM_wire),
	.ID_EX(ID_EX_wire),
	.clk(clk)
	);
	
	always @ (posedge clk)
	begin
	$display("EX_MEM = %b", EX_MEM_wire);
	end
	
	Obsidian_Memory_Stage mem(
	.MEM_WB(MEM_WB_wire),
	.EX_MEM(EX_MEM_wire),
	.clk(clk)
	);
	
	always @ (posedge clk)
	begin
	$display("MEM_WB = %b", MEM_WB_wire);
	end
	
	Obsidian_WriteBack_Stage write(
	.MEM_WB(MEM_WB_wire),
	.WB_ID(WB_ID_wire),
	.clk(clk)
	);
	
	always @ (posedge clk)
	begin
	$display("WB_ID = %b", WB_ID_wire);
	end
	
	initial
		begin
			clk = 0;
			forever begin
			#10 clk = ~clk;
			end
		end
	
	initial
		begin
		
		$dumpfile("5stages.vcd");
		$dumpvars(0, Fetch_DEC_EXE_tb);
		
		$monitor($time,,"Clock = %b	", clk);
		#180 $finish;
		end
	
endmodule
