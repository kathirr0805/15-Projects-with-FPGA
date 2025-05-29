module sram_rw_4bit(
    input wire clk,        // Clock signal
    input wire we,         // Write enable (1: Write, 0: Read)
    input wire [3:0] addr, // 4-bit Address (16 locations)
    input wire [3:0] din,  // 4-bit Data Input
    output reg [3:0] dout  // 4-bit Data Output
);

    // 16x4-bit SRAM memory
    reg [3:0] sram [15:0];

    always @(posedge clk) begin
        if (we)
            sram[addr] <= din;  // Write operation
        else
            dout <= sram[addr];  // Read operation
    end

endmodule
 