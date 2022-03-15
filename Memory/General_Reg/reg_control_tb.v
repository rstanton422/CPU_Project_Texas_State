module DM_control_tb;

  wire [31:0] data_out;
  reg [31:0] data_in;
  reg [4:0] sel;
  reg read_write;
  reg enable;
  reg clk;
	
  reg [31:0] temp [0:31];
	
  integer i, k;
	
  DM_control DM1(.data_in(data_in),
                 .data_out(data_out),
                 .sel(sel),
                 .enable(enable),
                 .read_write(read_write),
                 .clk(clk));
	
  initial begin
    $readmemh ("data_mem.mem",temp);
  end
	
  always  begin
    #10 clk = ~clk;
  end
	
  initial  begin
    #0 clk <= 0;
    #10 enable <= 1;
    #50 read_write <= 1;                   

    for (i = 0; i < 32; i=i+1) begin                   
      #20 sel <= i; 
      data_in <= temp[sel];                  
    end                  
    
    #50 read_write <= 0;                  

    for (k = 0; k < 32; k=k+1) begin                                       
      #20 sel <= k;                                            
    end
  end
	
  initial begin
    $monitor($time,,,"Enable = %d | Read = %d | Write = %d | Sel = %d | data_in = %d | data_out = %d", enable, ~read_write, read_write, sel, data_in, data_out);
  end
			
endmodule
