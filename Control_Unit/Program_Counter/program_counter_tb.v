module program_counter_tb;

  reg clk;
  reg [31:0] PC_in;
  wire [31:0] PC_out;
 
  program_counter PC(.PC_in(PC_in),
                     .PC_out(PC_out),
                     .clk(clk));
 
  always 
    
  #10 clk = ~clk;

  initial begin
    $monitor ($time,,, "PC_in = %h | PC_out = %h | clk = %b", PC_in, PC_out, clk);
    #0 clk  = 0;
    #50 PC_in =  32'h 0000_0000;
    #50 PC_in = 32'h 0000_0004;
    #50 PC_in = 32'h 0000_0008;
    #50 PC_in = 32'h 0000_000C;
    #50 PC_in =  32'h 0000_0010;

    #50 PC_in = 32'h 0000_0014;
    #50 PC_in = 32'h 0000_0018;
    #50 PC_in = 32'h 0000_001C;
    #50 PC_in =  32'h 0000_0020;
    #50 PC_in = 32'h 0000_0024;
    #50 PC_in = 32'h 0000_0028;
    #50 PC_in = 32'h 0000_002C;

    #50 PC_in =  32'h 0000_0030;
    #50 PC_in = 32'h 0000_0034;
    #50 PC_in = 32'h 0000_0038;
    #50 PC_in = 32'h 0000_003C;
    #50 PC_in =  32'h 0000_0040;
    #50 PC_in = 32'h 0000_0044;
    #50 PC_in = 32'h 0000_0048;
    #50 PC_in = 32'h 0000_004C;
    #50 PC_in =  32'h 0000_0050;
    #50 PC_in = 32'h 0000_0054;
    #50 PC_in = 32'h 0000_0058;
    #50 PC_in = 32'h 0000_005C;

    #500 $stop;
  end
  
endmodule
