//`timescale 1ns/1ps
module ALU_tb;
    reg [31:0] A_in; 
    reg [31:0] B_in; 
    reg cin;
    reg [3:0] select; 
    reg [4:0] shift;
	
    wire [31:0] ALU_out; 
    wire cout;
	
	Obsidian_ALU obsidian_alu(
                .a(A_in),
		.b(B_in),
		.alu_control(select),
		.shamt(shift),
		.c(ALU_out)
		);
	integer i;
	
/* 	reg [31:0] DataFIFOA [0:9];
	
	initial
		begin
			$readmemh("ALU_A_in_test.dat")
	 */
		
	//select = 4'b0000 -- ADD
	//select = 4'b0001 -- SUB
	//select = 4'b0010 -- OR
	//select = 4'b0011 -- XOR
	//select = 4'b0100 -- SLL
	//select = 4'b0101 -- SLR
	//select = 4'b0110 -- SAL
	//select = 4'b0101 -- SAR
	//select = 4'b1000 -- AND
	
	initial
		begin
			$monitor($time,,"A = %h, B = %h, select = %b, shift = %b  Output = %h", A_in, B_in, select, shift, ALU_out);

			shift = 5'b00011;

			
			//#0 select = 2'b11;
			#10 A_in = 32'h0000_bcdf; B_in = 32'h0000_354f;
			for(i = 0; i <= 8; i = i + 1)
				begin
					#5 select = i;

				end
		end	
			
endmodule
