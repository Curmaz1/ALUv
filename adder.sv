`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2024 09:20:52 PM
// Design Name: 
// Module Name: ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
module vector_alu #(
    parameter N = 4,     // Cantidad de ALUs internas
    parameter WIDTH = 8  // Ancho de las entradas y salidas
) (
    input logic clk,
    input logic arst,                // Reset asíncrono
    input logic [WIDTH-1:0] A [N-1:0], // Entradas A
    input logic [WIDTH-1:0] B [N-1:0], // Entradas B
    input logic [2:0] sel [N-1:0],   // Selección de operación (por ALU)
    input logic [N-1:0] enable,      // Bus de habilitación
    output logic [WIDTH*2-1:0] Z [N-1:0] // Salida registrada de las ALUs
);

    // Señales intermedias para las salidas combinacionales de las ALUs
    logic [WIDTH*2-1:0] alu_out [N-1:0];

    // Generar N instancias de la ALU
    genvar i;
    generate
        for (i = 0; i < N; i++) begin : ALU_INSTANCES
            // Instancia de una ALU interna
            alu #(.WIDTH(WIDTH)) alu_inst (
                .a(A[i]),
                .b(B[i]),
                .sel(sel[i]),
                .z(alu_out[i])
            );

            // Salida registrada con habilitación
            always_ff @(posedge clk or posedge arst) begin
                if (arst)
                   
                    Z[i] <= '0; // Reset de la salida
                else if (enable[i])
                    Z[i] = alu_out[i]; // Lógica combinacional 
                    //Z[i] <= alu_out[i]; // Actualizar salida
                else
                    Z[i] <= '0; // Salida en ceros si está deshabilitada
            end
        end
    endgenerate
endmodule

// ALU básica (interna)
module alu #(
    parameter WIDTH = 8
) (
    input logic [WIDTH-1:0] a, // Entradas con signo
    input logic [WIDTH-1:0] b, // Entradas con signo
    input logic [2:0] sel,            // Selección de operación
    output logic [WIDTH*2-1:0] z // Salida de la operación
);
    always_comb begin
        case (sel)
            3'b000: z = a + b;        // Suma
            3'b001: z = a - b;        // Resta
            3'b010: z = a & b;        // AND
            3'b011: z = a | b;        // OR
            3'b100: z = a * b;        // Multiplicación
            3'b101: z = (b != 0) ? a / b : '0; // División protegida contra división por cero
            default: z = '0;          // Salida por defecto
        endcase
    end
endmodule