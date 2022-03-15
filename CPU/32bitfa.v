`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:54:24 02/14/2017 
// Design Name: 
// Module Name:    eightbitfa 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module thirty_two_bit_fa(input [31:0] x, 
                         input [31:0] y,
                         input  cin,
                         output [31:0] sum, 
                         output cout);

  // Couts
  wire c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12,
       c13, c14, c15, c16, c17, c18, c19, c20, c21, c22,
       c23, c24, c25, c26, c27, c28, c29, c30, c31;
	   
  // Subouts
  wire sub1, sub2, sub3, sub4, sub5, sub6, sub7, sub8, sub9, sub10, sub11, sub12,
       sub13, sub14, sub15, sub16, sub17, sub18, sub19, sub20, sub21, sub22, sub23,
       sub24, sub25, sub26, sub27, sub28, sub29, sub30, sub31, sub32;
		
  xor sub_xor0(sub1, y[0], cin);
  xor sub_xor1(sub2, y[1], cin);
  xor sub_xor2(sub3, y[2], cin);
  xor sub_xor3(sub4, y[3], cin);
  xor sub_xor4(sub5, y[4], cin);
  xor sub_xor5(sub6, y[5], cin);
  xor sub_xor6(sub7, y[6], cin);
  xor sub_xor7(sub8, y[7], cin);
  xor sub_xor8(sub9, y[8], cin);
  xor sub_xor9(sub10, y[9], cin);
  xor sub_xor10(sub11, y[10], cin);
  xor sub_xor11(sub12, y[11], cin);
  xor sub_xor12(sub13, y[12], cin);
  xor sub_xor13(sub14, y[13], cin);
  xor sub_xor14(sub15, y[14], cin);
  xor sub_xor15(sub16, y[15], cin);
  xor sub_xor16(sub17, y[16], cin);
  xor sub_xor17(sub18, y[17], cin);
  xor sub_xor18(sub19, y[18], cin);
  xor sub_xor19(sub20, y[19], cin);
  xor sub_xor20(sub21, y[20], cin);
  xor sub_xor21(sub22, y[21], cin);
  xor sub_xor22(sub23, y[22], cin);
  xor sub_xor23(sub24, y[23], cin);
  xor sub_xor24(sub25, y[24], cin);
  xor sub_xor25(sub26, y[25], cin);
  xor sub_xor26(sub27, y[26], cin);
  xor sub_xor27(sub28, y[27], cin);
  xor sub_xor28(sub29, y[28], cin);
  xor sub_xor29(sub30, y[29], cin);
  xor sub_xor30(sub31, y[30], cin);
  xor sub_xor31(sub32, y[31], cin);
		
  full_adder fa0(x[0],sub1,cin,sum[0],c1);
  full_adder fa1(x[1],sub2,c1,sum[1],c2);
  full_adder fa2(x[2],sub3,c2,sum[2],c3);
  full_adder fa3(x[3],sub4,c3,sum[3],c4);
  full_adder fa4(x[4],sub5,c4,sum[4],c5);
  full_adder fa5(x[5],sub6,c5,sum[5],c6);
  full_adder fa6(x[6],sub7,c6,sum[6],c7);
  full_adder fa7(x[7],sub8,c7,sum[7],c8);
  full_adder fa8(x[8],sub9,c8,sum[8],c9);
  full_adder fa9(x[9],sub10,c9,sum[9],c10);
  full_adder fa10(x[10],sub11,c10,sum[10],c11);
  full_adder fa11(x[11],sub12,c11,sum[11],c12);
  full_adder fa12(x[12],sub13,c12,sum[12],c13);
  full_adder fa13(x[13],sub14,c13,sum[13],c14);
  full_adder fa14(x[14],sub15,c14,sum[14],c15);
  full_adder fa15(x[15],sub16,c15,sum[15],c16);
  full_adder fa16(x[16],sub17,c16,sum[16],c17);
  full_adder fa17(x[17],sub18,c17,sum[17],c18);
  full_adder fa18(x[18],sub19,c18,sum[18],c19);
  full_adder fa19(x[19],sub20,c19,sum[19],c20);
  full_adder fa20(x[20],sub21,c20,sum[20],c21);
  full_adder fa21(x[21],sub22,c21,sum[21],c22);
  full_adder fa22(x[22],sub23,c22,sum[22],c23);
  full_adder fa23(x[23],sub24,c23,sum[23],c24);
  full_adder fa24(x[24],sub25,c24,sum[24],c25);
  full_adder fa25(x[25],sub26,c25,sum[25],c26);
  full_adder fa26(x[26],sub27,c26,sum[26],c27);
  full_adder fa27(x[27],sub28,c27,sum[27],c28);
  full_adder fa28(x[28],sub29,c28,sum[28],c29);
  full_adder fa29(x[29],sub30,c29,sum[29],c30);
  full_adder fa30(x[30],sub31,c30,sum[30],c31);
  full_adder fa31(x[31],sub32,c31,sum[31],cout);
		
endmodule
