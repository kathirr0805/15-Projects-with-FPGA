module clock_divider(
    input wire clk,       // 50MHz input clock
    input wire rst,       // Reset input
    output reg clk_out    // Divided clock output (1Hz)
);

    reg [25:0] counter;   // 26-bit counter for clock division

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 0;
            clk_out <= 0;
        end else begin
            if (counter >= 24_999_999) begin // Toggle every 0.5s (50M cycles per second)
                clk_out <= ~clk_out;
                counter <= 0;   // Reset counter after toggle
            end else begin
                counter <= counter + 1;
            end
        end
    end

endmodule
                                      