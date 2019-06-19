`include "control.v"

module control_tb();
    wire clk;
    wire [31:0] instruct;
    initial begin
        $display ("Reg_A\tReg_B\tAcc");
        $monitor ("%b\t%b\t%b", a, b, acc1);

        clk = 0;
        instruct = ;
        #20 instruct = ;
        #20 instruct = ;
        #20 instruct = ;
        #20 instruct = ;
        #20 instruct = ;
        #20 instruct = ;
        #20 $finish;
    end
    always begin
        #5 clk = ~clk;
    end

    control c1(
        CLK,
        inst;
    );
    
endmodule