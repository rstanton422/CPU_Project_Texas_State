module Obsidian_Decode_Stage(ID_EX, IF_ID, WB_ID, clk);
	output reg [156:0] ID_EX;	//ID_EX[156] RegWrite line
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
	input [63:0]IF_ID;		//This will be the 32-bit instruction coming into the Decode Stage
							//along with passing the branch addition value
                            
    input [37:0] WB_ID;         // WB_ID[37]    RegWrite 
                                // WB_ID[36:5]  Data
                                // WB_ID[4:0]   Write address

    
	input clk;
	
	
	//----------------------------------------------------------
	//GENERAL PURPOSE REGISTER
	reg [31:0] GPR [0:30];
	
	initial
		begin
		GPR[0] = 32'h0000_0001;
		GPR[1] = 32'h0000_0002;
		GPR[2] = 32'h0000_0003;
		end
	
	always @ (posedge clk)
	begin
		ID_EX[116:85] <= (IF_ID[9:5] == 31) ? 0 : GPR[IF_ID[9:5]];   //R[n] (Read Register 1)
		ID_EX[84:53] <= (IF_ID[20:16] == 31) ? 0 : GPR[IF_ID[20:16]];	//R[m] (Read Register 2)
		
		//Reg2Loc is IF_ID[28] for determining D and CB commands
        // if (IF_ID[28] == 0)  
        // begin                                
            // ID_EX[84:53] <= (IF_ID[20:16] == 31) ? 0 : GPR[IF_ID[20:16]];	//R[m] (Read Register 2)
        // end
        // if(IF_ID[28] == 1)
		// begin
            // ID_EX[84:53] <= (IF_ID[20:16] == 31) ? 0 : GPR[IF_ID[4:0]];     //R[t] 
        // end
        
	end
	//----------------------------------------------------------
	
	
	//----------------------------------------------------------
	//GPR WRITE BACK FROM WRITEBACK Stage
	always @ (posedge clk)
	begin
        if (WB_ID[37] == 1)
		begin																
            GPR[WB_ID[4:0]] <= WB_ID[36:5];
			$display("GPR is %b", GPR[WB_ID[4:0]]);
		end
	end
	//----------------------------------------------------------
	
	

	
	//----------------------------------------------------------
	//CONTROL UNIT
	//This will determine the control settings for the 8 MSB in ID_EX
	always @ (posedge clk)
	begin
		//*****R-TYPE COMMANDS********************
		casex(IF_ID[31:21])
			11'h450:begin					//AND
			ID_EX[156:155] <= 2'b10; 		//RegWrite is HIGH - MemtoReg is LOW														
			ID_EX[154:152] <= 3'b000;		//Branch is LOW - MemRead is LOW - MemWrite is LOW														
			ID_EX[151:149] <= 3'b100;		//ALUop1 is HIGH - ALUop0 is LOW - ALUSrc is LOW														
			end
	
			11'h458:begin					//ADD
			ID_EX[156:155] <= 2'b10; 		//RegWrite is HIGH - MemtoReg is LOW												
			ID_EX[154:152] <= 3'b000;		//Branch is LOW - MemRead is LOW - MemWrite is LOW												
			ID_EX[151:149] <= 3'b100;		//ALUop1 is HIGH - ALUop0 is LOW - ALUSrc is LOW												
			end
			
			11'h550:begin					//ORR
			ID_EX[156:155] <= 2'b10; 		//RegWrite is HIGH - MemtoReg is LOW															
			ID_EX[154:152] <= 3'b000;		//Branch is LOW - MemRead is LOW - MemWrite is LOW															 
			ID_EX[151:149] <= 3'b100;		//ALUop1 is HIGH - ALUop0 is LOW - ALUSrc is LOW															
			end

			11'h558:begin					//ADDS
			ID_EX[156:155] <= 2'b10;		//RegWrite is HIGH - MemtoReg is LOW
			ID_EX[154:152] <= 3'b000;		//Branch is LOW - MemRead is LOW - MemWrite is LOW
			ID_EX[151:149] <= 3'b100;		//ALUop1 is HIGH - ALUop0 is LOW - ALUSrc is LOW
			end
			
			11'h5E0:begin					//STURS - Store Word
			ID_EX[156:155] <= 2'b1X;		//RegWrite is HIGH - MemtoReg is DON'T CARE as this is a store command
			ID_EX[154:152] <= 3'b001;		//Branch is LOW - MemRead is low - MemWrite is HIGH
			ID_EX[151:149] <= 3'b001;		//ALUop1 is LOW - ALUop0 is LOW - ALUSrc is HIGH
			end
			
			11'h5E2:begin					//LDURS - Load Word
			ID_EX[156:155] <= 2'b11;		//RegWrite is HIGH - MemtoReg is HIGH
			ID_EX[154:152] <= 3'b010;		//Branch is LOW - MemRead is HIGH - MemWrite is LOW
			ID_EX[151:149] <= 3'b001;		//ALUop1 is LOW - ALUop0 is LOW - ALUSrc is HIGH
			end
			
			11'h650:begin					//EOR (XOR) - Exclusive
			ID_EX[156:155] <= 2'b10;  		//RegWrite is HIGH - MemtoReg is LOW													
			ID_EX[154:152] <= 3'b000; 		//Branch is LOW - MemRead is LOW - MemWrite is LOW													 
			ID_EX[151:149] <= 3'b100; 		//ALUop1 is HIGH - ALUop0 is LOW - ALUSrc is LOW													 
			end
					
			11'h658:begin					//SUB - Subtract
			ID_EX[156:155] <= 2'b10;  		//RegWrite is HIGH - MemtoReg is LOW				
			ID_EX[154:152] <= 3'b000; 		//Branch is LOW - MemRead is LOW - MemWrite is LOW
			ID_EX[151:149] <= 3'b100; 		//ALUop1 is HIGH - ALUop0 is LOW - ALUSrc is LOW	
			end
			
			11'h69A:begin					//LSR - Logic Shift Right
			ID_EX[156:155] <= 2'b10;  		//RegWrite is HIGH - MemtoReg is LOW				
			ID_EX[154:152] <= 3'b000; 		//Branch is LOW - MemRead is LOW - MemWrite is LOW
			ID_EX[151:149] <= 3'b100; 		//ALUop1 is HIGH - ALUop0 is LOW - ALUSrc is LOW	
			end
			
			11'h69B:begin					//LSL - Logic Shift Left
			ID_EX[156:155] <= 2'b10;  		//RegWrite is HIGH - MemtoReg is LOW				
			ID_EX[154:152] <= 3'b000; 		//Branch is LOW - MemRead is LOW - MemWrite is LOW
			ID_EX[151:149] <= 3'b100; 		//ALUop1 is HIGH - ALUop0 is LOW - ALUSrc is LOW	
			end
			
			11'h6B0:begin					//BR - Branch to Register
			ID_EX[156:155] <= 2'b10;  		//RegWrite is HIGH - MemtoReg is LOW				
			ID_EX[154:152] <= 3'b000; 		//Branch is LOW - MemRead is LOW - MemWrite is LOW
			ID_EX[151:149] <= 3'b100; 		//ALUop1 is HIGH - ALUop0 is LOW - ALUSrc is LOW	
			end
			
			11'h750:begin					//ANDS
			ID_EX[156:155] <= 2'b10;  		//RegWrite is HIGH - MemtoReg is LOW				
			ID_EX[154:152] <= 3'b000; 		//Branch is LOW - MemRead is LOW - MemWrite is LOW
			ID_EX[151:149] <= 3'b100; 		//ALUop1 is HIGH - ALUop0 is LOW - ALUSrc is LOW	
			end
			
			11'h758:begin					//SUBS
			ID_EX[156:155] <= 2'b10;  		//RegWrite is HIGH - MemtoReg is LOW				
			ID_EX[154:152] <= 3'b000; 		//Branch is LOW - MemRead is LOW - MemWrite is LOW
			ID_EX[151:149] <= 3'b100; 		//ALUop1 is HIGH - ALUop0 is LOW - ALUSrc is LOW	
			end
			
			11'h7E0:begin					//STURD
			ID_EX[156:155] <= 2'b1X; 		//RegWrite is HIGH - MemtoReg is DON'T CARE as this is a store command
			ID_EX[154:152] <= 3'b001; 		//Branch is LOW - MemRead is low - MemWrite is HIGH
			ID_EX[151:149] <= 3'b001; 		//ALUop1 is LOW - ALUop0 is LOW - ALUSrc is HIGH
			end
			
			11'h7E2:begin					//LDURD
			ID_EX[156:155] <= 2'b11;		//RegWrite is HIGH - MemtoReg is HIGH
			ID_EX[154:152] <= 3'b010; 		//Branch is LOW - MemRead is HIGH - MemWrite is LOW
			ID_EX[151:149] <= 3'b001; 		//ALUop1 is LOW - ALUop0 is LOW - ALUSrc is HIGH
			end
			
		//*****I-TYPE COMMANDS********************
			// 11'h488:begin
			// 11'h489:begin
			
		//*****D-TYPE COMMANDS********************
			11'h7C0:begin					//STUR
			ID_EX[156:155] <= 2'b0X;		//RegWrite is LOW - MemtoReg is DON'T CARE
			ID_EX[154:152] <= 3'b001;		//Branch is LOW - MemRead is LOW - MemWrite is HIGH
			ID_EX[151:149] <= 3'b001;		//ALUop1 is LOW - ALUop0 is LOW - ALUSrc is HIGH
			end
			
			11'h7C2:begin					//LDUR
			ID_EX[156:155] <= 2'b11;		//RegWrite is LOW - MemtoReg is HIGH
			ID_EX[154:152] <= 3'b010;		//Branch is LOW - MemRead is HIGH - MemWrite is LOW
			ID_EX[151:149] <= 3'b001;		//ALUop1 is LOW - ALUop0 is LOW - ALUSrc is HIGH
			end
		endcase
	end
	
	//SIGN EXTENSION
	//----------------------------------------------------------
	always @ (posedge clk)
	begin
		ID_EX[52:21] <= {{20{IF_ID[21]}}, IF_ID[21:10]};	//this is extending the sign associated 
	end														//with the MSB ID_EX[21]
															
	
	//----------------------------------------------------------	
	

	//BITS THAT JUST NEEED TO BE PASSED
	//----------------------------------------------------------
	always @ (posedge clk)
	begin
		ID_EX[148:117] <= IF_ID[63:32]; //passing the value needed for branch calculation
		ID_EX[20:10] <= IF_ID[31:21];	//opcode for ALU control
		ID_EX[9:5] <= IF_ID[15:10];		//shift amount being passed
		ID_EX[4:0] <= IF_ID[4:0];		//Destination Address
	end
	
	
	
	
	
	
endmodule