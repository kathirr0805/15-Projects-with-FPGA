module led_chaser(
    input wire clk,       // 50MHz clock input
    input wire rst,       // Reset input
    output reg [7:0] led  // 8-bit LED output
);

    reg [24:0] counter;   // Counter for slowing down LED movement

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 0;
            led <= 8'b00000001; // Start with first LED ON
        end else begin
            counter <= counter + 1;
            if (counter == 25_000_000) begin // Change LED every 0.5s
                led <= {led[6:0], led[7]}; // Shift bits left in circular manner
                counter <= 0;
            end
        end
    end

endmodule 