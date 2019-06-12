`timescale 1ns / 1ps
module reg_bank (
  input CLK,
  //operador para indicar registrador
  input opwrite,
  input [1:0] reg_write,
  input [1:0] src_1,
  input [1:0] src_2,
  input [31:0] data,
  //estes registradores servem para receber o valor
  //de saida
  output reg [31:0] data_src_1,
  output reg [31:0] data_src_2
  );

reg [31:0] reg_A,reg_B, accumulator,zero;
always @(negedge CLK)begin

//escrita descida
  if (opwrite == 1)begin
      case(reg_write)
          2'b00: reg_A = data;
          2'b01: reg_B = data;
          2'b10: accumulator = data;
          2'b11: accumulator = data;

      endcase

  end
end

always @(posedge CLK,data_src_1)begin
  if (opwrite == 0)begin
    case(src_1)
        2'b00: data_src_1 = reg_A;
        2'b01: data_src_1 = reg_B;
        2'b10: data_src_1 = accumulator;
        2'b11: data_src_1 = accumulator;

    endcase
    case(src_2)
        2'b00: data_src_2 = reg_A;
        2'b01: data_src_2 = reg_B;
        2'b10: data_src_2 = accumulator;
        2'b11: data_src_2 = accumulator;

    endcase

  end
end
endmodule //
