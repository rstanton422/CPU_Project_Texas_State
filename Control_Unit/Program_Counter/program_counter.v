module program_counter(PC_out, PC_in, clk);
	 
  input clk;
  input PC_in;
  output PC_out;
	 
  wire [31:0] PC_in;
  reg [31:0] PC_out;
	
  reg [31:0] PC_mem;
	
  initial begin 
    PC_out = 0;
  end
  
  always @ (posedge clk) begin
    PC_mem <= PC_in;
    PC_out <= PC_mem + 4;
  end
  
endmodule
