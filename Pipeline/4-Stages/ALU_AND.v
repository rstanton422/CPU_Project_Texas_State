`timescale 1ns/1ps
// 2 input AND gate for the ALU 
//(output,input)
module ALU_AND (and_bit,a,b);
	
  output [31:0] and_bit;
  input [31:0] a, b;

  assign and_bit = (a & b);
	
endmodule