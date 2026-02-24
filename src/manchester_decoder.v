module manchester_decoder_synth #(
    parameter integer BIT_PERIOD_CLKS = 100 // Duración de 1 bit en ciclos de clk_sys
)(
    input  wire clk_sys,
    input  wire rst,
    input  wire manchester_in,
    output reg  data_out,
    output reg  valid_pulse
);
    reg [15:0] timer;
    reg last_in;
    
    // Detector de flancos para sincronizar
    wire edge_detected = (manchester_in != last_in);

    always @(posedge clk_sys) begin
        if (rst) begin
            timer <= 0;
            last_in <= 0;
        end else begin
            last_in <= manchester_in;
            
            if (edge_detected) begin
                timer <= 0; // Reiniciamos en cada transición
            end else if (timer < BIT_PERIOD_CLKS) begin
                timer <= timer + 1;
            end

            // Muestreamos a los 3/4 del periodo del bit
            if (timer == (BIT_PERIOD_CLKS * 3 / 4)) begin
                data_out <= manchester_in;
                valid_pulse <= 1;
            end else begin
                valid_pulse <= 0;
            end
        end
    end
endmodule