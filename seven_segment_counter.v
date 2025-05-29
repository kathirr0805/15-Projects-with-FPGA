module seven_segment_counter(
    input wire clk,      // 50MHz clock input
    input wire rst,      // Reset input
    output reg [6:0] seg// 7-segment display output (Common Anode)
  
);

    reg [3:0] count;     // 4-bit counter
    reg [24:0] clk_div;  // Clock divider to slow down counting

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            clk_div <= 0;
            count <= 0;
        end else begin
            clk_div <= clk_div + 1;
            if (clk_div == 25_000_000) begin  // Increment every 0.5s
                count <= (count == 9) ? 0 : count + 1;
                clk_div <= 0;
            end
        end
    end

    always @(*) begin
        case (count)
            4'b0000: seg = 7'b1000000; // 0
            4'b0001: seg = 7'b1111001; // 1
            4'b0010: seg = 7'b0100100; // 2
            4'b0011: seg = 7'b0110000; // 3
            4'b0100: seg = 7'b0011001; // 4
            4'b0101: seg = 7'b0010010; // 5
            4'b0110: seg = 7'b0000010; // 6
            4'b0111: seg = 7'b1111000; // 7
            4'b1000: seg = 7'b0000000; // 8
            4'b1001: seg = 7'b0010000; // 9
            default: seg = 7'b1111111; // OFF
        endcase
    end

   

endmodule
