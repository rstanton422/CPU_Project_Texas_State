module full_adder(x, y, cin, sum, cout);

  input x, y, cin;
  output sum, cout;

  wire s1, co1, co2;
	
  xor xor1(s1, x, y);
  xor xor2(sum, cin, s1);
	
  and and1(co1, cin, s1);
  and and2(co2, x, y);
	
  or or1(cout, co1, co2);
	
endmodule
	
 


	
	

		
	
	
	
	
	
	
