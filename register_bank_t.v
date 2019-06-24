`include "register_bank.v"

//hora do teste

module REG_BANK_TEST();
reg e_l;
reg clk;
reg [31:0] dado;
reg [1:0]fnt1,fnt2,reg_e;
reg CLK;
wire [31:0]dado_l_1,dado_l_2;
reg_bank uut (clk,e_l,reg_e,fnt1,fnt2,dado,dado_l_1,dado_l_2);
initial begin
	$dumpfile("REG_BANK_TEST.vcd");
	$dumpvars;
	clk=0;
	dado = 256;
	e_l = 1;
	reg_e = 2'b00;
	#5
	e_l=0;
	fnt1=2'b00;
	#5
	dado = 128;
	reg_e = 2'b01;
	e_l=1;
	#5
	fnt2=2'b01;
	e_l=0;
	#5
	$finish;
	end
	always 
	#2 clk = !clk;
endmodule