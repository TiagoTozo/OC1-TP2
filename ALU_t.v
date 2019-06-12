//rs= 32 bits primeiro dado
//rt= 32 bits segundo dado
//op= 04 bits operacao
//rd= 32 bits resultado
module ALU(rs,rt,op,rd);
	input wire [31:0] rs;
	input wire [31:0] rt;
	input wire [3:0] op;
	output reg [31:0] rd;
	always @(*)
    begin
		case(op)
            4'b1000: // Soma
                rd = rs + rt ;
            4'b0100: // Subtracao
                rd = rs - rt ;
            4'b0010: // Multiplicacao
                rd = rs * rt;
            4'b0001: // Divisao
                rd = rs/rt;
            default:  rd = rs + rt ;
        endcase
	end
endmodule
// teste da alu
module ALU_TEST();
	reg [31:0] a,b;
	reg [3:0] c;
	wire [31:0] d;
	ALU alu_test(a,b,c,d);
	initial begin
		$dumpfile("ALU_TEST.vcd");
		$dumpvars;
		a= 12;
		 b= 13;
		 c = 4'b1000;
		#5 a= 20;
		 b= 10;
		 c = 4'b0100;
		#5 a= 5;
		 b= 6;
		 c = 4'b0010;
		#5 a= 25;
		 b= 5;
		 c = 4'b0001;
		#5 $finish;
	end
endmodule