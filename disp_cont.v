`timescale 1ns / 1ps
/*
    Display control module
    -----Inputs:-----
    clk_i - clock from the FPGA
    rst_i - asynchronous reset (probably button)
    [4:0] ledX_i - number to be encoded for the Xth display
    00000 - MSB for enabling dot (0 active), rest 4 bits for the hex number to be displayed,
    ------Outputs:------
    led7_an_o - output display select, MSB is far left display
    led7_seg_o - output to the display, combination which segment to be displayed
*/
module disp_cont(
    input clk_i, // internal FPGA unit clock
    input rst_i, // asynchronous reset, assigned to button
    input [4:0] led1_i, // number to be encoded for certain display,
    input [4:0] led2_i, // MSB handles the dot, if 1 then it will be on
    input [4:0] led3_i, // last 4 bits are for the number to be displayed
    input [4:0] led4_i, 
    input [4:0] led5_i, 
    input [4:0] led6_i, 
    input [4:0] led7_i, 
    input [4:0] led8_i,
    output [7:0] led7_an_o, // output display select , '0' active
    output [7:0] led7_seg_o // output segment select, '0' active
    );
    
    wire [7:0] led1_o; // outputs of the encoders, led1_o for the first display to the right
    wire [7:0] led2_o; // led2_o for the next one to the left from led1_o and so on
    wire [7:0] led3_o;
    wire [7:0] led4_o;
    wire [7:0] led5_o;
    wire [7:0] led6_o;
    wire [7:0] led7_o;
    wire [7:0] led8_o;
    
    encoder Enc (
        .clk_i(clk_i),
        .rst_i(rst_i),
        .led1_i(led1_i),
        .led2_i(led2_i),
        .led3_i(led3_i),
        .led4_i(led4_i),
        .led5_i(led5_i),
        .led6_i(led6_i),
        .led7_i(led7_i),
        .led8_i(led8_i),
        .led1_o(led1_o),
        .led2_o(led2_o),
        .led3_o(led3_o),
        .led4_o(led4_o),
        .led5_o(led5_o),
        .led6_o(led6_o),
        .led7_o(led7_o),
        .led8_o(led8_o)
    );
    
    display Disp(
        .clk_i(clk_i),
        .rst_i(rst_i),
        .led1_o(led1_o),
        .led2_o(led2_o),
        .led3_o(led3_o),
        .led4_o(led4_o),
        .led5_o(led5_o),
        .led6_o(led6_o),
        .led7_o(led7_o),
        .led8_o(led8_o),
        .led7_an_o(led7_an_o),
        .led7_seg_o(led7_seg_o)
    );
    defparam Disp.refresh_rate = 1; // SIMULATION PURPOSES ONLY
    
endmodule
