//`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.11.2024 10:54:50
// Design Name: 
// Module Name: ALU_tb
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

module ALU_tb;

    parameter ALU_WIDTH = 8;
    
    ALU_intf #(ALU_WIDTH) ALU_intf_i();
    
    ALU #(ALU_WIDTH) DUT (
        .a(ALU_intf_i.a),    // conectamos el puerto result del DUT con la variable result de la instancia de la interface
        .b(ALU_intf_i.b),
        .result(ALU_intf_i.result),
        .a_greater_out(ALU_intf_i.a_greater_out),
        .a_equal_out(ALU_intf_i.a_equal_out),
        .a_less_out(ALU_intf_i.a_less_out),
        .opcode(ALU_intf_i.opcode)
    );
 
    bit clk;
    always #1 clk = !clk;
     
// ************************************ DEF TESTS BEGIN ************************************

//`define TEST1
//`define TEST2
//`define TEST3
//`define TEST4
`define TEST5

`ifdef TEST1 
    // Prueba 3 - 
    //////////////////////////////////////////////
    // 2. Generar 1000 operaciones              //
    // con valores random                       //
    //////////////////////////////////////////////
    initial begin
        repeat(1000) begin
            @(posedge clk); 
                ALU_intf_i.a_b_op_random(); 
        end     
    end

  
`elsif TEST2 
    // Prueba 2 - 
    ////////////////////////////////////////////////
    // 1. Generar 100 sumas aleatorias            //                   
    // 2. Generar 100 restas aleatorias           //
    // 3. Generar 100 multiplicaciones aleatorias //
    // 4. Generar 100 divisiones aleatorias       //
    //////////////////////////////////////////////// 
    initial begin
        repeat(100)      // 1. suma
            begin
                @(posedge clk);  
                    ALU_intf_i.add_a_b_random();            
            end
        repeat(100)      // 2. resta
            begin
                @(posedge clk); 
                    ALU_intf_i.sub_a_b_random();              
            end
        repeat(100)       // 3. mul
            begin
                @(posedge clk);      
                    ALU_intf_i.mul_a_b_random();
            end        
        repeat(100)      // 4. div
            begin
                @(posedge clk);  
                    ALU_intf_i.div_a_b_random();       
            end
        @(posedge clk); 
            $finish;     
    end

`elsif TEST3
    // Prueba 3 - 
    ////////////////////////////////////////////////
    // 1. Generar 20 sumas con ceros              //                   
    // 2. Generar 20 restas con ceros             //
    // 3. Generar 20 multiplicaciones con ceros   //
    ////////////////////////////////////////////////
    initial begin
        repeat(20)      // 1. suma
            begin
                @(posedge clk);  
                    ALU_intf_i.add_a_b_zero();            
            end
        repeat(20)      // 2. resta
            begin
                @(posedge clk); 
                    ALU_intf_i.sub_a_b_zero();              
            end
        repeat(20)       // 3. mul
            begin
                @(posedge clk);      
                    ALU_intf_i.mul_a_b_zero();
            end        
        @(posedge clk); 
            $finish;     
        end
        
`elsif TEST4
    // Prueba 4 - 
    ////////////////////////////////////////////////
    // 1. Generar 300 operaciones con a = 0       //                   
    // 2. Generar 3000 operaciones con b = 0      //
    ////////////////////////////////////////////////
    initial begin
        repeat(300)      // 1. suma
            begin
                @(posedge clk);  
                    ALU_intf_i.a_zero_b_op_random();            
            end
        repeat(300)      // 2. resta
            begin
                @(posedge clk); 
                    ALU_intf_i.b_zero_a_op_random();              
            end        
        @(posedge clk); 
            $finish;     
        end 

`elsif TEST5

`endif

// ************************************* DEF TESTS END *************************************  

covergroup add_cg @(posedge clk);
    a_cp:coverpoint ALU_intf_i.a{
        bins a[] = {[0:255]};
    }
    b_cp:coverpoint ALU_intf_i.b{
        bins b[] = {[0:255]};
    }
    result_cp: coverpoint ALU_intf_i.result{
    bins result[] = {[0:65535]};
    }
    a_gt_cp: coverpoint ALU_intf_i.a_greater_out{
    bins result[] = {[0:1]};
    }    
    a_et_cp: coverpoint ALU_intf_i.a_equal_out{
    bins result[] = {[0:1]};
    }     
    a_lt_cp: coverpoint ALU_intf_i.a_less_out{
    bins result[] = {[0:1]};
    }   
    a_opcode_cp: coverpoint ALU_intf_i.opcode{
    bins result[] = {[0:1]};
    }       
endgroup

  cg_adder cg_inst = new();

endmodule


// ************************************ Interface start ************************************

interface  ALU_intf #(parameter WIDTH = 8) ();
    
    logic [WIDTH-1:0] a;
    logic [WIDTH-1:0] b;
    logic [WIDTH*2-1:0] result;
    logic a_greater_out, a_equal_out, a_less_out; 
    logic [3:0] opcode;
 // BFM - Bus Functional Model //  
    function a_b_op_random(); 
        std::randomize(a);
        std::randomize(b);      
        std::randomize(opcode) with{opcode<'h10;};   
    endfunction
    function add_a_b_random(); 
        std::randomize(a);
        std::randomize(b);      
        opcode = 0;    
    endfunction
     function sub_a_b_random(); 
        std::randomize(a);
        std::randomize(b);      
        opcode = 1;     
     endfunction
     function mul_a_b_random(); 
        std::randomize(a);
        std::randomize(b);      
        opcode = 8;
     endfunction           
     function div_a_b_random(); 
        std::randomize(a);
        std::randomize(b);      
        opcode = 9;      
    endfunction   
    function add_a_b_zero(); 
        a = 0;
        b = 0;      
        opcode = 0;    
    endfunction    
     function sub_a_b_zero(); 
        a = 0;
        b = 0;      
        opcode = 1;     
     endfunction    
     function mul_a_b_zero(); 
        a = 0;
        b = 0;      
        opcode = 8;
     endfunction  
    function a_zero_b_op_random(); 
        a = 0;
        std::randomize(b);      
        std::randomize(opcode) with{opcode<'h10;};
    endfunction          
    function b_zero_a_op_random(); 
        std::randomize(a);
        b = 0;      
        std::randomize(opcode) with{opcode<'h10;};     
    endfunction 
     
endinterface: ALU_intf
