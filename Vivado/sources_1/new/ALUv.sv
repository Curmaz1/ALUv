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
    input [INPUT_WIDTH-1:0] A, B [ALUs_num],
    input enable,
    input [3:0] opcode,
    output [2*INPUT_WIDTH-1:0] result [ALUs_num],
    output [ALUs_num-1:0] a_greater_out, a_equal_out, a_less_out
);
    genvar i;
    generate
        for (i = 0; i < ALUs_num; i = i + 1) begin : ALU_INST
            ALU #(INPUT_WIDTH) alu_inst (
                .a(A[i]),
                .b(B[i]),
                .enable(enable),
                .opcode(opcode),
                .result(result[i]),
                .a_equal_out(a_equal_out[i]),
                .a_greater_out(a_greater_out[i]),
                .a_less_out(a_less_out[i])
            );
        end
    endgenerate
endmodule
