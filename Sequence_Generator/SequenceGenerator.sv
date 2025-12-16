module seq_generator#(parameter DataBus = 32)(
    input logic clk_w,
    input logic reset_w,

    output logic  [DataBus-1:0] seq_o_w
);
logic [DataBus-1:0] x_0_reg = '0;
logic [DataBus-1:0] x_1_reg = 1;
logic [DataBus-1:0] seq_o_reg = '0;


always_ff @( posedge clk_w ) begin : seq_o
    if (reset_w) begin
        x_0_reg <= '0;
        x_1_reg <= 1;
        seq_o_reg <= '0;
    end
    else begin 
        seq_o_reg <= x_0_reg +x_1_reg;
        x_0_reg <= x_1_reg;
        x_1_reg <= x_0_reg +x_1_reg;
    end
    end

assign seq_o_w = seq_o_reg;

endmodule



// https://github.com/Omri-Raz-70/Hands-on-RTL-Design.git