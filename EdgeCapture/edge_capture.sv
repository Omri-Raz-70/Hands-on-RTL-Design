module edge_capture #(
    parameter DATAWIDTH = 32
)
(
  input   wire        clk,
  input   wire        reset,

  input   wire [DATAWIDTH-1 : 0] data_i,

  output  wire [DATAWIDTH-1 : 0] edge_o

);

reg [DATAWIDTH-1 : 0] data_prv;
reg [DATAWIDTH -1 :0] edge_o_reg;


always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        data_prv <= '0;
        edge_o_reg <= '0;
    end
    else begin
        data_prv <= data_i;
        edge_o_reg <= edge_o;
    end
end
assign edge_o =((data_prv) & (~(data_i))) | edge_o_reg;

endmodule
