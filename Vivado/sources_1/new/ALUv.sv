`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2024 11:48:03 PM
// Design Name: 
// Module Name: ALUv
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

module ALUv #(
    parameter ALUs_num = 4,
    parameter INPUT_WIDTH = 8
)(
    input clk,
    input [INPUT_WIDTH-1:0] A, B [ALUs_num],
    input enable,
    input [3:0] opcode,
    output reg [2*INPUT_WIDTH-1:0] result [ALUs_num],
    output reg [ALUs_num-1:0] a_greater_out, a_equal_out, a_less_out
);

    wire [2*INPUT_WIDTH-1:0] alu_result [ALUs_num];
    wire [ALUs_num-1:0] alu_a_greater_out, alu_a_equal_out, alu_a_less_out;
    
    genvar i;
    generate
        for (i = 0; i < ALUs_num; i = i + 1) begin : ALU_INST
            ALU #(INPUT_WIDTH) alu_inst (
                .a(A[i]),
                .b(B[i]),
                .enable(enable),
                .opcode(opcode),
                .result(alu_result[i]),
                .a_equal_out(alu_a_equal_out[i]),
                .a_greater_out(alu_a_greater_out[i]),
                .a_less_out(alu_a_less_out[i])
            );
        end
    endgenerate
    
    integer j;
    always @(posedge clk) begin
        for (j = 0; j < ALUs_num; j = j + 1) begin
            result[j] <= alu_result[j];
            a_greater_out[j] <= alu_a_greater_out[j];
            a_equal_out[j] <= alu_a_equal_out[j];
            a_less_out[j] <= alu_a_less_out[j];
        end
    end

endmodule
