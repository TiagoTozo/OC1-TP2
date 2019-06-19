`include "ALU_t.v"
`include "reg_bank.v"
`include "Memoria.v"

module control(
    input wire CLK, // clock
    input wire [31:0] inst, // codigo da instrucao de 32 bits
    );
    always @(*)
    // separando os bits da instrucao
    wire [3:0]  opcode   = inst[31:29];
    wire [2:0]  fonte_a  = inst[28:27];
    wire [2:0]  dest     = inst[26:25];
    wire [24:0] imediato = inst[24:0]; 
    begin
        case(opcode) // casos do opcode
            3'b000: // ADD
                reg [31:0] regi, acc, res;
                case(fonte_a)
                    2'b00: // ler reg_a
                        reg_bank(CLK, 1'b0, x, 2'b10, 2'b00, x, acc, regi); // busca o acumulador e o reg_a
                    2'b01: // ler reg_b
                        reg_bank(CLK, 1'b0, x, 2'b10, 2'b01, x, acc, regi); // busca o acumulador e o reg_b
                    2'b10: // ler acc
                        reg_bank(CLK, 1'b0, x, 2'b10, 2'b10, x, acc, regi); // busca o acumulador e o acumulador
                    2'b11: // ler zero
                        regi = 0;
                        reg_bank(CLK, 1'b0, x, 2'b10, x, x, acc, x); // busca o acumulador
                endcase
                ALU(acc, regi, 4'b1000, res); // soma o acumulador e o reg_a
                reg_bank(CLK, 1'b1, 2'b10, x, x, res, x, x); // coloca o resultado no acumulador
            3'b001: // SUB
                reg [31:0] regi, acc, res;
                case(fonte_a)
                    2'b00: // ler reg_a
                        reg_bank(CLK, 1'b0, x, 2'b10, 2'b00, x, acc, regi); // busca o acumulador e o reg_a
                    2'b01: // ler reg_b
                        reg_bank(CLK, 1'b0, x, 2'b10, 2'b01, x, acc, regi); // busca o acumulador e o reg_b
                    2'b10: // ler acc
                        reg_bank(CLK, 1'b0, x, 2'b10, 2'b10, x, acc, regi); // busca o acumulador e o acumulador
                    2'b11: // ler zero
                        regi = 0;
                        reg_bank(CLK, 1'b0, x, 2'b10, x, x, acc, x); // busca o acumulador
                endcase
                ALU(acc, src_a, 4'b0100, res); // subtrai o reg_a do acumulador
                reg_bank(CLK, 1'b1, 2'b10, x, x, res, x, x); // coloca o resultado no acumulador
            3'b010: // DIV
                reg [31:0] regi, acc, res;
                case(fonte_a)
                    2'b00: // ler reg_a
                        reg_bank(CLK, 1'b0, x, 2'b10, 2'b00, x, acc, regi); // busca o acumulador e o reg_a
                    2'b01: // ler reg_b
                        reg_bank(CLK, 1'b0, x, 2'b10, 2'b01, x, acc, regi); // busca o acumulador e o reg_b
                    2'b10: // ler acc
                        reg_bank(CLK, 1'b0, x, 2'b10, 2'b10, x, acc, regi); // busca o acumulador e o acumulador
                    2'b11: // ler zero
                        regi = 0;
                        reg_bank(CLK, 1'b0, x, 2'b10, x, x, acc, x); // busca o acumulador
                endcase
                ALU(acc, src_a, 4'b0001, res); // divide o acumulador pelo reg_a
                reg_bank(CLK, 1'b1, 2'b10, x, x, res, x, x); // coloca o resultado no acumulador
            3'b011: // MUL
                reg [31:0] regi, acc, res;
                case(fonte_a)
                    2'b00: // ler reg_a
                        reg_bank(CLK, 1'b0, x, 2'b10, 2'b00, x, acc, regi); // busca o acumulador e o reg_a
                    2'b01: // ler reg_b
                        reg_bank(CLK, 1'b0, x, 2'b10, 2'b01, x, acc, regi); // busca o acumulador e o reg_b
                    2'b10: // ler acc
                        reg_bank(CLK, 1'b0, x, 2'b10, 2'b10, x, acc, regi); // busca o acumulador e o acumulador
                    2'b11: // ler zero
                        regi = 0;
                        reg_bank(CLK, 1'b0, x, 2'b10, x, x, acc, x); // busca o acumulador
                endcase
                ALU(acc, src_a, 4'b0010, res); // multiplica o acumulador pelo reg_a
                reg_bank(CLK, 1'b1, 2'b10, x, x, res, x, x); // coloca o resultado no acumulador

            // DUVIDA: nao sei oq fazer aqui
            3'b100: // MC (Memory clear)

            3'b101: // HLT (parada do processador)
                $finish

            // DUVIDA: qual o endereco de memoria de onde devo ler e escrever? ele nao vem no codigo da instrucao (representado como xx nas chamadas abaixo)
            3'b110: // MR (Memory read)
                reg [31:0] temp;
                Memoria(CLK, x, xx, x, 1'b1, 1'b0, x, temp); // busca o valor na memoria e coloca em temp
                case(dest)
                    2'b00: // escrever em reg_a
                        reg_bank(CLK, 1'b1, 2'b00, x, x, temp, x, x); // escreve temp
                    2'b01: // escrever em reg_b
                        reg_bank(CLK, 1'b1, 2'b01, x, x, temp, x, x); // escreve temp
                    2'b1x: // escrever em acc
                        reg_bank(CLK, 1'b1, 2'b00, x, x, temp, x, x); // escreve temp
                endcase
            3'b111: // MW (Memory write)
                reg [31:0] temp;
                case(fonte_a)
                    2'b00: // ler reg_a
                        reg_bank(CLK, 1'b0, x, x, 2'b00, x, x, temp); // busca o reg_a
                    2'b01: // ler reg_b
                        reg_bank(CLK, 1'b0, x, x, 2'b01, x, x, temp); // busca o reg_b
                    2'b10: // ler acc
                        reg_bank(CLK, 1'b0, x, x, 2'b10, x, x, temp); // busca o acumulador
                    2'b11: // ler zero
                        temp = 0;
                endcase
                Memoria(CLK, x, xx, temp, 1'b1, 1'b1, x, x); // escreve o valor de temp na memoria
            default: 
                $display  ("Erro: opcode invalido");
                $finish
        endcase
        reg [31:0] a, b, acc1, acc2;
        reg_bank(CLK, 1'b0, x, 2'b00, 2'b01, x, a, b); // busca o reg_A e o reg_B
        reg_bank(CLK, 1'b0, x, 2'b10, 2'b11, x, acc1, acc2); // busca o acumulador
        $display ("Reg_A: %b\tReg_B: %b\tAcc: %b", a, b, acc1); // imprime os registradores
    end
endmodule