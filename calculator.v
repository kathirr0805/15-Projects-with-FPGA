module calculator(
    input wire [3:0] A,    // First 4-bit input (Switches)
    input wire [3:0] B,    // Second 4-bit input (Switches)
    input wire [1:0] op,   // Operation select (00: Add, 01: Sub, 10: Mul, 11: Div)
    output reg [6:0] seg   // 7-segment display output (Common Anode)
);

    reg [3:0] result;      // 4-bit result
    reg [6:0] seg_lut [9:0]; // 7-segment lookup table

    // 7-segment display encoding
    initial begin
        seg_lut[0] = 7'b1000000;  // 0
        seg_lut[1] = 7'b1111001;  // 1
        seg_lut[2] = 7'b0100100;  // 2
        seg_lut[3] = 7'b0110000;  // 3
        seg_lut[4] = 7'b0011001;  // 4
        seg_lut[5] = 7'b0010010;  // 5
        seg_lut[6] = 7'b0000010;  // 6
        seg_lut[7] = 7'b1111000;  // 7
        seg_lut[8] = 7'b0000000;  // 8
        seg_lut[9] = 7'b0010000;  // 9
    end

    // Operation logic
    always @(*) begin
        case (op)
            2'b00: result = A + B;           // Addition
            2'b01: result = A - B;           // Subtraction
            2'b10: result = A * B;           // Multiplication
            2'b11: result = (B != 0) ? (A / B) : 0; // Division (avoid division by zero)
            default: result = 4'b0000;
        endcase
    end

    // Assign the 7-segment display output
    always @(*) begin
        seg = seg_lut[result % 10]; // Display only lower 4 bits (0-9)
    end

endmodule
