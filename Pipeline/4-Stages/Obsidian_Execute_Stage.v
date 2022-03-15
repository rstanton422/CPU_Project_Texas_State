module Obsidian_Execute_Stage(EX_MEM, ID_EX, clk);
	output reg [106:0] EX_MEM;	//EX_MEM[106] RegWrite
								//EX_MEM[105] MemtoReg
								//EX_MEM[104] Branch
								//EX_MEM[103] MemRead
								//EX_MEM[102] MemWrite
								//EX_MEM[101:70] Branch prediction (?)
								//EX_MEM[69] Zero detection
								//EX_MEM[68:37] Result from ALU
								//EX_MEM[36:5] passing data from addres Rn
								//EX_MEM[4:0] destination address from instruction R[d]
	input [156:0] ID_EX;	//ID_EX[156] RegWrite line
							//ID_EX[155] MemtoReg
							//ID_EX[154] Branch
							//ID_EX[153] MemRead
							//ID_EX[152] MemWrite
							//ID_EX[151] AlUop1
							//ID_EX[150] ALUop0
							//ID_EX[149] ALUSrc
							//ID_EX[148:117] PC value used for calculating Branch address
							//ID_EX[116:85] data from address R[n]
							//ID_EX[84:53] data from address R[m]
							//ID_EX[52:21] sign-extension (going to redesign it to accomodate our needs for now
							// 			   and not follow the book)
							//ID_EX[20:10] instruction for ALU
							//ID_EX[9:5] shift amount for shifter (not included in book diagram)
							//ID_EX[4:0] destination address R[d] or R[t]
	input clk;
	
	
	always @ (posedge clk)
	begin
		EX_MEM[106:102] = ID_EX[156:152];	//all Write Back and Mem Access signals being passed
		EX_MEM[36:5] = ID_EX[84:53]; 		//pass/latch the value from R[m] for data address to access
											//data memory
		EX_MEM[4:0] = ID_EX[4:0]; 			//pass/latch the destination address from instruction
	end
	

	//-------------------------------------------
	//ALU CONTROL
	parameter
		ADD = 4'b0000,
		SUB = 4'b0001,
		OR  = 4'b0010,
		XOR = 4'b0011,
		LSL = 4'b0100,
		LSR = 4'b0101,
		SAL = 4'b0110,
		SAR = 4'b0101,
		AND = 4'b1000;
		
	//OBSIDIAN ALU
	//-------------------------------------------
	reg [3:0] alu_control;
	
	obsidian_alu totalALU(
		.c(alu_out),
		.a(ID_EX[116:85]),
		.b(rm_choice),
		.alu_control(alu_control),
		.shamt(ID_EX[9:5])
	);
	
	wire [31:0] alu_out;
	
	always @ (posedge clk)
	begin
		EX_MEM[68:37] <= alu_out;
	end
	//-------------------------------------------
	
	always @ (posedge clk)
	begin
		// case(ID_EX[20:10])
		// 11'b10001011000:begin		//ADD
				// case(ID_EX[151:150])
				// 2'b10:begin
				// alu_control <= ADD;
				// end
				// endcase
			// end
		
		case(ID_EX[151:150])
		2'b10:begin
			case(ID_EX[20:10])
				11'h450:begin
				alu_control <= AND;
				end
			endcase
			end
			
		2'b00:begin
			casex(ID_EX[20:10])
				11'hX:begin
				alu_control <= ADD;
				end
			endcase
			end
		
		// 11'b11001011000:begin		//SUB
				// case(ID_EX[151:150])
				// 2'b10:begin
				// alu_control <= SUB;
				// end
				// endcase
			// end
			
		// 11'b10001010000:begin		//AND
				// case(ID_EX[151:150])		
				// 2'b10:begin
				// alu_control <= AND;
				// end
				// endcase
			// end
		
		// 11'b10101010000:begin		//OR
				// case(ID_EX[151:150])
				// 2'b10:begin
				// alu_control <= OR;
				// end
				// endcase
			// end
			
		// 11'b11001010000:begin
				// case(ID_EX[151:150])
				// 2'b10:begin
				// alu_control <= XOR;
				// end
				// endcase
			// end
			
		// 11'b11010011010:begin		//LSR
				// case(ID_EX[151:150])
				// 2'b10:begin
				// alu_control <= LSR;
				// end
				// endcase
			// end
			
		// 11'b11010011011:begin		//LSL
				// case(ID_EX[151:150])
				// 2'b10:begin
				// alu_control <= LSL;
				// end
				// endcase
			// end
		endcase
	end
	
	//ADDS BRANCH PLUS SIGN_EXT SHIFTED 2 FOR PREDICTION
	always @ (posedge clk)
	begin
		EX_MEM[101:70] <= ID_EX[148:117] + (ID_EX [52:21] << 2'b10);
		$display("EX_MEM = %b", EX_MEM[101:70]);
		$display("ID_EX = %b",ID_EX[52:21]);
		$display("ID_EX shifted = %b", ID_EX[52:21] << 2'b10);
	end
	
	
	//*****HAVING ISSSUES WITH CLOCK ON SIMULATION
	//*****WILL NEED TO REVISIT WHEN COMBINING STAGES
	//-------------------------------------------
	//Choosing between R[m] or Sign Extension for Source to ALU
	reg [31:0] rm_choice;
	
	always @ (*)
	begin
		if(ID_EX[149] == 0)		//chooses R[m]
		begin
			rm_choice = ID_EX[84:53];
		end
		if(ID_EX[149] == 1)		//chooses SIGN_EXT
		begin
			rm_choice = ID_EX[52:21];
		end
	end
		
endmodule		