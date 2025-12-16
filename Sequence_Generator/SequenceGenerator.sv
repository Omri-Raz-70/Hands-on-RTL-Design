module seq_generator#(parameter DataBus = 32)(
    input logic clk,
    input logic reset,
    output logic [DataBus-1:0] seq_o
);

reg [DataBus-1:0] n_1_reg, n_2_reg, n_3_reg;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        n_1_reg   <= 1;
        n_2_reg   <= 0;
        n_3_reg   <= 0;
    end else begin
        n_3_reg   <= n_2_reg;
        n_2_reg   <= n_1_reg;
        n_1_reg   <= n_2_reg + n_3_reg;
    end
end

assign seq_o = n_2_reg + n_3_reg;

endmodule