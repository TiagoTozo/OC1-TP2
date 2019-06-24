module mem(
	input wire clk,
	input wire [31:0] Read_PC,//endereço do PC
	input wire [31:0] R_W_Addr,//Endereço que será usado, vem do campo imediato
	input wire [31:0] DataWrite,//Dado que será escrito, enviado do banco de registrador
	input wire Op2En, //Indica se faremos uma segunda operação na memória neste ciclo se == 1
	input wire Op2RW, //Leitura = 0; Escrita = 1
	input wire M_Clear, //Indica a operação limpar memória
	output reg [31:0] Instruction, //Instrução lida
	output reg [31:0] DataRead //Data lida
	);
	
  reg[31:0]mem[0:1023];
  integer i;
  initial $readmemh("mem.txt",mem);
  
  initial begin //display
		$display("program:");
		for(i=0;i<5;i=i+1)
		  $display("%d:%h",i,mem[i]);
  end
  
  always@(*)
  begin
	if(M_Clear == 1) 
		mem[R_W_Addr] = 0;
	else begin
      if(Op2En == 1'b1)//conferir se isso aqui é assim mesmo
	    //begin
		  if(Op2RW == 1'b0)
		    //begin
		      DataRead = mem[R_W_Addr];
		    //end
		  else
		    //begin
		      mem[R_W_Addr]=DataWrite;
		    //end
	    //end
	end
	Instruction = mem[Read_PC];
  end
endmodule