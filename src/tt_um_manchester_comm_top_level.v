`timescale 1ns/1ps

module tt_um_manchester_comm_top_level #(
    parameter DELAY_VAL = 168,
    parameter POLARITY  = 1'b0
)(
    input  wire clk_sys,      // Reloj del sistema
    input  wire clk_bit,      // Reloj de la tasa de bits (frecuencia de transmisión)
    input  wire data_in,      // Dato original a enviar
    output wire tx_manchester,// Señal codificada (lo que viaja por el cable)
    output wire rx_data_out   // Dato recuperado por el decoder
);

    // 1. Instancia del Encoder (Transmisor)
    manchester_encoder #(
        .INVERT_POLARITY(POLARITY)
    ) encoder_inst (
        .clk_bit(clk_bit),
        .data_bit(data_in),
        .manchester_out(tx_manchester)
    );

    // 2. Conexión física simulada
    // Aquí podrías añadir ruido o jitter si estuvieras haciendo un testbench avanzado.
    wire channel = tx_manchester;

    // 3. Instancia del Decoder (Receptor)
    manchester_decoder #(
        .DELAY_NS(DELAY_VAL)
    ) decoder_inst (
        .clk_sys(clk_sys),
        .manchester_in(channel),
        .data_bit_recovered(rx_data_out)
    );

endmodule