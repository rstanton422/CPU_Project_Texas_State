module branch_prediction(
    input in,                   //if in = 1, true. if in = 0, false.    
    input clk,                  //clock signal  
    input enable,               //enable signal
    output reg y                //output to y
    );
    
                  
    reg [1:0] state;            //reg for the 4 different states
    
    
    initial begin
        state = 2'b00;
    end
    
    parameter S0 = 2'b00,       //Strong False
              S1 = 2'b01,       //Weak False
              S2 = 2'b10,       //Weak True
              S3 = 2'b11;       //Strong True
              
              
              
     always @ (posedge clk or posedge enable) begin
     
                case (state)
                    S0: begin                   //Strong False
                        if (in == 1) begin      //in = 1, so true comes in
                                               
                            state <= S1;        //moves on to next state, weak false
                        end else begin
                            state <= S0;        //else, stays in state of strong false
                        end
                    end
                            
                            
                    S1: begin                  //Weak False
                        if (in == 1) begin     //in = 1, true comes in                                    
                            state <= S2;       //moves on to nexts state, weak true
                        end else begin         //else, goes back one state to strong false
                            state <= S0;
                        end
                    end
                    S2: begin                  //Weak True
                        if (in == 1) begin     // in = 1, true comes in                        
                            state <= S3;       //moves on to next state, strong true
                        end else begin
                            state <= S1;       //else, goes back to weak false
                        end
                    end
                                        
                    S3: begin                 //Strong True
                        if (in == 1) begin    //in = 1, true comes in
                            state <= S3;      //stays in strong true
                        end else begin        //else, goes back to weak true
                            state <= S2;
                        end
                    end
                endcase
                
            if (state == S0 | state == S1)  begin
                y = 0;
            end else begin
                y = 1;
            end
            
     
     end
     
    
    
endmodule
