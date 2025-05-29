// Traffic light controller module
module traffic_light_controller(
    output reg [1:0] hwy,    // Highway signal: RED, YELLOW, GREEN
    output reg [1:0] cntry,   // Country road signal: RED, YELLOW, GREEN
    input wire X,            // Car detected on country road
    input wire clock,        // Clock signal
    input wire clear         // Clear/reset signal
);

    // Parameter definitions
    parameter Y2RDELAY = 3;  // Yellow-to-red delay in clock cycles
    parameter R2GDELAY = 2;  // Red-to-green delay in clock cycles

    // Internal variables
    reg [3:0] counter;     // Counter for delays
    reg delay_active;      // Indicates if a delay is in progress
    reg is_country_priority; // Indicates if country road has priority

    // Sequential logic (triggered by clock or reset)
    always @(posedge clock or posedge clear) begin
        if (clear) begin
            hwy <= 2'b10;  // Highway GREEN
            cntry <= 2'b00; // Country road RED
            counter <= 0;
            delay_active <= 0;
            is_country_priority <= 0;
        end else begin
            if (delay_active) begin
                if (counter > 0) 
                    counter <= counter - 1;
                else 
                    delay_active <= 0;
            end else begin
                if (X && !is_country_priority) begin
                    // Car detected on country road
                    delay_active <= 1;
                    counter <= Y2RDELAY;
                    hwy <= 2'b01;  // Highway YELLOW
                    cntry <= 2'b00; // Country RED
                    is_country_priority <= 1;
                end else if (is_country_priority && X) begin
                    // Country road remains prioritized
                    delay_active <= 1;
                    counter <= R2GDELAY;
                    hwy <= 2'b00;  // Highway RED
                    cntry <= 2'b10; // Country GREEN
                end else if (!X && is_country_priority) begin
                    // No car on country road; return to highway priority
                    delay_active <= 1;
                    counter <= Y2RDELAY;
                    hwy <= 2'b00;  // Highway RED
                    cntry <= 2'b01; // Country YELLOW
                    is_country_priority <= 0;
                end else begin
                    // Maintain highway GREEN
                    hwy <= 2'b10;
                    cntry <= 2'b00;
                end
            end
        end
    end
endmodule
