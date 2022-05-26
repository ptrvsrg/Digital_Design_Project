`timescale 1ns / 1ps

module timer(
    input clk,                              // CLOCK 12 MHZ
    input [7 : 0] btn,                      // BUTTONS
    input mode,                             // MODE
    
    output logic [13 : 0] out_time_value,   // OUT TIME VALUE
    output logic speaker = 0                // SPEAKER
    );
    
    const logic [15 : 0] hz = 5733;
    //const logic [23 : 0] hz = 4; // FOR TEST BENCH
    const logic [23 : 0] hz_clk = 12000000;
    //const logic [23 : 0] hz_clk = 2; // FOR TEST BENCH
        
    logic [23 : 0] cnt = 0;
    logic [7 : 0] btn_delay = 0;
    enum {RUN_STATE, PAUSE_STATE} state = PAUSE_STATE;
    logic [13 : 0] time_value = 0;
    
    always_ff @(posedge clk)
    begin     
        if(mode == 1)
        begin
            if (btn == 8'b11111111)
                case(btn_delay)
                    8'b11111110: state = RUN_STATE;                         // RUN
                    8'b11111101: state = PAUSE_STATE;                       // PAUSE
                    8'b11111011:                                            // RESET
                    begin
                        time_value = 0;
                        state = PAUSE_STATE;
                        cnt = 0;
                    end
                    8'b11110111: time_value = (time_value + 1) % 3600;     // ADD SECOND
                    8'b11101111: time_value = (time_value + 3599) % 3600;  // SUBTRACT SECOND
                    8'b11011111: time_value = (time_value + 60) % 3600;    // ADD MINUTE
                    8'b10111111: time_value = (time_value + 3540) % 3600;  // SUBTRACT MINUTE
                endcase
         
            if (state == RUN_STATE)
            begin
                cnt = cnt + 1;
            
                if(time_value == 0)             // END SOUND
                begin
                    if(cnt == hz)
                    begin
                        speaker = ~speaker;
                        cnt = 0;
                    end
                end
                else                            // COUNTBACK
                begin
                    speaker = 0;
                    if(cnt == hz_clk) 
                    begin
                        time_value = time_value - 1;
                        cnt = 0;
                    end
                end
            end
                   
            btn_delay = btn;
            out_time_value = time_value;
        end
    end      
endmodule