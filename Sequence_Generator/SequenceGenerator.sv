module seq_generator#(parameter DataBus = 32)(
    input logic clk_w,
    input logic reset_w,

    output logic  [DataBus-1:0] seq_o_w
);
logic [DataBus-1:0] n_1_reg = 1;
logic [DataBus-1:0] n_2_reg = '0;
logic [DataBus-1:0] n_3_reg = '0;

logic [DataBus-1:0] seq_o_reg = '0;


always_ff @( posedge clk_w ) begin : seq_o
    if (reset_w) begin
        n_1_reg     <= 1;
        n_2_reg     <= '0;
        n_3_reg     <= '0;
        seq_o_reg   <= '0;
      
    end
    else begin 
        seq_o_reg   <= n_2_reg + n_3_reg;
        n_3_reg     <= n_2_reg;
        n_2_reg     <= n_1_reg;
        n_1_reg     <= n_2_reg + n_3_reg;
    end
    end

assign seq_o_w = seq_o_reg;

endmodule



