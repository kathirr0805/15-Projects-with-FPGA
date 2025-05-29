module debounce(
    input wire clk,       // 50MHz clock input
    input wire btn,       // Noisy push-button input
    output reg btn_clean  // Debounced output
);

    reg [19:0] counter;   // 20-bit counter for debounce delay
    reg btn_state;        // Stores stable button state

    always @(posedge clk) begin
        if (btn != btn_state) begin
            counter <= 0;  // Reset counter if button state changes
        end else if (counter < 1_000_000) begin
            counter <= counter + 1;  // Count stable time
        end else begin
            btn_clean <= ~btn_state; // Update debounced output
        end
        btn_state <= btn;  // Store current button state
    end

endmodule
