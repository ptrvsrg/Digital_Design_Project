`timescale 1ns / 1ps

module testbench();

    logic clk;
    logic [7 : 0] btn;
    logic [7 : 0] dig0;
    logic [7 : 0] dig1;
    logic [7 : 0] dig2;
    logic [7 : 0] dig3;
    logic speaker;
    
    top dut(clk, btn, dig0, dig1, dig2, dig3, speaker);
    
    initial
    begin
        btn = 8'b11111111;
        for(int i = 0; i < 1000; i++)
        begin
            clk = i % 2;
            #1;
            
            if(i == 10)
                btn = 8'b11111110; // RUN STOPWATCH
            if(i == 15)
                btn = 8'b11111111;
                
            if(i == 200)
                btn = 8'b11111101; // PAUSE STOPWATCH
            if(i == 205)
                btn = 8'b11111111;
                
            if(i == 210)
                btn = 8'b01111111; // SWITCH MODE
            if(i == 215)
                btn = 8'b11111111;
                
            if(i == 220)
                btn = 8'b11011111; // ADD MINUTE
            if(i == 225)
                btn = 8'b11111111;
            if(i == 230)
                btn = 8'b11011111; // ADD MINUTE
            if(i == 235)
                btn = 8'b11111111;
            if(i == 240)
                btn = 8'b11011111; // ADD MINUTE
            if(i == 245)
                btn = 8'b11111111;
            if(i == 250)
                btn = 8'b11011111; // ADD MINUTE  
            if(i == 255)
                btn = 8'b11111111;
            if(i == 260)
                btn = 8'b11101111; // SUBTRACT SECOND
            if(i == 265)
                btn = 8'b11111111;
                
            if(i == 300)
                btn = 8'b11111110; // RUN TIMER
            if(i == 305)
                btn = 8'b11111111;
                
            if(i == 400)
                btn = 8'b11111101; // PAUSE TIMER
            if(i == 405)
                btn = 8'b11111111;
                
            if(i == 500)
                btn = 8'b01111111; // SWITCH MODE
            if(i == 505)
                btn = 8'b11111111;
                
            if(i == 600)
                btn = 8'b11111110; // RUN STOPWATCH
            if(i == 605)
                btn = 8'b11111111;
        end
        
        $finish;
    end

endmodule