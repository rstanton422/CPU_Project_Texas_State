module Obsidian_Memory_Stage(MEM_WB, EX_MEM, clk);
	output reg [70:0] MEM_WB;	//MEM_WB[70] RegtoWrite
							//MEM_WB[69] MemtoReg
							//MEM_WB[68:37] Word/Instruction selected from Memory
							//MEM_WB[36:5] ALU result
							//MEM_WB[4:0] latch for address destination R[d] from original instruction
	input [106:0] EX_MEM;	//EX_MEM[106] RegWrite
	                        //EX_MEM[105] MemtoReg
	                        //EX_MEM[104] Branch
	                        //EX_MEM[103] MemRead
	                        //EX_MEM[102] MemWrite
	                        //EX_MEM[101:70] Branch prediction (?)
	                        //EX_MEM[69] Zero detection
	                        //EX_MEM[68:37] Result from ALU
	                        //EX_MEM[36:5] passing data from addres R[m]
	                        //EX_MEM[4:0] destination address from instruction R[d]
	
	input clk;				//clock enabling the latching and releasing of data from stage to stage
	
		
	always @ (posedge clk)
	begin
		MEM_WB[70:69] <= EX_MEM[106:105];	//Passing line that enables write to GPR and selects which
											//data to pass through from either memory or ALU result in 
											//write back stage
		MEM_WB[36:5] <= EX_MEM[68:37];		//ALU result
		MEM_WB[4:0] <= EX_MEM[4:0];			//destination address R[d] from instruction
	end
		
	reg [31:0] data_memory [0:1023];		//temporary place for memory structure to be implemented
	
	initial
	begin
		data_memory[0] = 32'hffff_ffff;
		data_memory[1] = 32'h0000_0000;
		data_memory[2] = 32'habcd_dcba;
		data_memory[3] = 32'h8765_4321;
		data_memory[29] = 32'h1111_1111;
		data_memory[30] = 32'h4321_8765;
		data_memory[31] = 32'hfedc_1234;
		data_memory[34] = 32'h8888_8888;
		data_memory[1023] = 32'hffff_ffff;
	end
	
	
	
	always @ (posedge clk)
	begin
		if(EX_MEM[103] == 1)		//reading word from memory
		begin
			MEM_WB[68:37] <= data_memory[EX_MEM[68:37]];
		end
		else if(EX_MEM[102] == 1)	//storing word to memory
		begin
			data_memory[EX_MEM[36:5]] <= EX_MEM[36:5];
			MEM_WB[68:37] <= data_memory[EX_MEM[36:5]];
		end
	end

		
	//Will need to edit this cache a bit to accomodate the input output
	// //of current module
	
	// reg [31:0] data_out;
	// wire [31:0] data_in;
	// wire read_write;
	// wire clk;

	// //Inside the module | internal ports
	// reg d_valid[0:999];         //1-bit valid 
	// reg [999:0] d_tags [0:15];  //16-bit tag 
	// reg [999:0] d_offset [0:4]; //5-bit offset
	// reg [999:0] d_data [0:31];  //32-bit data 

	// wire [31:0] c_din;                  //data to cache
	// wire [15:0] tag = data_in[31:16];   //address tag -- cpu address not correct psuedo numbers
	// wire [4:0] offset = data_in[15:10]; //bit offset
	// wire [8:0] index = data_in[9:1];    //block index -- cpu address not correct psuedo numbers

	// reg  [31:0] data_mem [0:999];

	// always @ (posedge clk & enable) begin
		// if(EX_MEM[103] == 0/* read_write == 0 */) begin  //read bit = 0 
		// data_out <= data_mem[index];
		// end
	// end
		// always @ (negedge clk & enable) begin
		// if(EX_MEM[103] == 1/* read_write == 1 */) begin  //write bit = 1
		// data_mem[index] <= data_in;
		// end
	// end
endmodule
	
