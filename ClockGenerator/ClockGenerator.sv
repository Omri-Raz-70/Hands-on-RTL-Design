module clk_gen (
  input   wire        clk_in,

  input   wire        reset,

  output  wire        clk_v1,
  output  wire        clk_v2
);

reg count_reg;

always_ff @(negedge clk_in  or posedge reset) begin
    if (reset) begin
        count_reg <= '0;
    end
    else begin
        count_reg <= count_reg +1;
    end
end

assign clk_v1 = (count_reg == 0) ? 0: clk_in;
assign clk_v2 = (count_reg == 0) ? clk_in : 0;

endmodule