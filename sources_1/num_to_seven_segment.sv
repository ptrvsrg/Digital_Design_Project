`timescale 1ns / 1ps

module num_to_seven_segment(
    input [3 : 0] num,
    output logic [6 : 0] dig
    );
    
    always_comb 
    begin
        case(num)
            4'd0 : dig = 7'b0111111;
            4'd1 : dig = 7'b0000110;
            4'd2 : dig = 7'b1011011;
            4'd3 : dig = 7'b1001111;
            4'd4 : dig = 7'b1100110;
            4'd5 : dig = 7'b1101101;
            4'd6 : dig = 7'b1111101;
            4'd7 : dig = 7'b0000111;
            4'd8 : dig = 7'b1111111;
            4'd9 : dig = 7'b1101111;
        endcase
    end
endmodule