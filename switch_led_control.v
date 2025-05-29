module switch_led_control(
    input wire clk,       // 50MHz clock input (not required for basic switch control)
    input wire rst,       // Reset button input
    input wire sw,        // Switch input
    output reg led        // LED output
);

    always @(posedge clk or posedge rst) begin
        if (rst) 
            led <= 0;       // Reset LED to OFF state
        else 
            led <= sw;      // LED follows the switch state
    end

endmodule
   