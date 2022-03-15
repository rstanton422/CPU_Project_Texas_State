module obsidian_tb;
  
  reg [31:0] instruction;
  reg clk;

  obsidian test(.instruction(instruction),
                .clk(clk));

  always begin
    #10 clk = ~clk;
  end
  
  always begin
    #10 $display ($time,,, "Instruction = %h", instruction);
  end
  
  always begin
    #10 $display ($time,,, "Opcode = %b | RM = %b | RN = %b | RD = %b | clk = %b", instruction[31:21], instruction[20:16], instruction[9:5], instruction[4:0], clk);
  end

  initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, test);
    #20 clk = 0;
 // #20 instruction = 32'b PPPP_PPFF_FFFM_MMMM_SSSS_SSNN_NNND_DDDD; R Type
    #40 instruction = 32'b 1101_0011_0100_0000_0000_1100_0010_0010;
    #40 instruction = 32'b 1101_0011_0100_0011_0011_0000_1000_0101;
    #40 instruction = 32'b 1101_0011_0100_0010_1100_0000_1010_0111;
    #100 $finish; 
  end 

endmodule
