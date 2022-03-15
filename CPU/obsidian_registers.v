module obsidian_registers(rm_output, rn_output, rd_input, rm_control, rn_control, rd_control, clk);

  output [31:0] rm_output;
  output [31:0] rn_output;
  input [31:0] rd_input;
  input [4:0] rm_control;
  input [4:0] rn_control;
  input [4:0] rd_control;
  input clk;

  reg [31:0] rm_output;
  reg [31:0] rn_output;
  wire [31:0] rd_input;	
  wire [4:0] rm_control;
  wire [4:0] rn_control;
  wire [4:0] rd_control;
  wire clk;
	
  reg  [31:0] data_mem [0:31];
        
  initial begin
    $readmemh("inputs.txt", data_mem);
  end  
 
  always @ (posedge clk)  begin
    rm_output <= data_mem[rm_control];
    rn_output <= data_mem[rn_control];
    $display ("rm = %b | rn = %b", rm_output, rn_output);
  end 

  always @ (negedge clk) begin
    data_mem[rd_control] <= rd_input;
    $display ("rd = %b", rd_input);
  end
		
endmodule
	
