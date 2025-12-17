`timescale 1ps/1ps

module atomic_counters_tb();
parameter DATABUS = 32;
parameter CLK_PEIOD = 5;
parameter COUNTLEN = 64;

//signals for DUT 
logic clk;
logic reset;
logic trig_i,req_i,atomic_i;
logic ack_o;
logic [DATABUS -1 :0] count_o;

//sugnals for comparison
logic [COUNTLEN-1:0] count_tb_reg;
logic [DATABUS-1:0] bus_tb;
logic is_mistake;

int unsigned d_cycles;

//clock generator:
initial clk = 0;
always #CLK_PEIOD clk = ~clk;

//reset the system:
initial begin 
    reset =1 ;
    repeat (2) @(posedge clk);
    reset = 0;
end

atomic_counters dut(.clk(clk),.reset(reset),.trig_i(trig_i),.req_i(req_i),.atomic_i(atomic_i),
                    .ack_o(ack_o),.count_o(count_o));

initial begin
    @(negedge reset);

    
end


endmodule