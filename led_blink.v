module led_blink(
    input wire clk,       // 50MHz clock input from DE0 board
    input wire rst,       // Reset button input
    output reg led        // LED output
);

    reg [24:0] counter;   // 25-bit counter for clock division

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 0;
            led <= 0;
        end else begin
            counter <= counter + 1;
            if (counter == 25_000_000) begin  // Toggle LED every 0.5s (assuming 50MHz clock)
                led <= ~led;
                counter <= 0;
            end
        end
    end

endmodule

