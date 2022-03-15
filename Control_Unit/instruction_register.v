// PC_out is refering to our PC module, we are trying to grab 
// the output address from the PC.
module Instr_Reg(Opcode, Instr_Mem, clk);

  input clk;
  input Instr_Mem;
  output [5:0] Opcode;
	 
  wire [31:0] Instr_Mem;
  reg [5:0] Opcode;
  reg [31:0] IR;
  reg [31:0] PC_out;

  // This is suppose be to using PC_out as the address value
  // and putting the value into the instruction register.
  always @ (posedge clk) begin
    IR = Instr_Mem [PC_out];		
    Opcode = Instr_Mem [31:26];
  end
	
endmodule // HI
