module memory_cache(output [31:0] cpu_data_in, // cpu data in from mem
                    output [31:0] mem_data_in, // mem data in from cpu
                    output [31:0] mem_addr,    // mem address
                    output mem_RW,             // mem read/write
                    output mem_strobe,         // mem strobe
                    output cpu_ready,          // ready (to cpu)
                    input mem_ready,           // mem ready
                    input cpu_strobe,          // cpu strobe
                    input uncached,            // uncached
                    input [31:0] cpu_addr,     // cpu address
                    input [31:0] cpu_data_out, // cpu data out to mem
                    input cpu_RW,              // cpu read/write command
                    input clk,reset);
  
  reg d_valid [0:999];        // 1-bit valid 
  reg [15:0] d_tags [0:999];  // 16-bit tag
  reg [8:0] d_offset [0:999]; // 9-bit offset
  reg [31:0] d_data [0:999];  // 32-bit data
    
  wire [31:0] c_din;                  //data to cache
  wire [15:0] tag = cpu_addr[31:16];  //address tag -- cpu address not correct psuedo numbers
  wire [8:0] offset = cpu_addr[15:7]; //bit offset
  wire [5:0] index = cpu_addr[6:1];   //block index -- cpu address not correct psuedo numbers
  wire clk, reset;
  wire c_write;
    
  integer i;
	
  always @ (posedge clk or negedge reset)
    if(!reset) begin
      for(i=0; i<64; i=i+1) begin
        d_valid[i] <= 0; //clear valid
      end
    end 
    else if(c_write)
      d_valid[index] <= 1; //write data valid
  
  always @ (posedge clk)
    if(c_write) begin 
      d_data[index] <= c_din;    //write data
      d_tags[index] <= tag;      //write address tag
      d_offset[index] <= offset; //write offset
    end
  
    wire valid = d_valid[index];  		//read cache valid
    wire [15:0] tagout = d_tags[index];   	//read cache tag
    wire [8:0] off_set = d_offset[index];	//read cache offset
    wire [31:0] c_dout = d_data[index];  	//read cache data
     
    wire cache_hit = cpu_strobe  &  valid & (tagout == tag);  //cache hit
    wire cache_miss = cpu_strobe & (!valid | (tagout != tag));  // cache miss
    wire cache_hit = cpu_strobe  &  valid & (off_set == offset);  //cache hit
    wire cache_miss = cpu_strobe & (!valid | (off_set != offset)); 
      
    assign mem_data_in = cpu_data_out;  	//mem <- cpu data
    assign mem_addr = cpu_addr;  		// mem <- cpu address
    assign mem_RW = cpu_RW;		//write through
    assign mem_strobe = cpu_RW | cache_miss;  	// also read on miss
    assign cpu_ready = ~cpu_RW | cache_hit | (cache_miss | cpu_RW) & mem_ready;  //read and hit or write and mem ready
    assign c_write = ~uncached & (cpu_RW | cache_miss & mem_ready);  	  //write
    assign c_din cpu_RW ? cpu_data_out : mem_data_out;   			  // data from cpu or mem
    assign cpu_data_in = cache_hit ? cpu_data_out : mem_data_out;  	  //data from cache or mem 

endmodule
  
 /*reg  [31:0] data_mem [0:31];
        
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
  end*/
	
	
