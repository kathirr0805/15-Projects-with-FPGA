module binary_counter(
    input wire clk,      
    input wire rst,      
    output reg [3:0] led 
);

    reg [24:0] counter;  // 25-bit counter for slowing down

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 0;
            led <= 4'b0000;
        end else begin
            counter <= counter + 1;
            if (counter == 25_000_000) begin // Toggle every 0.5s
                led <= led + 1;
                counter <= 0;
            end
        end
    end
 
endmodule
