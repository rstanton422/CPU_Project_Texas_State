// This is a module for a 32-bit 2-to-1 multiplexer
module mux2x32(a0, a1, s, y);

  // The input is 32 bits from 0 to 31.
  input [31:0] a0, a1;

  // This is the select pin.
  input s;

  output [31:0] y;
  assign y = s ? a1 : a0;

endmodule	
