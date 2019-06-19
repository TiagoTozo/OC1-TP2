module Memoria(clk, ReadPC, ReadWriteAddr, DataWrite, Op2En, Op2RW, Instruction, Data);
input wire[31:0] ReadPC, DataWrite, ReadWriteAddr;
input wire Op2En, Op2RW, clk;

output reg[31:0] Data, Instruction;

reg [31:0] mem[1023:0];
integer i;
initial $readmemh("mem.txt", mem);

initial begin
    
    $display("program:");
    for (i=0; i < 4; i=i+1)
    $display("%d:%h".i.mem[i]);

end

always@(*)
begin
    if(Op2En == 1'b1)
    begin
        if(Op2RW == 1'b0)
        begin
            Data = mem[ReadWriteAddr];
        end
        else begin
            mem[ReadWriteAddr] = DataWrite;
        end
    end

    Instruction = mem[ReadPC];
end


endmodule