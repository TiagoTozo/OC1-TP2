 `timescale 10ns / 1ps

module tb_alu;
//Inputs
 reg[31:0] A,B;
 reg[3:0] opALU;

//Outputs
 wire[31:0] ALU_Out;
 wire CarryOut;
 // Verilog code for ALU
 integer i;
 alu test_unit(
            A,B,  // ALU 8-bit Inputs
            opALU,// ALU Selection
            ALU_Out, // ALU 8-bit Output
            CarryOut // Carry Out Flag
     );
    initial begin
    // hold reset state for 100 ns.
      opALU = 4'b1000;

      for (i=0;i<=15;i=i+1)

      begin

      A = $urandom%10;
      B = $urandom%10;
       // opALU = opALU + 8'h01;
       $display("Valor out:%d",ALU_Out);

       $display("Valor i:%d",i);

       $display("Valor A:%d",A);
       $display("Valor B:%d",B);

       #10;
      end;
      $display("Valor out:%d",ALU_Out);


    end
endmodule
