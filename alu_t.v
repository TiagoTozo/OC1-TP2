`include "alu.v"

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