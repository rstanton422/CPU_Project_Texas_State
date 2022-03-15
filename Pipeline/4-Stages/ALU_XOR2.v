`timescale 1ns/1ps
// 2 Input XOR gate for the ALU
// (output, input)

module ALU_XOR (xor_bit,a,b);

  output [31:0] xor_bit;
  input [31:0] a,b;
	
  assign xor_bit = (a ^ b);
	
endmodule
