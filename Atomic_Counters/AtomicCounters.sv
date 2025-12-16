module atomic_counters#(
    parameter DataBus = 32,
    parameter CountLen = 64
) (
  input                   clk_w,
  input                   reset_w,
  input                   trig_w_i, // triger input to increment the counter
  input                   req_w_i,  // a read request to the counter
  input                   atomic_w_i, // marks wheather the current request is the first part of the two 32 - bit access to read the 64 bit counterr
  output logic            ack_w_o,  // acknowledge output from the counter
  output logic[DataBus-1:0]      count_w_o  // counter value given as a output to the controller
);


    logic [CountLen-1:0] count_q_reg;
    logic [CountLen-1:0] count_reg;
    logic [CountLen-1:0] cur_count_reg;

    always_ff @(posedge clk or posedge reset) begin
        if (reset)
        count_q[CountLen-1:0] <= 64'h0;
        else
        count_q[CountLen-1:0] <= count_reg;

    end

    always_ff @(posedge clk) begin

    end






    assign count_w_o = count_q

endmodule

