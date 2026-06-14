module icecream_dispenser(coin,dispense,change,clk,reset);

        //Assigning parameters
        input coin,clk,reset;
        output reg dispense;
        output [1:0] change;
        reg [1:0] change;

        //Describing the states now
    localparam S0 = 2'b00;
    localparam S1 = 2'b01;
    localparam S2 = 2'b10;

    reg current_state;

    initial
    begin
        current_state = S0;
    end

    always @(posedge clk)
    begin
        case(current_state)
            S0:
                if(reset==1)
                begin
                    current_state = S0;
                    dispense = 0;
                    change = 2'b00;
                end
                //This is a Rs. 5 coin now
                else if(coin==0)
                begin   
                    current_state = S1;
                    dispense = 0;
                    change = 2'b00;
                end
                //This is a Rs. 10 coin
                else if(coin==1)
                begin
                    current_state = S2;
                    dispense = 0;
                    change = 2'b00;
                end

            S1:
                if(reset==1)
                begin
                    current_state = S1;
                    dispense = 0;
                    change = 2'b01;
                end
                //This is Rs. 5 coin
                else if(coin==0)
                begin
                    current_state = S2;
                    dispense = 0;
                    change = 2'b00;
                end
                //This is Rs. 10 coin
                else if(coin==1)
                begin
                    current_state = S0;
                    dispense = 1;
                    change = 2'b00;
                end

            S2:
                if(reset==1)
                begin
                    current_state = S2;
                    dispense = 0;
                    change = 2'b10;
                end
                //This is Rs. 5 coin
                else if(coin==0)
                begin
                    current_state = S0;
                    dispense = 1;
                    change = 2'b00;
                end
                //This is Rs. 10 coin
                else if(coin==1)
                begin
                    current_state = S0;
                    dispense = 1;
                    change = 2'b01;
                end
        endcase
    end
endmodule
