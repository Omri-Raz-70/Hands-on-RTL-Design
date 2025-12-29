module perf_counters #(
  parameter CNT_W = 4
) (
  input  wire            clk,
  input  wire            reset,
  input  wire            sw_req_i,
  input  wire            cpu_trig_i,
  output wire[CNT_W-1:0] p_count_o
);

reg [CNT_W - 1: 0] p_count_reg;

always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        p_count_reg <= '0;
    end
    else begin
        if (sw_req_i) begin
            if (cpu_trig_i) begin
                p_count_reg <= 1;
            end
            else begin
                p_count_reg <= '0;
            end
        end
        else begin
            if (cpu_trig_i) begin
                p_count_reg <= p_count_reg+1;
            end
        end
    end
end



assign p_count_o = (sw_req_i) ? p_count_reg : '0;

endmodule
