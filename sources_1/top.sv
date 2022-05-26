`timescale 1ns / 1ps

module top(
    input clk,                      // CLOCK 12 MHZ
    input [7 : 0] btn,              // BUTTONS
    
    output [7 : 0] dig0,            // DIGIT 0
    output [7 : 0] dig1,            // DIGIT 1
    output [7 : 0] dig2,            // DIGIT 2
    output [7 : 0] dig3,            // DIGIT 3
    output speaker,                 // SPEAKER
    output logic [7 : 0] led        // LED
    );
    
    assign dig0[7] = 0;
    assign dig1[7] = 1;
    assign dig2[7] = 0;
    assign dig3[7] = 0;
    
    logic mode = 0;
    // 0 - STOPWATCH
    // 1 - TIMER
    
    logic [13 : 0] value;
    
    logic [13 : 0] out_timer_value;
    logic [13 : 0] out_stopwatch_value;
    
    logic [7 : 0] btn_delay;
    
    logic [3 : 0] num0;
    logic [3 : 0] num1;
    logic [3 : 0] num2;
    logic [3 : 0] num3;
        
    always_ff @(posedge clk)
    begin        
        if (btn == 8'b11111111 && btn_delay == 8'b01111111)
            mode = ~mode;
                
        case(mode)
            0: 
            begin
                value = out_stopwatch_value;
                led = 8'b00001111;
            end
            1:  
            begin
                value = out_timer_value;
                led = 8'b11110000;
            end
        endcase
            
        num0 = (value / 60) / 10;
        num1 = (value / 60) % 10;
        num2 = (value % 60) / 10;
        num3 = (value % 60) % 10;

        btn_delay = btn;
    end
    
    stopwatch run_stopwatch(
        .clk(clk),
        .btn(btn),
        .mode(mode),
        .out_time_value(out_stopwatch_value)
    );
            
    timer run_timer(
        .clk(clk),
        .btn(btn),
        .mode(mode),
        .out_time_value(out_timer_value),
        .speaker(speaker)
    );
    
    num_to_sev_segm convert0(
        .num(num0),
        .dig(dig0[6 : 0])
    ); 
    
    num_to_sev_segm convert1(
        .num(num1),
        .dig(dig1[6 : 0])
    ); 
    
    num_to_sev_segm convert2(
        .num(num2),
        .dig(dig2[6 : 0])
    ); 
    
     num_to_sev_segm convert3(
         .num(num3),
         .dig(dig3[6 : 0])
     );
     
endmodule
