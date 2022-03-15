# Branch_Predictor.v 

  inputs: in, clk, enable, 
  
  outputs: reg y
  
  
# Branch_Predictor_tb.v

  inputs: in, clk, enable 
  
  outputs: out
  
  
#dir_mapp.v

  inputs: data_in, read_write, enable, clk
  
  outputs: data_out
  
  
# Branch Prediction

The branch predictor adds efficiency in the execution of commands. As each command is read, the branch predictor determines the likelihood that a branch will be created. After two cycles, the branch predictor is updated to one of the following states: Strong False, Weak False, Weak True, Strong True for a particular address. If a branch did need to be created for a particular address, then the branch predictor would be updated to the next phase for that address (e.g. Weak False to Weak True). If a branch did not need to be created, then the branch predictor would be updated accordingly (e.g. Weak False to Strong False). 
