module single_cycle_arbiter #(
  parameter N = 32
) (
  input   wire          clk,
  input   wire          reset,
  input   wire [N-1:0]  req_i,
  output  wire [N-1:0]  gnt_o
);

wire [N-1:0] req_i_2s_complement;

assign req_i_2s_complement = ~(req_i) +1;
assign gnt_o = req_i &req_i_2s_complement; 

endmodule

