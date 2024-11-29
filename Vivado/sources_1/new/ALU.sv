`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/23/2024 10:32:32 PM
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

module adder #(parameter IN_WIDTH = 8, parameter OUT_WIDTH = 2*IN_WIDTH) (
  input wire [IN_WIDTH-1:0] a, b,
  output wire [OUT_WIDTH-1:0] sum
);

  assign sum = a + b;
endmodule : adder

module substractor #(parameter IN_WIDTH = 8, parameter OUT_WIDTH = 2*IN_WIDTH) (
  input wire [IN_WIDTH-1:0] a, b,
  output wire [OUT_WIDTH-1:0] diff
);

  assign diff = a - b;
endmodule : substractor

module bitwise_and #(parameter IN_WIDTH = 8, parameter OUT_WIDTH = 2*IN_WIDTH) (
  input wire [IN_WIDTH-1:0] a, b,
  output wire [OUT_WIDTH-1:0] b_and
);

  assign b_and = a & b;
endmodule : bitwise_and

module bitwise_or #(parameter IN_WIDTH = 8, parameter OUT_WIDTH = 2*IN_WIDTH) (
  input wire [IN_WIDTH-1:0] a, b,
  output wire [OUT_WIDTH-1:0] b_or
);

  assign b_or = a | b;
endmodule : bitwise_or

module bitwise_xor #(parameter IN_WIDTH = 8, parameter OUT_WIDTH = 2*IN_WIDTH) (
  input wire [IN_WIDTH-1:0] a, b,
  output wire [OUT_WIDTH-1:0] b_xor
);

  assign b_xor = a ^ b;
endmodule : bitwise_xor

module comparator #(parameter IN_WIDTH = 8) (
  input wire [IN_WIDTH-1:0] a, b,
  output wire a_greater, a_equal, a_less
);

  assign a_greater = (a > b);
  assign a_equal = (a == b);
  assign a_less = (a < b);
endmodule : comparator

module left_shift #(parameter IN_WIDTH = 8, parameter OUT_WIDTH = 2*IN_WIDTH) (
  input wire [IN_WIDTH-1:0] a,
  input wire [IN_WIDTH-1:0] shift,
  output wire [OUT_WIDTH-1:0] left_shift
);
  assign left_shift = (a << shift);
endmodule : left_shift

module right_shift #(parameter IN_WIDTH = 8, parameter OUT_WIDTH = 2*IN_WIDTH)(
  input wire [IN_WIDTH-1:0] a,
  input wire [IN_WIDTH-1:0] shift,
  output wire [OUT_WIDTH-1:0] right_shift
);
  assign right_shift = a >> shift;
endmodule : right_shift

module multiplicator #(parameter IN_WIDTH = 8, parameter OUT_WIDTH = 2*IN_WIDTH) (
  input wire [IN_WIDTH-1:0] a, b,
  output wire [OUT_WIDTH-1:0] multiplication
);

  assign multiplication = a * b;
endmodule : multiplicator

module division #(parameter IN_WIDTH = 8, parameter OUT_WIDTH = 2*IN_WIDTH) (
  input wire [IN_WIDTH-1:0] a, b,
  output wire [OUT_WIDTH-1:0] division
);

  assign division = a / b;
endmodule : division


module ALU #(parameter IN_WIDTH = 8) (
    input wire [IN_WIDTH-1:0] a, b,
    input wire [3:0] opcode,
    input wire enable,
	  output wire [IN_WIDTH*2-1:0] result,
  	output wire a_greater_out, a_equal_out, a_less_out
);
    parameter OUT_WIDTH = IN_WIDTH*2;

    wire [OUT_WIDTH-1:0] result_add;
    wire [OUT_WIDTH-1:0] result_sub;
    wire [OUT_WIDTH-1:0] result_and;
    wire [OUT_WIDTH-1:0] result_or;
    wire [OUT_WIDTH-1:0] result_xor;
    wire [OUT_WIDTH-1:0] result_l_shift;
    wire [OUT_WIDTH-1:0] result_r_shift;
    wire [OUT_WIDTH-1:0] result_mul;
  	wire [OUT_WIDTH-1:0] result_div;
  	wire a_greater, a_equal, a_less;

  	adder #(IN_WIDTH) u_adder (
      a, b, result_add
    );
  
    substractor #(IN_WIDTH) u_substractor (
      a, b, result_sub
    );
  
 	 bitwise_and #(IN_WIDTH) u_bitwise_and (
      a, b, result_and
     );
  
  	bitwise_or #(IN_WIDTH) u_bitwise_or (
      a, b, result_or
    );
  
    bitwise_xor #(IN_WIDTH) u_bitwise_xor(
      a, b, result_xor
    );
  
  comparator #(IN_WIDTH) u_comparator (
      .a(a),
      .b(b),
      .a_greater(a_greater),
      .a_equal(a_equal),
      .a_less(a_less)
  	);
  
    left_shift #(IN_WIDTH) u_left_shift (
      .a(a),
      .shift(b),
      .left_shift(result_l_shift)
    );
  
    right_shift #(IN_WIDTH) u_right_shift (
      .a(a),
      .shift(b),
      .right_shift(result_r_shift)
    );
  
    multiplicator #(IN_WIDTH) u_multiplicator (
      .a(a),
      .b(b),
      .multiplication(result_mul)
    );
  
  division #(IN_WIDTH) u_division (
      .a(a),
      .b(b),
    .division(result_div)
    );

assign result = enable ? (opcode == 4'b0000 ? result_add :
                          opcode == 4'b0001 ? result_sub :
                          opcode == 4'b0010 ? result_and :
                          opcode == 4'b0011 ? result_or :
                          opcode == 4'b0100 ? result_xor :
                          opcode == 4'b0101 ? result_l_shift :
                          opcode == 4'b0110 ? result_r_shift :
                          opcode == 4'b0111 ? result_mul :
                          opcode == 4'b1000 ? result_div : {OUT_WIDTH{1'b0}})
                        : {OUT_WIDTH{1'b0}};

assign a_greater_out = enable && (opcode == 4'b1001) ? a_greater : 1'b0;
assign a_equal_out = enable && (opcode == 4'b1001) ? a_equal : 1'b0;
assign a_less_out = enable && (opcode == 4'b1001) ? a_less : 1'b0;

endmodule : ALU

