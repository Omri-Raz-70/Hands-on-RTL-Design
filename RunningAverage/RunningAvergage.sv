module running_average #(
  parameter N = 4,
  parameter DATAWIDTH = 32
)(
  input   wire        clk,
  input   wire        reset,

  input   wire [DATAWIDTH -1 : 0] data_i,

  output  wire [DATAWIDTH -1 : 0] average_o 

);
localparam M = $clog2(N) ;

reg [DATAWIDTH -1 : 0] last_N_inputs [0: N-1];
reg [DATAWIDTH -1 : 0] sum_old; // sum cannot get value bigger tha 32 bits
wire [DATAWIDTH-1 : 0] sum_new;

int i;

always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        sum_old <= '0;
        for (i = 0; i< N; i++) begin
            last_N_inputs[i] <= '0;
        end
    end
    else begin 
        for (i = N -1; i> 0; i-- ) begin
            last_N_inputs[i] <= last_N_inputs[i-1];
    end
        last_N_inputs[0] <= data_i;
        sum_old <= sum_new;
    end
end

assign sum_new = (reset) ? '0 : (sum_old - last_N_inputs[N-1] + data_i);
assign average_o = (reset) ? '0 : (sum_new >> M);

endmodule
