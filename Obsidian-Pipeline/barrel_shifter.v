`timescale 1ns/1ps
module barrel_shifter(d, sa, sel, sh);

  input [31:0] d; 
  input [4:0] sa; 
  input [1:0] sel; 
    
  output [31:0] sh; 
  
  wire [31:0] d;
  wire [4:0] sa;
  wire [1:0] sel;
  
  reg [31:0] sh;
    
  parameter SLL = 2'b00, SLR = 2'b01, SAL = 2'b10, SAR = 2'b11;
  
  always @* begin
    if(sel == SLL) 
      begin
        sh = d << sa;
      end
    else if(sel == SLR)
      begin
        sh = d >> sa;
      end 
    else if(sel == SAR)
      begin
        sh = $signed(d) >>> sa;
      end
    else if(sel ==	SAL)
      begin
        sh = $signed(d) <<< sa;
      end
  end
		
endmodule
    
/*     wire    [31:0]  t0, t1, t2, t3, t4; 
    wire    [31:0]  s1, s2, s3, s4; 
    wire            a = d[31] & arith; 
    wire    [31:0]  e = {16{a}};
    
    parameter       z = 16'b0; 
    
    wire    [31:0]  sd14, sd13, sd12, sd11, sd10; 
    wire    [31:0]  sdr4, sdr3, sdr2, sdr1, sdr0; 
    
    assign  sdl4    =   {d[15:0],   z};
    assign  sdl3    =   {s4[23:0],  z[7:0]};
    assign  sdl2    =   {s3[27:0],  z[3:0]};
    assign  sdl1    =   {s2[29:0],  z[1:0]};
    assign  sdl0    =   {s1[30:0],  z[0]};
    assign  sdr4    =   {e,         d[31:16]};
    assign  sdr3    =   {e[7:0],    s4[31:8]};
    assign  sdr2    =   {e[3:0],    s3[31:4]};
    assign  sdr1    =   {e[1:0],    s2[31:2]};
    assign  sdr0    =   {e[0],      s1[31:1]};
    
    mux2x32 m_right4 (sdl4, sdr4, right, t4);
    mux2x32 m_right3 (sdl3, sdr3, right, t3);
    mux2x32 m_right2 (sdl2, sdr2, right, t2);
    mux2x32 m_right1 (sdl1, sdr1, right, t1);
    mux2x32 m_right0 (sdl0, sdr0, right, t0);
    
    mux2x32 m_shift4 (d,    t4, sa[4], s4);
    mux2x32 m_shift3 (s4,   t3, sa[3], s3);
    mux2x32 m_shift2 (s3,   t2, sa[2], s2);
    mux2x32 m_shift1 (s2,   t1, sa[1], s1);
    mux2x32 m_shift0 (s1,   t0, sa[0], sh);
    
endmodule */
    
