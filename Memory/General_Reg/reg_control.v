module DM_control(data_out, sel, data_in, read_write, enable, clk);

  output [31:0] data_out;
  input [31:0] data_in;
  input [4:0] sel;
  input read_write;
  input enable;
  input clk;
	
  reg [31:0] data_out;
  wire [31:0] data_in;
  wire [4:0] sel;
  wire read_write;
  wire clk;
	
  reg  [31:0] data_mem [0:31];
		
  always @ (posedge clk & enable) begin
    if(read_write == 0) begin  //read bit = 0 
      data_out <= data_mem[sel];
    end
	
    else if(read_write == 1) begin  //write bit = 1
      data_mem[sel] <= data_in;
    end		
  end	
endmodule
	
