`timescale 1ns / 1ps

/*
    display
    Module responsible for refreshing an sending binary vectors to 7-segment display
    -----Inputs:-----
    clk_i - internal FPGA unit clock
    rst_i - asynchronous reset, assigned to button
    ledX_o - converted values ready to be displayed
    ------Outputs:------
    led7_an_o - output display select, MSB is far left display
    led7_seg_o - output to the display, combination which segment to be displayed
*/

module display(
    input clk_i, // internal FPGA unit clock
    input rst_i, // asynchronous reset, assigned to button
    input [7:0] led1_o, // data to be displayed on first display
    input [7:0] led2_o, // data to be displayed on second display
    input [7:0] led3_o, // ...
    input [7:0] led4_o, 
    input [7:0] led5_o, 
    input [7:0] led6_o, 
    input [7:0] led7_o, 
    input [7:0] led8_o, 
    output [7:0] led7_an_o, // output display select , '0' active
    output [7:0] led7_seg_o // output segment select, '0' active
    );
    
    reg [7:0] anodes = 8'hFF;
    assign led7_an_o = anodes;
    reg [7:0] segments = 8'hFF;
    assign led7_seg_o = segments;
    
    reg [2:0] refresh_counter = 0; // counter for refresh rate,
    
    wire pulse;
    parameter refresh_rate = 100_000;
    clock_divider Counter(
        .CLK100MHZ(clk_i),
        .reset(rst_i),
        .pulse(pulse)
    );
    defparam Counter.divider = refresh_rate; // 1kHz refresh rate
    // decoder to generate anode signals 
    always @(posedge pulse or posedge rst_i) begin
        if (rst_i) begin
            segments = 8'hFF; // segments will be off
            anodes = 8'hFF; // displays will be off
            refresh_counter = 3'b000; // reset the counter
        end
        else begin
            case(refresh_counter)
            3'b000: begin
                // activate LED8
                anodes = 8'b01111111; 
                // display LED8
                segments = led8_o;
                end
            3'b001: begin
                // activate LED7
                anodes = 8'b10111111; 
                // display LED7
                segments = led7_o;
                end
            3'b010: begin
                // activate LED6
                anodes = 8'b11011111;
                // display LED6
                segments = led6_o;
                end
            3'b011: begin
                // activate LED5
                anodes = 8'b11101111;
                // display LED5
                segments = led5_o;    
                end
            3'b100: begin
                // activate LED4
                anodes = 8'b11110111;
                // display LED4
                segments = led4_o;    
                end
            3'b101: begin
                // activate LED3
                anodes = 8'b11111011;
                // display LED3
                segments = led3_o;    
                end
            3'b110: begin
                // activate LED2
                anodes = 8'b11111101;
                // display LED2
                segments = led2_o;    
                end
            3'b111: begin
                // activate LED1
                anodes = 8'b11111110;
                // display LED1
                segments = led1_o;    
                end
            endcase
            refresh_counter = refresh_counter + 1;
        end 
    end
    
endmodule
