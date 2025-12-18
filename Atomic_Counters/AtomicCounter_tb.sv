`timescale 1ns/1ps

module atomic_counters_tb();
parameter DATABUS = 32;
parameter CLK_PERIOD = 5;
parameter COUNTLEN = 64;

//signals for DUT 
logic clk;
logic reset;
logic trig_i,req_i,atomic_i;
logic ack_o;
logic [DATABUS -1 :0] count_o;
logic fast_i ;

//signals for comparison
logic [COUNTLEN-1:0] count_tb;
logic [DATABUS-1:0] msb_lut;
logic [DATABUS-1 :0] lsb_lut;
logic ack_o_tb ;
// signals to show a mistake
logic bus_mistake;
logic ack_mistak;

//registers to handle time delay 
logic req_i_reg;
logic atomic_i_reg;
logic [DATABUS-1:0] msb_lut_reg;
logic [DATABUS-1:0] lsb_lut_reg;
logic [COUNTLEN-1 :0] count_tb_reg;
logic ack_o_tb_reg;

int unsigned d1_cycles;
int unsigned d2_cycles;
int unsigned unity_var;

//clock generator:
initial clk = 0;
always #CLK_PERIOD clk = ~clk;

//reset the system and TB registers:
initial begin 
    reset =1 ;
    count_tb = '0;
    msb_lut = '0;
    lsb_lut = '0;
    req_i = 0;
    atomic_i = 0;
    ack_o_tb = 0;
    repeat (2) @(posedge clk);
    reset = 0;
end

atomic_counters dut(.clk(clk),.reset(reset),.trig_i(trig_i),.req_i(req_i),.atomic_i(atomic_i),.fast_i(fast_i),
                    .ack_o(ack_o),.count_o(count_o));

initial begin
    @(negedge reset);
for (int i = 0; i<20; i++)begin
    d1_cycles = $urandom_range(1000,5000);
    d2_cycles = 1;
    unity_var = $urandom_range(1,5);
    trig_i = (unity_var <= 4);
    fast_i = 1;
    // count_tb = (trig_i) ? count_tb + d1_cycles+1 :count_tb; 

    repeat(d1_cycles)begin
        count_tb = (trig_i) ? (fast_i) ? (count_tb +1000000 ) : (count_tb + 1) :count_tb;
        @(posedge clk);
    end
    fast_i = 0;
    repeat(d2_cycles) begin
        count_tb = (trig_i) ? (fast_i) ? (count_tb +1000000 ) : (count_tb + 1) :count_tb;
        
        msb_lut = count_tb[63:32];
        lsb_lut = count_tb [31:0];
        req_i = 1;
        atomic_i = 1;
        ack_o_tb =1;
        @(posedge clk);
        count_tb =(trig_i) ? count_tb +1 : count_tb;
        atomic_i = 0;
        @(posedge clk); 
    end
    atomic_i = 0;
    req_i = 0;
    ack_o_tb = 0;

end
$finish;
    
end

always_ff @(posedge clk) begin
    req_i_reg <= req_i;
    atomic_i_reg <= atomic_i;
    lsb_lut_reg <= lsb_lut;
    msb_lut_reg <= msb_lut;
    count_tb_reg <= count_tb;
    ack_o_tb_reg <= ack_o_tb;
end

assign bus_mistake = (req_i_reg&ack_o) ? (atomic_i_reg) ? (lsb_lut_reg  != count_o) : (msb_lut_reg != count_o) : '0; 
assign ack_mistak = (ack_o != ack_o_tb_reg);

endmodule