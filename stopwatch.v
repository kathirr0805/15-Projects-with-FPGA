module stopwatch(
    input wire clk,      // 50MHz clock input
    input wire rst,      // Reset button
    input wire start,    // Start button
    input wire stop,     // Stop button
    output reg [6:0] seg1, // Tens place 7-segment display
    output reg [6:0] seg0  // Ones place 7-segment display
);

    reg [6:0] seg_lut [9:0];  // Lookup table for 7-segment display
    reg [3:0] counter_ones;    // Ones place counter
    reg [3:0] counter_tens;    // Tens place counter
    reg [25:0] clk_div;        // Clock divider for 1-second delay
    reg running;               // Status flag for stopwatch

    reg start_prev, stop_prev;  // Edge detection for buttons

    // 7-segment display encoding (Common Anode)
    initial begin
        seg_lut[0] = 7'b1000000; // 0
        seg_lut[1] = 7'b1111001; // 1
        seg_lut[2] = 7'b0100100; // 2
        seg_lut[3] = 7'b0110000; // 3
        seg_lut[4] = 7'b0011001; // 4
        seg_lut[5] = 7'b0010010; // 5
        seg_lut[6] = 7'b0000010; // 6
        seg_lut[7] = 7'b1111000; // 7
        seg_lut[8] = 7'b0000000; // 8
        seg_lut[9] = 7'b0010000; // 9
    end

    // Edge detection for start/stop
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            running <= 0;
            start_prev <= 0;
            stop_prev <= 0;
        end else begin
            if (start && !start_prev) // Detect rising edge of start
                running <= 1;
            if (stop && !stop_prev)   // Detect rising edge of stop
                running <= 0;

            start_prev <= start;  // Store previous state of start button
            stop_prev <= stop;    // Store previous state of stop button
        end
    end

    // Clock divider and counter update logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter_ones <= 0;
            counter_tens <= 0;
            clk_div <= 0;
        end else if (running) begin
            clk_div <= clk_div + 1;
            if (clk_div >= 50_000_000) begin // 1-second delay (50 MHz clock)
                clk_div <= 0;
                if (counter_ones == 9) begin
                    counter_ones <= 0;
                    if (counter_tens == 9)
                        counter_tens <= 0;
                    else
                        counter_tens <= counter_tens + 1;
                end else begin
                    counter_ones <= counter_ones + 1;
                end
            end
        end
    end

    // Assign lookup table values to segment displays
    always @(*) begin
        seg0 = seg_lut[counter_ones];
        seg1 = seg_lut[counter_tens];
    end

endmodule
