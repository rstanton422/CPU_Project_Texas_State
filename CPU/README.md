# 32bitfa.v

  inputs: x, y, cin
  
  outputs: sum, cout
  
  
# ALU_AND.v

  inputs: a, b
  
  outputs: and_bit
  
  
# ALU_OR2.v
  
  inputs: a, b
  
  outputs: or_bit
  
  
# ALU_XOR2.v
  
  inputs: a, b
  
  outputs: xor_bit
  
  
# Obsidian_ALU.v
  
  inputs: a, b, alu_control, shamt
  
  outputs: c
  
  
# barrel_shifter.v
  
  inputs: d, sa, sel
  
  outputs: sh
  
  
# full_adder.v
  
  inputs: a, y, cin
  
  outputs: sum, cout
  
  
# mux2_32.v
  
  inputs: a, b, s
  
  outputs: y
  
  
# obsidian.v
  
  inputs: instruction, clk
  
  outputs: 
  
  
# obsidian_control_unit.v
  
  inputs: clk
  
  outputs: alu_control, rm_control, shamt, rn_control, rd_control)
  
  
# obsidian_registers.v
  
  inputs: rd_input, rm_control, rn_control, rd_control, clk
  
  outputs: rm_output, rn_output
  
  
# obsidian_tb.v
  
  inputs: 
  
  outputs: 
  
  
  
  
# Obsidian CPU 

The CPU (central processing unit) is the component that is responsible for interpreting and executing commands from other hardware and software. It performs basic arithmetic, logical, control and input/output (I/O) opperations specified by the given instructions. The inputs and outputs for the Obsidian CPU can be found above. 
  
