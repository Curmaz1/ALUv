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
    input [INPUT_WIDTH-1:0] A [ALUs_num],
    input [INPUT_WIDTH-1:0] B [ALUs_num],
    input [3:0] opcode,
    output [2*INPUT_WIDTH-1:0] result [ALUs_num]
);
    genvar i;
    generate
        for (i = 0; i < ALUs_num; i = i + 1) begin : ALU_INST
            ALU #(INPUT_WIDTH) alu_inst (
                .a(A[i]),
                .b(B[i]),
                .opcode(opcode),
                .result(result[i])
            );
        end
    endgenerate
endmodule
