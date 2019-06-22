`include "ALU_t.v"
`include "reg_bank_2.v"
`include "mem.v"
module control(
/*variaveis memória*/clk_m,Op2En_m,Op2RW_m,M_Clear_m,Read_PC_m,R_W_Addr_m,DataWrite_m,Instruction_m,DataRead_m,
/*variaveis registrador*/clk_r,opwrite_r,reg_write_r,src_1_r,src_2_r,data_r,data_src_1_r,data_src_2_r,
/*variaveis alu*/rs_a,rt_a,op_a,rd_a
);
//variaveis para memória
  input wire clk_m,Op2En_m,Op2RW_m,M_Clear_m;
  input wire [31:0]Read_PC_m,R_W_Addr_m,DataWrite_m;
  output wire [31:0]Instruction_m,DataRead_m;
  mem my_memory(.clk(clk_m),.Read_PC(Read_PC_m),.R_W_Addr(R_W_Addr_m),.DataWrite(DataWrite_m),.Op2En(Op2En_m),.Op2RW(Op2RW_m),.M_Clear(M_Clear_m),.Instruction(Instruction_m),.DataRead(DataRead_m));
//variaveis para registrador
  input wire clk_r,opwrite_r;
  input wire [1:0] reg_write_r,src_1_r,src_2_r;
  input wire [31:0] data_r;
  output wire [31:0] data_src_1_r,data_src_2_r;
  reg_bank my_reg (.CLK(clk_r),.opwrite(opwrite_r),.reg_write(reg_write_r),.src_1(src_1_r),.src_2(src_2_r),.data(data_r),.data_src_1(data_src_1_r),.data_src_2(data_src_2_r));
//variaveis para a alu
  input wire [31:0]rs_a,rt_a;
  input wire [3:0]op_a;
  output wire [31:0]rd_a;
  ALU my_alu (.rs(rs_a),.rt(rt_a),.op(op_a),.rd(rd_a));
endmodule

//testando esse filho de uma puta
module test_fdp();
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
initial begin
$dumpfile("control.vcd");
$dumpvars;
#1
//ler a memória : DataRead_t = mem[R_W_Addr_t];
clk_m_t=1;
Op2En_t=1;
Op2RW_t=0;
R_W_Addr_t=32'b00;
#5
rs_t=DataRead_t;
#2
//ler a memória : DataRead_t = mem[R_W_Addr_t];
R_W_Addr_t=32'b01;
#5
rt_t=DataRead_t;
#2
op_t=4'b0001;
#5 $finish;
end

always #4 clk_m_t=!clk_m_t;
endmodule