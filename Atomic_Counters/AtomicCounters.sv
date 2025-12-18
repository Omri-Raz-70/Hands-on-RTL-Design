module atomic_counters#(
    parameter DATABUS = 32,
    parameter COUNTLEN = 64
) (
  input  wire            clk,
  input  wire            reset,
  input  wire            trig_i,
  input  wire            req_i,
  input  wire            atomic_i,
  input  wire            fast_i,
  output wire            ack_o,
  output wire[DATABUS-1:0]      count_o
);


  wire [COUNTLEN-1:0] count;
  reg [DATABUS-1 : 0] count_msb_reg;
  reg req_i_reg;
  reg atomic_i_reg;

  

  // --------------------------------------------------------
  // DO NOT CHANGE ANYTHING HERE
  // --------------------------------------------------------
  reg  [COUNTLEN-1:0] count_q;

  always_ff @(posedge clk or posedge reset)begin
    if (reset)begin
        count_q[COUNTLEN-1:0]   <= 64'b0;
    end
    else begin
        count_q[COUNTLEN-1:0]   <= count; //the register will update each clock cycle
    end
  end
  // --------------------------------------------------------

always_ff @(posedge clk or posedge reset)begin 
    if (reset)begin
        count_msb_reg           <= 32'b0;
        req_i_reg               <= 1'b0;
        atomic_i_reg            <= 1'b0;
    end
    else begin
        count_msb_reg           <= (atomic_i) ?count_q[63:32]: count_msb_reg; // when assign we will use the prev value
        req_i_reg               <= req_i;
        atomic_i_reg            <= atomic_i; 
    end
end


assign count = (trig_i) ? (fast_i) ? (count_q + 1000000) : (count_q +1) : count_q; // checked also with 32'hFFFF
assign count_o = (req_i_reg) ? ((atomic_i_reg) ? count_q[DATABUS-1 :0] :count_msb_reg): 32'b0;
assign ack_o = req_i_reg;


endmodule

