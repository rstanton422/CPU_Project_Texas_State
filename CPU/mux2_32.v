`timescale 1ns/1ps
module mux2x32 (a, b, s, y);
    
    input [31:0] a, b; 
    input s;
    output [31:0] y;

    assign y = s ? b : a; 
 
endmodule   
