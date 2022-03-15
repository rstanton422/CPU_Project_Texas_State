module dir_mapp(data_out, data_in, read_write, enable, clk);

  output [31:0] data_out;
  input [31:0] data_in;
  input read_write;
  input enable;
  input clk;
  
  reg [31:0] data_out;
  wire [31:0] data_in;
  wire read_write;
  wire clk;
  
	//Inside the module | internal ports
  reg d_valid[0:999];         //1-bit valid 
  reg [999:0] d_tags [0:15];  //16-bit tag 
  reg [999:0] d_offset [0:4]; //5-bit offset
  reg [999:0] d_data [0:31];  //32-bit data 
    
  wire [31:0] c_din;                  //data to cache
  wire [15:0] tag = data_in[31:16];   //address tag -- cpu address not correct psuedo numbers
  wire [4:0] offset = data_in[15:10]; //bit offset
  wire [8:0] index = data_in[9:1];    //block index -- cpu address not correct psuedo numbers
	
  reg  [31:0] data_mem [0:999];
		
  always @ (posedge clk & enable) begin
    if(read_write == 0) begin  //read bit = 0 
      data_out <= data_mem[index];
    end
  end
  always @ (negedge clk & enable) begin
    if(read_write == 1) begin  //write bit = 1
      data_mem[index] <= data_in;
    end
  end
endmodule
