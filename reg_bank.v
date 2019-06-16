//reg_write= 	  2bits registrador escrita 
//opwrite=Escrita 1bit, 1->escrita,0->leitura
//data= 	  32bits Dado a ser escrito no registrador se opwrite=1
//src_1=Fonte1 2bits, primeiro registrador a ser lido
//src_2=Fonte2 2bits, segundo registrador a ser lido
//data_src_1    32 bits, Dado lido do primeiro registrador
//data_src_2  32 bits, Dado lido do segundo registrador
module reg_bank (
  input CLK,
  input opwrite,
  input [1:0] reg_write,
  input [1:0] src_1,
  input [1:0] src_2,
  input [31:0] data,
  output reg [31:0] data_src_1,
  output reg [31:0] data_src_2
  );

reg [31:0]mem[0:3] ;
always @(negedge CLK)begin

//escrita descida
  if (opwrite == 1)begin
      case(reg_write)
          2'b00: mem[0] = data;
          2'b01: mem[1] = data;
          2'b10: mem[2] = data;
          2'b11: mem[2] = data;
      endcase
  end
end
always @(posedge CLK,data_src_1)begin
  if (opwrite == 0)begin
    case(src_1)
        2'b00: data_src_1 = mem[0];
        2'b01: data_src_1 = mem[1];
        2'b10: data_src_1 = mem[2];
        2'b11: data_src_1 = mem[2];
    endcase
    case(src_2)
        2'b00: data_src_2 = mem[0];
        2'b01: data_src_2 = mem[1];
        2'b10: data_src_2 = mem[2];
        2'b11: data_src_2 = mem[2];
    endcase
  end
end
endmodule 
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
	reg_e = 2'b00;//isso aqui faz com que o dado na variavel "dado" (256) seja escrito em mem[0]
	#5
	e_l=0;
	fnt1=2'b00;//isso aqui faz com que seja realizada uma leitura de mem[0] para dado_l_1, que deveria ficar com 256
	#5 $finish;
	end
	always 
	#2 clk = !clk;
endmodule
