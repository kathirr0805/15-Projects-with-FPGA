module vga_shapes (
    input wire CLOCK_50,        // 50MHz clock input (PIN_G21)
    input wire [9:0] SW,        // Slide switches (see pin assignments)
    output wire [3:0] VGA_R,    // VGA Red (Pins H19,H17,H20,H21)
    output wire [3:0] VGA_G,    // VGA Green (Pins H22,J17,K17,J21)
    output wire [3:0] VGA_B,    // VGA Blue (Pins K22,K21,J22,K18)
    output wire VGA_HS,         // VGA H_SYNC (PIN_L21)
    output wire VGA_VS          // VGA V_SYNC (PIN_L22)
);

// 640x480 @ 60Hz VGA timing parameters (values in pixels/lines)
parameter H_DISPLAY = 640;   // Horizontal display area
parameter H_FP = 16;         // Horizontal front porch
parameter H_SYNC = 96;       // Horizontal sync pulse
parameter H_BP = 48;         // Horizontal back porch
parameter H_TOTAL = H_DISPLAY + H_FP + H_SYNC + H_BP; // 800 total

parameter V_DISPLAY = 480;   // Vertical display area
parameter V_FP = 10;         // Vertical front porch
parameter V_SYNC = 2;        // Vertical sync pulse
parameter V_BP = 33;         // Vertical back porch
parameter V_TOTAL = V_DISPLAY + V_FP + V_SYNC + V_BP; // 525 total

// Shape colors (12-bit RGB: 4 bits per color)
parameter COLOR_BG = 12'hFFF;   // White background
parameter COLOR_RECT = 12'hF00; // Red rectangle
parameter COLOR_CIRC = 12'h0F0; // Green circle
parameter COLOR_TRI = 12'h00F;  // Blue triangle

// Shape positions and sizes
parameter RECT_X = 100;
parameter RECT_Y = 100;
parameter RECT_W = 150;
parameter RECT_H = 100;

parameter CIRC_X = 400;
parameter CIRC_Y = 150;
parameter CIRC_R = 75;

parameter TRI_X1 = 300;
parameter TRI_Y1 = 350;
parameter TRI_X2 = 450;
parameter TRI_Y2 = 350;
parameter TRI_X3 = 375;
parameter TRI_Y3 = 250;

// Internal signals
reg [9:0] h_count = 0;
reg [9:0] v_count = 0;
reg h_sync, v_sync;
reg h_blank, v_blank;
reg [11:0] rgb;
reg pixel_clock = 0;

// Generate 25MHz pixel clock from 50MHz system clock
always @(posedge CLOCK_50) begin
    pixel_clock <= ~pixel_clock;
end

// Horizontal and vertical counters
always @(posedge pixel_clock) begin
    if (h_count == H_TOTAL - 1) begin
        h_count <= 0;
        if (v_count == V_TOTAL - 1)
            v_count <= 0;
        else
            v_count <= v_count + 1;
    end
    else begin
        h_count <= h_count + 1;
    end
end

// Sync signal generation (active low)
always @(posedge pixel_clock) begin
    // Horizontal sync
    h_sync <= ~((h_count >= H_DISPLAY + H_FP) && 
              (h_count < H_DISPLAY + H_FP + H_SYNC));
              
    // Vertical sync
    v_sync <= ~((v_count >= V_DISPLAY + V_FP) && 
              (v_count < V_DISPLAY + V_FP + V_SYNC));
              
    // Blanking signals
    h_blank <= (h_count >= H_DISPLAY);
    v_blank <= (v_count >= V_DISPLAY);
end

// Current pixel position
wire [9:0] x_pos = h_count;
wire [9:0] y_pos = v_count;

// Display area flag
wire display_area = (h_count < H_DISPLAY) && (v_count < V_DISPLAY);

// Shape drawing functions
wire in_rect = (x_pos >= RECT_X) && (x_pos < RECT_X + RECT_W) && 
               (y_pos >= RECT_Y) && (y_pos < RECT_Y + RECT_H);

wire in_circ = ((x_pos - CIRC_X) * (x_pos - CIRC_X) + 
                (y_pos - CIRC_Y) * (y_pos - CIRC_Y)) <= (CIRC_R * CIRC_R);


// Triangle area function (using barycentric coordinates)
wire in_tri = ((TRI_X2-TRI_X1)*(y_pos-TRI_Y1)-(TRI_Y2-TRI_Y1)*(x_pos-TRI_X1) >= 0) &&
              ((TRI_X3-TRI_X2)*(y_pos-TRI_Y2)-(TRI_Y3-TRI_Y2)*(x_pos-TRI_X2) >= 0) &&
              ((TRI_X1-TRI_X3)*(y_pos-TRI_Y3)-(TRI_Y1-TRI_Y3)*(x_pos-TRI_X3) >= 0);

// RGB output
always @(posedge pixel_clock) begin
    if (display_area) begin
        if (in_rect && SW[0])
            rgb <= COLOR_RECT;
        else if (in_circ && SW[1])
            rgb <= COLOR_CIRC;
        else if (in_tri && SW[2])
            rgb <= COLOR_TRI;
        else
            rgb <= COLOR_BG;
    end
    else begin
        rgb <= 12'h000; // Blanking
    end
end

// Output assignments
assign VGA_R = rgb[11:8];
assign VGA_G = rgb[7:4];
assign VGA_B = rgb[3:0];
assign VGA_HS = h_sync;
assign VGA_VS = v_sync;

endmodule