`timescale 1ns/1ps

// Manchester encoder (IEEE 802.3 convention)
// Salida = data_bit XOR clk_bit (1 => alta→baja en mitad de bit, 0 => baja→alta)
module manchester_encoder #(
    parameter INVERT_POLARITY = 1'b0  // 0: estándar IEEE 802.3, 1: invertido
) (
    input  wire clk_bit,
    input  wire data_bit,
    output wire manchester_out
);

    wire core = data_bit ^ clk_bit;
    assign manchester_out = INVERT_POLARITY ? ~core : core;

endmodule


