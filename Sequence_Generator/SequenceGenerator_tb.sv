`timescale 1ps/1ps

module saeq_generator_tb();

// clock and reset:
logic clk;
logic reset;
logic [31:0] seq_o;

int unsigned d_cycles;

//clock generator:
initial clk =0;
always #5 clk = ~clk;
initial begin
    reset = 1;
    repeat(2) @(posedge clk);
    reset =0; 
end


seq_generator dut(.clk(clk),.reset(reset),.seq_o(seq_o));

initial begin
@(negedge reset);

for (int i = 0; i<20; i++) begin 
    d_cycles = $urandom_range(10,50);
    repeat(d_cycles) @(posedge clk);
    reset =1;
    @(posedge clk);
    reset = 0;
end
repeat(10) @(posedge clk);
$finish();
end

endmodule