module branch_prediction_tb;
    

    reg clk, enable, in;
    wire out;
    
    branch_prediction uut(
                    .in(in), 
                    .clk(clk), 
                    .enable(enable), 
                    .y(out)
                    );
    
    always
    begin
        #50 clk = ~clk;
    end
    
    initial

        begin
          $dumpfile("wave.vcd");
          $dumpvars(0, uut);   
          
            #10 clk = 1;
            #20 enable = 1;
            
            #50 in = 1;
            #150 in = 1;
            #200 in = 1;
            #200 in = 1;
            #200 in = 0;
            #200 in = 1;
            #200 in = 0;
            #200 in = 1;
            #200 in = 0;
            #200 in = 0;
            #200 in = 0;
            #100 
            $finish;
            
        end
        
endmodule