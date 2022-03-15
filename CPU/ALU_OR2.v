`timescale 1ns/1ps
// 2 Input OR gate for the ALU
// (output,input)

module ALU_OR (or_bit,a,b);

  output [31:0] or_bit;
  input [31:0] a,b;
	
  assign or_bit = (a|b);
	
endmodule