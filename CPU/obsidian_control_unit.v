module obsidian_control_unit(input wire [31:0] instruction_reg,
                             input clk,
                             output reg [3:0] alu_control,
                             output reg [4:0] rm_control,
                             output reg [4:0] shamt,
                             output reg [4:0] rn_control,
                             output reg [4:0] rd_control);

  reg [5:0] pre_op; 
  reg [4:0] rest_of_op_r_type; 
  reg [4:0] rest_of_op_d_type; 
  reg [3:0] rest_of_op_i_type; 
  reg [1:0] rest_of_op_cb_type; 
  reg [11:0] alu_immediate;

  always @ (posedge clk) begin
    pre_op = instruction_reg[31:26];
    case (pre_op)
      6'b00_0111: begin
        rest_of_op_r_type = instruction_reg[25:21];
        case (rest_of_op_r_type)
          5'b1_0001: begin // FMULS - FSUBS 
            shamt = instruction_reg[15:10];
            case (shamt)
              6'b00_0010: begin // FMULS
              end
            endcase
          end
          5'b1_0011: begin // FMULD - FSUBD 
          end
        endcase
      end
      6'b10_0010: begin 
        rest_of_op_r_type = instruction_reg[25:21];
        case (rest_of_op_r_type)
          5'b1_0000: begin // AND
            alu_control = 4'b1000; 
            rm_control = instruction_reg[20:16];
            rn_control = instruction_reg[9:5];
            rd_control = instruction_reg[4:0];
          end
          5'b1_1000: begin // ADD
            alu_control = 4'b0000;
            rm_control = instruction_reg[20:16];
            rn_control = instruction_reg[9:5];
            rd_control = instruction_reg[4:0];
          end
        endcase
      end 
      6'b10_0110: begin
        rest_of_op_r_type = instruction_reg[25:21];
        case (rest_of_op_r_type)
          5'b1_0110: begin // SDIV - UDIV
          end
          5'b1_1000: begin // MUL
          end
          5'b1_1010: begin // SMULH 
          end
          5'b1_1110: begin // UMULH
          end
        endcase
      end
      6'b10_1010: begin 
        rest_of_op_r_type = instruction_reg[25:21];
        case (rest_of_op_r_type)
          5'b1_0000: begin //ORR
            alu_control = 4'b0010;
            rm_control = instruction_reg[20:16];
            rn_control = instruction_reg[9:5];
            rd_control = instruction_reg[4:0];
          end
          5'b1_1000: begin // ADDS
            alu_control = 4'b0000; 
            rm_control = instruction_reg[20:16];
            rn_control = instruction_reg[9:5];
            rd_control = instruction_reg[4:0];
          end
        endcase
      end
      6'b10_1111: begin 
        rest_of_op_r_type = instruction_reg[25:21];
        case (rest_of_op_r_type)
          5'b0_0000: begin // STURS
          end
          5'b0_0010: begin // LDURS
          end
        endcase
      end
      6'b11_0010: begin 
        rest_of_op_r_type = instruction_reg[25:21];
        case (rest_of_op_r_type)
          5'b1_0000: begin // EOR
            alu_control = 4'b0011;
            rm_control = instruction_reg[20:16];
            rn_control = instruction_reg[9:5];
            rd_control = instruction_reg[4:0];
          end
          5'b1_1000: begin // SUB
            alu_control = 4'b0001;
            rm_control = instruction_reg[20:16];
            rn_control = instruction_reg[9:5];
            rd_control = instruction_reg[4:0];
          end
        endcase
      end 
      6'b11_0100: begin 
        rest_of_op_r_type = instruction_reg[25:21];
        case (rest_of_op_r_type)
          5'b1_1010: begin // LSR
            alu_control = 4'b0101; 
            shamt = instruction_reg[15:10];
            rn_control = instruction_reg[9:5];
            rd_control = instruction_reg[4:0];
          end
          5'b1_1011: begin // LSL
            alu_control = 4'b0100;
            shamt = instruction_reg[15:10];
            rn_control = instruction_reg[9:5];
            rd_control = instruction_reg[4:0];
          end
        endcase
      end 
      6'b11_0101: begin 
        rest_of_op_r_type = instruction_reg[25:21];
        case (rest_of_op_r_type)
          5'b1_0000: begin // BR
          end
        endcase
      end
      6'b11_1010: begin 
        rest_of_op_r_type = instruction_reg[25:21];
        case (rest_of_op_r_type)
          5'b1_0000: begin // ANDS
            alu_control = 4'b1000; 
            rm_control = instruction_reg[20:16];
            rn_control = instruction_reg[9:5];
            rd_control = instruction_reg[4:0];
          end
          5'b1_1000: begin // SUBS
            alu_control = 4'b0001;
            rm_control = instruction_reg[20:16];
            rn_control = instruction_reg[9:5];
            rd_control = instruction_reg[4:0];
          end
        endcase
      end
      6'b11_1111: begin 
        rest_of_op_r_type = instruction_reg[25:21];
        case (rest_of_op_r_type)
          5'b0_0000: begin // STURD
          end
          5'b0_0010: begin // LDURD
          end
        endcase
      end
      // Begining of I Type
      6'b10_0100: begin
        rest_of_op_i_type = instruction_reg[25:22];
        case (rest_of_op_i_type)
          4'b0100: begin   // ADDI
            alu_control = 4'b0000; 
            alu_immediate = instruction_reg[21:10];
            rn_control = instruction_reg[9:5];
            rd_control = instruction_reg[4:0];
          end
          4'b1000: begin   // ANDI  
          end
        endcase
      end
      6'b10_1100: begin
        rest_of_op_i_type = instruction_reg[25:22];
        case (rest_of_op_i_type)
          4'b0100: begin   // ADDIS
            alu_control = 3'b010;
          end
          4'b1000: begin   // ORRI
            alu_control = 3'b010;
          end
        endcase
      end
      6'b11_0100: begin
        rest_of_op_i_type = instruction_reg[25:22];
        case (rest_of_op_i_type)
          4'b0100: begin   // SUBI
            alu_control = 3'b010;
          end
          4'b1000: begin   // EORI
            alu_control = 3'b010;
          end
        endcase
      end
      6'b11_1100: begin
        rest_of_op_i_type = instruction_reg[25:22];
        case (rest_of_op_i_type)
          4'b0100: begin   // SUBIS
            alu_control = 3'b010;
          end
          4'b1000: begin   // ANDIS
            alu_control = 3'b010;
          end
        endcase
      end
      // Begining of D Type
      6'b00_1110: begin 
        rest_of_op_d_type = instruction_reg[25:21];
        case (rest_of_op_d_type)
          5'b0_0000: begin // STURB
          end
          5'b0_0010: begin // LDURB
          end
        endcase
      end
      6'b01_1110: begin 
        rest_of_op_d_type = instruction_reg[25:21];
        case (rest_of_op_d_type)
          5'b0_0000: begin // STURH
          end
          5'b0_0010: begin // LDURH
          end
        endcase
      end
      6'b10_1110: begin 
        rest_of_op_d_type = instruction_reg[25:21];
        case (rest_of_op_d_type)
          5'b0_0000: begin // STURW
          end
          5'b0_0010: begin // LDURW
          end
        endcase
      end
      6'b11_0010: begin 
        rest_of_op_d_type = instruction_reg[25:21];
        case (rest_of_op_d_type)
          5'b0_0000: begin // STXR
          end
          5'b0_0010: begin // LDXR
          end
        endcase
      end
      6'b11_1110: begin 
        rest_of_op_d_type = instruction_reg[25:21];
        case (rest_of_op_d_type)
          5'b0_0000: begin // STUR
          end
          5'b0_0010: begin // LDUR
          end
        endcase
      end
      // Start of B
      6'b00_0101: begin // B 
      end
      6'b10_0101: begin // BL 
      end
      // START OF CB
      6'b11_1110: begin 
        rest_of_op_cb_type = instruction_reg[25:24];
        case (rest_of_op_cb_type)
          2'b0_0: begin // B.COND
          end
        endcase
      end
      6'b10_1101: begin 
        rest_of_op_cb_type = instruction_reg[25:24];
        case (rest_of_op_cb_type)
          2'b00: begin // CBZ
          end
          2'b01: begin // CBNZ
          end
        endcase
      end
    endcase
  end
endmodule

/* 6'b100110: begin //SMULH
rest_of_op = instruction_reg[26:21];
case(rest_of_op)
5'b11010: begin
alu_control = 3'b100;  
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end
endcase */
/* 6'b100010: begin  //ADD
alu_control = 3'b100;  //Not an actual value, still to look it up
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end
11'h488: begin  //ADD I
alu_control = 3'b000;  //Not an actual value, still to look it up
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end
11'h489: begin  // ADD I
alu_control = 3'b000;  //Not an actual value, still to look it up
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end
11'h490: begin  //AND I
alu_control = 3'b000;  //Not an actual value, still to look it up
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end
11'h491: begin  // AND I
alu_control = 3'b000;  //Not an actual value, still to look it up
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end
11'h4A0-4BF: begin  // BL (range)
alu_control = 3'b000;  //Not an actual value, still to look it up
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end
11'h4D6: begin  //Sdiv
alu_control = 3'b000;  //Not an actual value, still to look it up
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end
11'h4D6: begin  //Udiv
alu_control = 3'b000;  //Not an actual value, still to look it up
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end
11'h4D8: begin  //MUL
alu_control = 3'b000;  //Not an actual value, still to look it up
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end
11'h4DA: begin  // SMULH
alu_control = 3'b000;  //Not an actual value, still to look it up
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end
11'h4DE: begin  //UMULH
alu_control = 3'b000;  //Not an actual value, still to look it up
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end
11'h550: begin  //ORR
alu_control = 3'b001;  //Not an actual value, still to look it up
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end
11'h558: begin  //ADDS
alu_control = 3'b000;  //Not an actual value, still to look it up
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end
11'h588: begin  //ADDIS
alu_control = 3'b000;  //Not an actual value, still to look it up
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end
11'h589: begin  //ADDIS
alu_control = 3'b000;  //Not an actual value, still to look it up
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end
11'h590: begin  //ORRII
alu_control = 3'b000;  //Not an actual value, still to look it up
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end
11'h591: begin  //ORRII
alu_control = 3'b000;  //Not an actual value, still to look it up
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end
11'h5A0-5A7: begin  //CBZ
alu_control = 3'b000;  //Not an actual value, still to look it up
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end
11'h5A8-5AF: begin  //CBNZ
alu_control = 3'b000;  //Not an actual value, still to look it up
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end
11'h5C0: begin  // STURW
alu_control = 3'b000;  //Not an actual value, still to look it up
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end
11'h5C4: begin  //LDURSW
alu_control = 3'b000;  //Not an actual value, still to look it up
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end
11'h5E0: begin  //STURS
alu_control = 3'b000;  //Not an actual value, still to look it up
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end
11'h5E2: begin  //LDURS
alu_control = 3'b000;  //Not an actual value, still to look it up
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end
11'h640: begin  //STXR
alu_control = 3'b000;  //Not an actual value, still to look it up
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end
11'h642: begin  //LDXR
alu_control = 3'b000;  //Not an actual value, still to look it up
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end
11'h650: begin  //EOR
alu_control = 3'b000;  //Not an actual value, still to look it up
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end
11'h658: begin  //SUB
alu_control = 3'b000;  //Not an actual value, still to look it up
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end
11'h688: begin  //SUBI
alu_control = 3'b000;  //Not an actual value, still to look it up
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end
11'h689: begin  //SUBI
alu_control = 3'b000;  //Not an actual value, still to look it up
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end
11'h690: begin  //EORI
alu_control = 3'b000;  //Not an actual value, still to look it up
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end
11'h691: begin  //EORI
alu_control = 3'b000;  //Not an actual value, still to look it up
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end
11'h694-697: begin  //MOVZ
alu_control = 3'b000;  //Not an actual value, still to look it up
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end
11'h69A: begin  //LSR
alu_control = 3'b000;  //Not an actual value, still to look it up
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end
11'h69B: begin  //LSL
alu_control = 3'b000;  //Not an actual value, still to look it up
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end
11'h6B0: begin  //BR
alu_control = 3'b000;  //Not an actual value, still to look it up
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end
11'h750: begin  //ANDS
alu_control = 3'b000;  //Not an actual value, still to look it up
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end
11'h758: begin  //SUBS
alu_control = 3'b000;  //Not an actual value, still to look it up
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end
11'h788: begin  //SUBIS
alu_control = 3'b000;  //Not an actual value, still to look it up
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end
11'h789: begin  //SUBIS
alu_control = 3'b000;  //Not an actual value, still to look it up
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end
11'h790: begin  //ANDIS
alu_control = 3'b000;  //Not an actual value, still to look it up
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end
11'h791: begin  //ANDIS
alu_control = 3'b000;  //Not an actual value, still to look it up
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end
11'h794-797: begin //MOVK
alu_control = 3'b000;  //Not an actual value, still to look it up
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end
11'h7C0: begin  //STUR
alu_control = 3'b000;  //Not an actual value, still to look it up
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end
11'h7C2: begin  //LDUR
alu_control = 3'b000;  //Not an actual value, still to look it up
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end
11'h7E0: begin  //STURD
alu_control = 3'b000;  //Not an actual value, still to look it up
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end
11'h7E2-4BF: begin  //LDURD
alu_control = 3'b000;  //Not an actual value, still to look it up
rm_control = instruction_reg[20:16];
rn_control = instruction_reg[9:5];
rd_control = instruction_reg[4:0];
end

end
endcase */



//and 000
//or 001
//xor 010
//shift 011
//add 100


