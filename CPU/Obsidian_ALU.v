//`timescale 1ns/1ps
module obsidian_alu (c, a, b, alu_control, shamt);

    input [31:0] a; 
    input [31:0] b; 
    input [3:0] alu_control; 
    input [4:0] shamt;
    
    output [31:0] c;

    wire [31:0] a, b;
    wire [3:0] alu_control;
    wire [4:0] shamt;	
    wire cout;
    
    reg [31:0] and_bit, or_bit, xor_bit, shifter;
    reg [31:0] sum;
    
    wire [31:0] f1, f2; // f stands for first column of wires referencing white board drawing. 
                        // f1 = add/sub output, f2 = or output, f3 = xor output.. etc
    wire [31:0] s1, s2; // "s" stands for second column of wires. output from mux's
    wire [31:0] t1, t2;
    wire [31:0] frth1, frth2;
   
      
 
    ALU_AND           alu_and (.and_bit(frth2), .a(a), .b(b));//Change around the input of the MUXs to coincide with the OPCODE
    ALU_OR            alu_or  (.or_bit(f1), .a(a), .b(b)); 
    ALU_XOR           alu_xor (.xor_bit(f2), .a(a), .b(b));
    barrel_shifter    b_shift (.sh(t2), .d(b), .sel(alu_control[1:0]), .sa(shamt));
    thirty_two_bit_fa full_adder (.sum(s1), .cout(cout), .x(a), .y(b), .cin(alu_control[0]));
    mux2x32           mux1    (.y(s2), .a(f1), .b(f2), .s(alu_control[0]));
    mux2x32           mux2    (.y(t1), .a(s1), .b(s2), .s(alu_control[1]));
    mux2x32           mux3    (.y(frth1), .a(t1), .b(t2), .s(alu_control[2]));
    mux2x32           mux4    (.y(c), .a(frth1), .b(frth2), .s(alu_control[3]));
	
endmodule
