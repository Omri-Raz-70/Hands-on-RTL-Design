`timescale  1ns/1ps
module div_by_three_tb();

parameter DATAWIDTH = 64;

//clock and reset

logic clk;
logic reset;

//dut signals
logic x_i;
logic div_o;

// TB signals
logic [DATAWIDTH -1:0] x_reg;
logic act_div_o;
logic is_mistake;

// clock generator
initial clk = 0;
always #5 clk = ~clk;
initial begin 
    reset =1;
    x_reg = '0;
    x_i = 0;
    repeat(2) @(posedge clk);
    reset = 0;
end

div_by_three dut(.clk(clk), .reset(reset), .x_i(x_i),.div_o(div_o));

initial begin
    @(negedge reset);

    for (int i =0; i<64; i++) begin
        x_i = $urandom_range(0,1);
        x_reg = {x_reg[62:0],x_i};
        @(posedge clk);
    end
end
assign act_div_o = ((x_reg % 3) == 0) ? 1:0; 
assign is_mistake = (act_div_o != div_o);

endmodule