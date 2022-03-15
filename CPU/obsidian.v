module obsidian(instruction, clk);

  input [31:0] instruction;
  input clk; 
  
  wire [31:0] instruction;
  wire clk;
  reg [31:0] output_data;

  wire [31:0] rm_output_a; 
  wire [31:0] rn_output_b;
  wire [31:0] c_rd_input;
  wire [31:0] alu_immediate_b;
  wire [3:0] alu_control_alu_control;
  wire [4:0] rd_control_rd_control;
  wire [4:0] rm_control_rm_control; 
  wire [4:0] rn_control_rn_control;
  wire [4:0] shamt_shamt;
  
  //                                 .other modules conection (this modules conection)
  obsidian_control_unit control_unit(.instruction_reg(instruction), 
                                     .clk(clk),
                                     .rm_control(rm_control_rm_control),
                                     .rn_control(rn_control_rn_control),
                                     .rd_control(rd_control_rd_control),
                                     .alu_control(alu_control_alu_control),
                                     .shamt(shamt_shamt)); 
 
  obsidian_alu alu (.c(c_rd_input),
                    .a(rm_output_a),
                    .b(rn_output_b),
                    .alu_control(alu_control_alu_control),
                    .shamt(shamt_shamt)); 
    
  obsidian_registers registers   (.rm_output(rm_output_a),
                                  .rn_output(rn_output_b),
                                  .rd_input(c_rd_input),
                                  .rm_control(rm_control_rm_control),
                                  .rn_control(rn_control_rn_control),
                                  .rd_control(rd_control_rd_control),
                                  .clk(clk)); 
endmodule
