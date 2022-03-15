module Multiplexer_2x32_tb;
  wire [31:0] y;
  reg [31:0] a0, a1, s;
	
  initial begin
    $monitor($time,,, "a0 = %h  |  a1 = %h  |  y = %h", a0, a1,);
    #50  = 32'hff;
  end

endmodule
