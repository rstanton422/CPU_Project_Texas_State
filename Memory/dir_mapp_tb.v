module dir_mapp_tb;

  wire [31:0] data_out;
  reg [31:0] data_in;
  reg read_write;
  reg enable;
  reg clk;
	
  reg [31:0] temp [0:999];
	
  integer i, k;
	
  dir_mapp DM(.data_in(data_in),
               .data_out(data_out),
               .enable(enable),
               .read_write(read_write),
               .clk(clk)
			    );
	
  initial begin
    $readmemh ("data_mem.txt",temp);
  end
  
  always  begin
    #10 clk = ~clk;
  end
  
  initial  begin
    #0 clk <= 0;
    #10 enable <= 1;
    #50 read_write <= 1;                   

    for (i = 0; i < 32; i=i+1) begin                   
      #20 data_in <= temp[i];                  
    end                  
    
    #50 read_write <= 0;                  

    for (k = 0; k < 32; k=k+1) begin                                       
      #20 data_in <= temp[k];                                            
    end
	#100 $finish;
  end
	
  initial begin
    $monitor($time,,,"Enable = %d | Write = %d | data_in = %d | data_out = %d", enable, read_write, data_in, data_out);
  end
	
	
endmodule