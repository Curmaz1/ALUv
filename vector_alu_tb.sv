`define CREATE_COVERGROUP_BASIC(name) \
    covergroup name; \
        cp_a0 : coverpoint alu_if_inst.A[0] { option.auto_bin_max = bins_nums; } \
        cp_a1 : coverpoint alu_if_inst.A[1] { option.auto_bin_max = bins_nums; } \
        cp_a2 : coverpoint alu_if_inst.A[2] { option.auto_bin_max = bins_nums; } \
        cp_a3 : coverpoint alu_if_inst.A[3] { option.auto_bin_max = bins_nums; } \
        cp_b0 : coverpoint alu_if_inst.B[0] { option.auto_bin_max = bins_nums; } \
        cp_b1 : coverpoint alu_if_inst.B[1] { option.auto_bin_max = bins_nums; } \
        cp_b2 : coverpoint alu_if_inst.B[2] { option.auto_bin_max = bins_nums; } \
        cp_b3 : coverpoint alu_if_inst.B[3] { option.auto_bin_max = bins_nums; } \
    endgroup

`define CREATE_COVERGROUP_WITH_SEL(name) \
    covergroup name; \
        cp_a0 : coverpoint alu_if_inst.A[0] { option.auto_bin_max = bins_nums; } \
        cp_a1 : coverpoint alu_if_inst.A[1] { option.auto_bin_max = bins_nums; } \
        cp_a2 : coverpoint alu_if_inst.A[2] { option.auto_bin_max = bins_nums; } \
        cp_a3 : coverpoint alu_if_inst.A[3] { option.auto_bin_max = bins_nums; } \
        cp_b0 : coverpoint alu_if_inst.B[0] { option.auto_bin_max = bins_nums; } \
        cp_b1 : coverpoint alu_if_inst.B[1] { option.auto_bin_max = bins_nums; } \
        cp_b2 : coverpoint alu_if_inst.B[2] { option.auto_bin_max = bins_nums; } \
        cp_b3 : coverpoint alu_if_inst.B[3] { option.auto_bin_max = bins_nums; } \
        cp_sel0 : coverpoint alu_if_inst.sel[0] { option.auto_bin_max = bins_nums; } \
        cp_sel1 : coverpoint alu_if_inst.sel[1] { option.auto_bin_max = bins_nums; } \
        cp_sel2 : coverpoint alu_if_inst.sel[2] { option.auto_bin_max = bins_nums; } \
        cp_sel3 : coverpoint alu_if_inst.sel[3] { option.auto_bin_max = bins_nums; } \
    endgroup


module tb_vector_alu;

    // Parámetros
    parameter N = 4;     // Número de ALUs internas
    parameter WIDTH = 8; // Ancho de las entradas y salidas
    integer bins_nums = 256; // Numero de Bins en los Coverpoints

    // Instanciar la interface
    alu_if #(.N(N), .WIDTH(WIDTH)) alu_if_inst();

    // Instancia del DUT
    vector_alu #(.N(N), .WIDTH(WIDTH)) dut (
        .clk(alu_if_inst.clk),
        .arst(alu_if_inst.arst),
        .A(alu_if_inst.A),
        .B(alu_if_inst.B),
        .sel(alu_if_inst.sel),
        .enable(alu_if_inst.enable),
        .Z(alu_if_inst.Z)
    );
    
    //`define TEST1
    //`define TEST2
    //`define TEST3
    `define TEST4

    initial alu_if_inst.clk = 0;
    always #25ps alu_if_inst.clk = ~alu_if_inst.clk;

    `ifdef TEST1
        `CREATE_COVERGROUP_BASIC(cg_inputs)
        initial begin
            cg_inputs cg_inputs_inst = new();
            // Reset 
            alu_if_inst.arst = 1;
            #1ns;
            alu_if_inst.arst = 0;
            
            repeat (2000) begin 
                @(posedge alu_if_inst.clk);
                    alu_if_inst.generate_random_stimuli();
                    cg_inputs_inst.sample();
            end
        end

    `elsif TEST2
        `CREATE_COVERGROUP_BASIC(cg_add_inputs)
        `CREATE_COVERGROUP_BASIC(cg_sub_inputs)
        `CREATE_COVERGROUP_BASIC(cg_and_inputs)
        `CREATE_COVERGROUP_BASIC(cg_or_inputs)
        `CREATE_COVERGROUP_BASIC(cg_mul_inputs)
        `CREATE_COVERGROUP_BASIC(cg_div_inputs)

        initial begin
            cg_add_inputs cg_add_inputs_i = new();
            cg_sub_inputs cg_sub_inputs_i = new();
            cg_and_inputs cg_and_inputs_i = new();
            cg_or_inputs cg_or_inputs_i = new();
            cg_mul_inputs cg_mul_inputs_i = new();
            cg_div_inputs cg_div_inputs_i = new();
            
            alu_if_inst.arst = 1;
            #1ns;
            alu_if_inst.arst = 0;

            repeat (2000) begin
                @(posedge alu_if_inst.clk);
                    alu_if_inst.add_a_b_random(); 
                    cg_add_inputs_i.sample();        
            end
            repeat (2000) begin
                @(posedge alu_if_inst.clk);
                    alu_if_inst.sub_a_b_random();
                    cg_sub_inputs_i.sample();             
            end
            repeat (2000) begin
                @(posedge alu_if_inst.clk);
                    alu_if_inst.and_a_b_random();
                    cg_and_inputs_i.sample();             
            end
            repeat (2000) begin
                @(posedge alu_if_inst.clk);
                    alu_if_inst.or_a_b_random();
                    cg_or_inputs_i.sample();             
            end
            repeat (2000) begin
                @(posedge alu_if_inst.clk);
                    alu_if_inst.mul_a_b_random();
                    cg_mul_inputs_i.sample();             
            end        
            repeat (2000) begin
                @(posedge alu_if_inst.clk);
                    alu_if_inst.div_a_b_random();
                    cg_div_inputs_i.sample();             
            end        
        end

    `elsif TEST3
        initial begin
            ////////////////////////////////////////////////
            // 1. Generar 20 sumas con ceros              //
            // 2. Generar 20 restas con ceros             //
            //   3. Generar 20 multiplicaciones con ceros //                   
            ////////////////////////////////////////////////
            repeat (20) begin
                @(posedge alu_if_inst.clk);
                    alu_if_inst.add_a_b_zero();
            end
            repeat (20) begin
                @(posedge alu_if_inst.clk);
                    alu_if_inst.sub_a_b_zero();
            end

            repeat (20) begin
                @(posedge alu_if_inst.clk);
                    alu_if_inst.mul_a_b_zero();
            end
        end
        
        
    `elsif TEST4
        // Prueba 4 - 
        ////////////////////////////////////////////////
        // 1. Generar  operaciones con a = 0       //                   
        // 2. Generar  operaciones con b = 0      //
        ////////////////////////////////////////////////
        `CREATE_COVERGROUP_WITH_SEL(cg_a_zero_b_op_random)
        `CREATE_COVERGROUP_WITH_SEL(cg_b_zero_a_op_random)
        
        initial begin
            cg_a_zero_b_op_random cg_a_zero_b_op_random_i = new();
            cg_b_zero_a_op_random cg_b_zero_a_op_random_i = new();
            
            repeat (2000) begin
                @(posedge alu_if_inst.clk);  
                    alu_if_inst.a_zero_b_op_random();   
                    cg_a_zero_b_op_random_i.sample();         
            end
            repeat (2000) begin
                @(posedge alu_if_inst.clk); 
                    alu_if_inst.b_zero_a_op_random(); 
                    cg_b_zero_a_op_random_i.sample();             
            end        

        end
    `endif


endmodule

interface alu_if #(parameter N = 4, WIDTH = 8);

    logic clk;
    logic arst;
    logic [WIDTH-1:0] A [N-1:0];
    logic [WIDTH-1:0] B [N-1:0];
    logic [2:0] sel [N-1:0];
    logic [N-1:0] enable;
    logic [WIDTH*2-1:0] Z [N-1:0];
   
    task automatic generate_random_stimuli();
        assert(std::randomize(A) with {
            foreach (A[i]) A[i] inside {[0:255]};});
        assert(std::randomize(B) with {
            foreach (B[i]) B[i] inside {[0:255]};});
        assert(std::randomize(sel) with {
            foreach (sel[i]) sel[i] inside {[0:5]};});
        assert(std::randomize(enable) with {
            foreach (enable[i]) enable[i] == 0 || enable[i] == 1;});
    endtask
    task automatic add_a_b_random();
        begin
            enable = '1;
            assert(std::randomize(A) with {
                foreach (A[i]) A[i] inside {[0:255]};});
            assert(std::randomize(B) with {
                foreach (B[i]) B[i] inside {[0:255]};});

            foreach (sel[i]) sel[i] = 3'b000; // Suma
        end
    endtask
    task automatic sub_a_b_random();
        begin
            enable = '1;
            assert(std::randomize(A) with {
                foreach (A[i]) A[i] inside {[0:255]};});
            assert(std::randomize(B) with {
                foreach (B[i]) B[i] inside {[0:255]};});

            foreach (sel[i]) sel[i] = 3'b001; // sub
        end
    endtask    
    task automatic and_a_b_random();
        begin
            enable = '1;
            assert(std::randomize(A) with {
                foreach (A[i]) A[i] inside {[0:255]};});
            assert(std::randomize(B) with {
                foreach (B[i]) B[i] inside {[0:255]};});

            foreach (sel[i]) sel[i] = 3'b010; // and
        end
    endtask    
    task automatic or_a_b_random();
        begin
            enable = '1;
            assert(std::randomize(A) with {
                foreach (A[i]) A[i] inside {[0:255]};});
            assert(std::randomize(B) with {
                foreach (B[i]) B[i] inside {[0:255]};});

            foreach (sel[i]) sel[i] = 3'b011; // Or
        end
    endtask    
    task automatic mul_a_b_random();
        begin
            enable = '1;
            assert(std::randomize(A) with {
                foreach (A[i]) A[i] inside {[0:255]};});
            assert(std::randomize(B) with {
                foreach (B[i]) B[i] inside {[0:255]};});

            foreach (sel[i]) sel[i] = 3'b100; // Mul
        end
    endtask    
    task automatic div_a_b_random();
        begin
            enable = '1;
            assert(std::randomize(A) with {
                foreach (A[i]) A[i] inside {[0:255]};});
            assert(std::randomize(B) with {
                foreach (B[i]) B[i] inside {[0:255]};});

            foreach (sel[i]) sel[i] = 3'b101;
        end
    endtask      
    
    task automatic add_a_b_zero();
        begin
            enable = '1;
            foreach (A[i]) A[i] = '0; // Todos los elementos de A a cero
            foreach (B[i]) B[i] = '0; // Todos los elementos de B a cero
            foreach (sel[i]) sel[i] = 3'b000; // Suma (opcode = 0)
        end
    endtask
    
    // Task para operación de resta con A y B en cero
    task automatic sub_a_b_zero();
        begin
            enable = '1;
            foreach (A[i]) A[i] = '0;
            foreach (B[i]) B[i] = '0;
            foreach (sel[i]) sel[i] = 3'b001; // Resta (opcode = 1)
        end
    endtask
    
    // Task para operación de multiplicación con A y B en cero
    task automatic mul_a_b_zero();
        begin
            enable = '1;
            foreach (A[i]) A[i] = '0;
            foreach (B[i]) B[i] = '0;
            foreach (sel[i]) sel[i] = 3'b100; // Multiplicación (opcode = 7)
        end
    endtask
    
    // Task para operación con A en cero y B y opcode aleatorios
    task automatic a_zero_b_op_random();
        begin
            enable = '1;
            foreach (A[i]) A[i] = '0;
            assert(std::randomize(B) with {
                foreach (B[j]) B[j] inside {[0:255]};
            });
            assert(std::randomize(sel) with {
                foreach (sel[j]) sel[j] inside {[0:7]};
            });
        end
    endtask
    
    // Task para operación con B en cero y A y opcode aleatorios
    task automatic b_zero_a_op_random();
        begin
            enable = '1;
            foreach (B[i]) B[i] = '0;
            assert(std::randomize(A) with {
                foreach (A[j]) A[j] inside {[0:255]};
            });
            assert(std::randomize(sel) with {
                foreach (sel[j]) sel[j] inside {[0:7]};
            });
        end
    endtask
endinterface
