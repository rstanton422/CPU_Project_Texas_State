#dir_mapp.v

  inputs: data_in, read_write, enable, clk
  
  outpus: data_out
  
  
#dir_mapp_tb.v

  inputs: data_in, read_write, enable, clk
  
  outputs: data_out
  
  
#memory_cache.v

  inputs: mem_ready, cpu_strobe, uncached, cpu_addr, cpu_data_out, cpu_RW, clk, reset
  
  outputs: cpu_data_in, mem_data_in, mem_addr, mem_RW, mem_strobe, cpu_ready
  
  
# Memory
The memory contains instructions and is comprised of registers. The cache memory serves as quick access to frequently used memory.
