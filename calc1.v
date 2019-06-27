`include"control_f.v"
//testando esse modulo :)
module test_cont();
  //variaveis de teste para memória
  reg clk_m_t,Op2En_t,Op2RW_t,M_Clear_t;
  reg [31:0]Read_PC_t,R_W_Addr_t,DataWrite_t;
  wire [31:0]Instruction_t,DataRead_t;
  //variaveis de teste para registrador
  reg clk_r_t,opwrite_t;
  reg [1:0] reg_write_t,src_1_t,src_2_t;
  reg [31:0] data_t;
  wire [31:0] data_src_1_t,data_src_2_t;
  //variaveis de teste para a alu
  reg [31:0]rs_t,rt_t;
  reg [3:0]op_t;
  wire [31:0]rd_t;
control uut(
clk_m_t,Op2En_t,Op2RW_t,M_Clear_t,Read_PC_t,R_W_Addr_t,DataWrite_t,Instruction_t,DataRead_t,
clk_r_t,opwrite_t,reg_write_t,src_1_t,src_2_t,data_t,data_src_1_t,data_src_2_t,
rs_t,rt_t,op_t,rd_t
);
reg [2:0] Opcode;
reg [1:0]FonteA,Dest;
reg [24:0]Imediato;
initial begin
$dumpfile("control.vcd");
$dumpvars;
clk_r_t=1;
data_t=32'b0;
opwrite_t=1;
reg_write_t=2'b00;
#1
data_t=32'b11110;
reg_write_t=2'b01;
#1
data_t=32'b01;
reg_write_t=2'b10;
end
initial begin
  #5
  clk_r_t=0;
  //Read_PC_t=32'b0;
  //Read_PC_t=32'b01000;//teste mem read
  //Read_PC_t=32'b01011;//teste mem write
  Read_PC_t=32'b01111;
  repeat(100)begin
	#1
	Opcode=Instruction_t[31:29];
	FonteA=Instruction_t[28:27];
	Dest=Instruction_t[26:25];
	Imediato=Instruction_t[24:0];
	case(Opcode)
	  //soma
      3'b000:begin 
      /*reg*/ opwrite_t=0;src_1_t=2'b10;src_2_t=FonteA;#2//data_src_1_t = acc e data_src_2_t = fonteA
      /*alu*/ rt_t=Imediato;rs_t=data_src_2_t;op_t=4'b1000;#2//rs = primeiro operando, logo = reg da inst
      /*reg*/ data_t=rd_t;opwrite_t=1;reg_write_t=2'b10;
      end
      //sub
      3'b001:begin
      /*reg*/opwrite_t=0;src_1_t=2'b10;src_2_t=FonteA;#2
      /*alu*/rt_t=Imediato;rs_t=data_src_2_t;op_t=4'b0100;#2
      /*reg*/data_t=rd_t;opwrite_t=1;reg_write_t=2'b10;
      end
      //div
      3'b010:begin
      /*reg*/opwrite_t=0;src_1_t=2'b10;src_2_t=FonteA;#2//data_src_1_t = acc e data_src_2_t = fonteA
      /*alu*/rt_t=Imediato;rs_t=data_src_2_t;op_t=4'b0001;#2//rs = primeiro operando, logo = reg da inst
      /*reg*/data_t=rd_t;opwrite_t=1;reg_write_t=2'b10;
      end
      //mul
      3'b011:begin
	  /*reg*/opwrite_t=0;src_1_t=2'b10;src_2_t=FonteA;#2
  	  /*alu*/rt_t=Imediato;rs_t=data_src_2_t;op_t=4'b0010;#2
	  /*reg*/data_t=rd_t;opwrite_t=1;reg_write_t=2'b10;
	  end
      //mem clear
	  3'b100:begin
  	  Op2En_t=0;M_Clear_t=1;R_W_Addr_t=Imediato;
	  end
	  //halt  
	  3'b101:begin 
	  $display("HALT!");$finish;
	  end
	  //mem read
 	  3'b110:begin 
	  /*mem*/ Op2En_t=1;R_W_Addr_t=Imediato;Op2RW_t=0;#2 
	  /*reg*/ data_t=DataRead_t;reg_write_t=Dest;opwrite_t=1;
	  end
	  //mem write
	  3'b111:begin
	  /*reg*/opwrite_t=0;src_1_t=FonteA;R_W_Addr_t=Imediato;#2
	  /*mem*/Op2En_t=1;DataWrite_t=data_src_1_t;Op2RW_t=1;
	  end
    endcase
  #6
  Read_PC_t=Read_PC_t+1'b1;
  end
end
always begin
#1 clk_r_t = !clk_r_t; 
end
endmodule