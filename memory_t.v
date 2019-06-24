`include "memory.v"

//hora do teste
module mem_test();
reg clk,Op2En,Op2RW,M_Clear;
reg [31:0]Read_PC,R_W_Addr,DataWrite;
wire [31:0]Instruction,DataRead;
mem uut(clk,Read_PC,R_W_Addr,DataWrite,Op2En,Op2RW,M_Clear,Instruction,DataRead);
  initial begin
  $dumpfile("MEM_TEST.vcd");
  $dumpvars;
  Op2En=1'b1;
  Op2RW=1'b0;
  #2
  R_W_Addr=0;
  #5
  M_Clear=1;
  Op2En=1'b0;
  #2
  M_Clear=0;
  Op2En=1'b1;
  #5
  $finish;
  end
endmodule