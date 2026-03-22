`timescale 1ns / 1ps

/*
    encoder
    Module resposible for converting input hex value with dot to binary output for display
    -----Inputs:-----
    clk_i - internal FPGA unit clock
    rst_i - asynchronous reset, assigned to button
    ledX_i - values which entered disp_cont and which will be converted
    ------Outputs:------
    ledX_o - converted values ready to be displayed
*/

module encoder (
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
    output [7:0] led1_o, // outputs of the encoders, led1_o for the first display to the right
    output [7:0] led2_o, // led2_o for the next one to the left from led1_o and so on
    output [7:0] led3_o,
    output [7:0] led4_o,
    output [7:0] led5_o,
    output [7:0] led6_o,
    output [7:0] led7_o,
    output [7:0] led8_o
    );
    
    // below are 8 encoders, each one for certain display
    // En1 is for the first display to the right, rest goes on to the last one to the left
    
    encoder_cell En1 (
        .clk_i(clk_i),
        .rst_i(rst_i),
        .num_i(led1_i),
        .dig_o(led1_o)
    );
    
    encoder_cell En2 (
        .clk_i(clk_i),
        .rst_i(rst_i),
        .num_i(led2_i),
        .dig_o(led2_o)
    );
    
    encoder_cell En3 (
        .clk_i(clk_i),
        .rst_i(rst_i),
        .num_i(led3_i),
        .dig_o(led3_o)
    );
    
    encoder_cell En4 (
        .clk_i(clk_i),
        .rst_i(rst_i),
        .num_i(led4_i),
        .dig_o(led4_o)
    );
    
    encoder_cell En5 (
        .clk_i(clk_i),
        .rst_i(rst_i),
        .num_i(led5_i),
        .dig_o(led5_o)
    );
    
    encoder_cell En6 (
        .clk_i(clk_i),
        .rst_i(rst_i),
        .num_i(led6_i),
        .dig_o(led6_o)
    );
    
    encoder_cell En7 (
        .clk_i(clk_i),
        .rst_i(rst_i),
        .num_i(led7_i),
        .dig_o(led7_o)
    );
    
    encoder_cell En8 (
        .clk_i(clk_i),
        .rst_i(rst_i),
        .num_i(led8_i),
        .dig_o(led8_o)
    );
    
endmodule
