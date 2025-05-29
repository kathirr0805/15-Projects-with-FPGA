module lfsr_rng(
    input wire clk,  // 50MHz clock input
    input wire rst,  // Reset button
    output reg [7:0] rnd // 8-bit random number output
);

    reg [23:0] clk_div;  // 24-bit clock divider

    always @(posedge clk or posedge rst) begin
        if (rst)
            clk_div <= 0;
        else
            clk_div <= clk_div + 1;
    end

    always @(posedge clk_div[23] or posedge rst) begin
        if (rst) 
            rnd <= 8'b11010101; // Initial seed
        else 
            rnd <= {rnd[6:0], rnd[7] ^ rnd[6]}; // LFSR shift with XOR feedback
    end

endmodule
