`timescale 1ns / 1ps
/* encoder_cell module
    implements encoding for one 7-segment display
    -----Inputs:-----
    clk_i - internal FPGA unit clock
    rst_i - asynchronous reset, assigned to button
    num_i - if LSB is 1, then the dot will be displayed, otherwise not
          - first 4 bits are for hex number to be displayed
    ------Outputs:------
    dig_o - encoded output for the display, ready to be sent (low signal turns the segment on)
*/
module encoder_cell(
    input clk_i,
    input rst_i,
    input [4:0] num_i, // number to be encoded for the display
    output [7:0] dig_o // number to be displayed
    );
    
    // output register
    reg [7:0] segments;
    assign dig_o = segments;
    
    // constants for clear code
    localparam nothing = 7'b1111111;
    localparam zero = 7'b0000001;
    localparam one = 7'b1001111;
    localparam two = 7'b0010010;
    localparam three = 7'b0000110;
    localparam four = 7'b1001100;
    localparam five = 7'b0100100;
    localparam six = 7'b0100000;
    localparam seven = 7'b0001111;
    localparam eight = 7'b0000000;
    localparam nine = 7'b0000100;
    localparam letterA = 7'b0001000; // "10 in decimal"
    localparam letterB = 7'b1100000;
    localparam letterC = 7'b0110001;
    localparam letterD = 7'b1000010;
    localparam letterE = 7'b0110000;
    localparam letterF = 7'b0111000;
    
    // encoder logic
    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin // asynchronous reset
            segments = 8'hFF;
        end 
        else begin
            if(num_i[4]) segments[0] = 0; // if set to show dot (1), then assign low signal to turn it on
            else segments[0] = 1; // // if everything else then do not show it (1)
            case(num_i[3:0]) // check the value that is intended to be set on the display
                4'h0: segments[7:1] = zero;
                4'h1: segments[7:1] = one;
                4'h2: segments[7:1] = two;
                4'h3: segments[7:1] = three;
                4'h4: segments[7:1] = four;
                4'h5: segments[7:1] = five;
                4'h6: segments[7:1] = six;
                4'h7: segments[7:1] = seven;
                4'h8: segments[7:1] = eight;
                4'h9: segments[7:1] = nine; 
                4'hA: segments[7:1] = letterA;
                4'hB: segments[7:1] = letterB;
                4'hC: segments[7:1] = letterC;
                4'hD: segments[7:1] = letterD;
                4'hE: segments[7:1] = letterE;
                4'hF: segments[7:1] = letterF;
                default: segments[7:1] = nothing; // everything else like X or Z - turn off the display
            endcase
        end
    end
endmodule
