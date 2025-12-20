`timescale  1ns/1ps
module palindrome3b_tb();

parameter PALWIDTH = 3;

// clock and reset
logic clk;
logic reset;
//dut signals
logic x_i;
logic palindrome_o;
//TB signals
int i ;
logic [PALWIDTH-1:0] pal_reg;
logic act_pal_o;
logic is_mistake;

//clock generator:
initial clk = 0;
always #5 clk = ~clk;
initial begin 
    reset = 1;
    pal_reg = '0;
    x_i = 0;
    repeat(2) @(posedge clk);
    reset = 0;
end

palindrome3b dut (.clk(clk), .reset(reset), .x_i(x_i), .palindrome_o(palindrome_o));

initial begin
    @(negedge reset);

    for (i =0; i< 400; i++)begin
        x_i = $urandom_range(0,1);
        pal_reg = {pal_reg[1:0],x_i};
        @(posedge clk);
    end
    $finish();
end

assign act_pal_o =(i >= 2) ? ~((pal_reg[2] ^ pal_reg[1])^(pal_reg[1] ^ pal_reg[0])) : 0;;
assign is_mistake = (act_pal_o != palindrome_o);

endmodule