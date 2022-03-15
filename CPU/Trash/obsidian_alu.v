module obsidian_alu (c, a, b, alu_control, shamt);

  output [31:0] c;
  input [31:0] a, b;
  input [2:0] alu_control;
  input [4:0] shamt;
  
  reg [31:0] c;
  wire [31:0] a, b;
  wire [2:0]alu_control;
  wire [4:0] shamt;

  always @ (a, b, alu_control) begin
    case (alu_control)
      3'b000: begin
        c = a | b;
      end
      3'b001: begin
        c = a + b;
      end
      3'b010: begin
        c = a & b;
      end 
      3'b011: begin
        c = a ^ b;
      end 
      3'b100: begin
        c = a - b;
      end
      3'b101: begin
        c = b >>> shamt;
      end
    endcase
  end

endmodule
