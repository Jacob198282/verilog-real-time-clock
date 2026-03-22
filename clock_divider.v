`timescale 1ns / 1ps

module clock_divider(
    input CLK100MHZ, // input clock from the Nexys7 board - 100 MHz
    input reset, // asynchronous reset
    output pulse // 1 second long pulse generated clock divider - default
    );
    
    reg [26:0] counter = 0;  
    // 100,000,000 cycles = 1 sec
    parameter divider = 100_000_000;
    
    reg divided_clock = 0;
    assign pulse = divided_clock;
    
    always @(posedge CLK100MHZ or posedge reset) begin
        if (reset) begin // if the reset is on (logic 1)
            counter <= 0;
            divided_clock <= 0;
        end else begin // if the reset is off (logic 0)
            if (counter >= divider - 1) begin
                counter <= 0;
                divided_clock <= ~divided_clock;
            end else begin
                counter <= counter + 1;
                divided_clock <= divided_clock;
            end
        end
    end

endmodule