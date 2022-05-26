`timescale 1ns / 1ps

module stopwatch(
    input clk,                              // CLOCK 12 MHZ
    input [7 : 0] btn,                      // BUTTONS
    input mode,                             // MODE
    
    output logic [13 : 0] out_time_value    // OUT TIME VALUE
    );
    
    const logic [23 : 0] hz_clk = 12000000;
    //const logic [23 : 0] hz_clk = 2; // FOR TEST BENCH
    
    logic [23 : 0] cnt = 0;
    logic [7 : 0] btn_delay = 0;
    enum {RUN_STATE, PAUSE_STATE} state = PAUSE_STATE;
    logic [13 : 0] time_value = 0;
    
    always_ff @(posedge clk)
    begin
        if(mode == 0)
        begin
            if (btn == 8'b11111111)
                case(btn_delay)
                    8'b11111110: state = RUN_STATE;    // RUN
                    8'b11111101: state = PAUSE_STATE;  // PAUSE
                    8'b11111011:                       // RESET
                    begin
                        state = PAUSE_STATE;
                        time_value = 0;
                        cnt = 0;
                    end
                endcase
         
            if (state == RUN_STATE)
            begin
                cnt <= cnt + 1;
                
                if (cnt == hz_clk)
                begin
                    time_value = (time_value + 1) % 3600;
                    cnt = 0;
                end
            end
                
            btn_delay = btn;
            out_time_value = time_value;
        end
    end    
endmodule