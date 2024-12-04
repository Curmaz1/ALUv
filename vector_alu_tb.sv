module tb_vector_alu;

    // Parámetros
    parameter N = 4;     // Número de ALUs internas
    parameter WIDTH = 8; // Ancho de las entradas y salidas

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
`define TEST2
//`define TEST3
//`define TEST4
//`define TEST5

    initial alu_if_inst.clk = 0;
    always #1 alu_if_inst.clk = ~alu_if_inst.clk;

`ifdef TEST1
    initial begin
        // Reset 
        alu_if_inst.arst = 1;
        #1;
        alu_if_inst.arst = 0;

        repeat (1000) begin 
            @(posedge alu_if_inst.clk);
                alu_if_inst.generate_random_stimuli(); 
        end
    end

`elsif TEST2
    initial begin

        alu_if_inst.arst = 1;
        #10;
        alu_if_inst.arst = 0;

        repeat (70) begin
            @(posedge alu_if_inst.clk);
                alu_if_inst.add_a_b_random();             
        end
        repeat (70) begin
            @(posedge alu_if_inst.clk);
                alu_if_inst.sub_a_b_random();             
        end
        repeat (70) begin
            @(posedge alu_if_inst.clk);
                alu_if_inst.and_a_b_random();             
        end
        repeat (70) begin
            @(posedge alu_if_inst.clk);
                alu_if_inst.or_a_b_random();             
        end
        repeat (70) begin
            @(posedge alu_if_inst.clk);
                alu_if_inst.mul_a_b_random();             
        end        
        repeat (70) begin
            @(posedge alu_if_inst.clk);
                alu_if_inst.div_a_b_random();             
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
                add_a_b_zero();
        end
        repeat (20) begin
            @(posedge alu_if_inst.clk);
                sub_a_b_zero();
        end

        repeat (20) begin
            @(posedge alu_if_inst.clk);
                mul_a_b_zero();
        end
    end
    
    
`elsif TEST4
    // Prueba 4 - 
    ////////////////////////////////////////////////
    // 1. Generar 300 operaciones con a = 0       //                   
    // 2. Generar 3000 operaciones con b = 0      //
    ////////////////////////////////////////////////
    initial begin
        repeat (300) begin
            @(posedge ALU_intf_i.clk);  
            ALU_intf_i.a_zero_b_op_random();            
        end
        repeat (3000) begin
            @(posedge ALU_intf_i.clk); 
                ALU_intf_i.b_zero_a_op_random();              
        end        
        //@(posedge ALU_intf_i.clk); 
            //$finish;     
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

            foreach (sel[i]) sel[i] = 3'b001; // Suma
        end
    endtask    
    task automatic and_a_b_random();
        begin
            enable = '1;
            assert(std::randomize(A) with {
                foreach (A[i]) A[i] inside {[0:255]};});
            assert(std::randomize(B) with {
                foreach (B[i]) B[i] inside {[0:255]};});

            foreach (sel[i]) sel[i] = 3'b010; // Suma
        end
    endtask    
    task automatic or_a_b_random();
        begin
            enable = '1;
            assert(std::randomize(A) with {
                foreach (A[i]) A[i] inside {[0:255]};});
            assert(std::randomize(B) with {
                foreach (B[i]) B[i] inside {[0:255]};});

            foreach (sel[i]) sel[i] = 3'b011; // Suma
        end
    endtask    
    task automatic mul_a_b_random();
        begin
            enable = '1;
            assert(std::randomize(A) with {
                foreach (A[i]) A[i] inside {[0:255]};});
            assert(std::randomize(B) with {
                foreach (B[i]) B[i] inside {[0:255]};});

            foreach (sel[i]) sel[i] = 3'b100; // Suma
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
