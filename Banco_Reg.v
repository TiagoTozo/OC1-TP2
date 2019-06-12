
//Reg_e= 	  2bits registrador escrita 
//e_l=Escrita 1bit, 1->escrita,0->leitura
//dado= 	  32bits Dado a ser escrito no registrador se e_l=1
//fnt1=Fonte1 2bits, primeiro registrador a ser lido
//fnt2=Fonte2 2bits, segundo registrador a ser lido
//dado_l_1    32 bits, Dado lido do primeiro registrador
//dado_l_2 	  32 bits, Dado lido do segundo registrador
module Banco_Reg(reg_e,e_l,dado,fnt1,fnt2,dado_l_1,dado_l_2);
input wire reg_e [1:0];
input wire e_l;
input wire dado [31:0];
input wire fnt1 [1:0];


endmodule