module parallel_to_serial #(
  parameter DATA_W = 4,
  parameter COUNTLEN = 2
) (
  input   wire                clk,
  input   wire                reset,

  input   wire                p_valid_i,
  input   wire [DATA_W-1:0]   p_data_i,
  output  wire                p_ready_o,

  output  wire                s_valid_o,
  output  wire                s_data_o,
  input   wire                s_ready_i
);

localparam [1:0] IDLE = 2'b00, HOLD = 2'b01, OUT = 2'b10;
reg [1:0] state, next_state;
reg [COUNTLEN -1:0] countdown_r;
wire [COUNTLEN -1:0] countdown_w;
reg [DATA_W -1:0] p_data_i_r;
reg s_data_o_r;

always_ff @( posedge clk or posedge reset ) begin //fsm FF
    if (reset) begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end

always_ff @(posedge clk or posedge reset) begin // countdown and s_data_o registers
    if (reset) begin
        countdown_r <= '0;
        s_data_o_r <= 0;
    end
    else begin
        s_data_o_r <= s_data_o;
        if (state == OUT) begin
            countdown_r <= countdown_w;
            
        end
        else if (state == IDLE) begin 
            countdown_r <= '0;
        end
    end
end

always_ff @(posedge clk or posedge reset) begin // p_data_i register
    if (reset) begin
        p_data_i_r <= '0;
    end
    else begin 
        if (state ==IDLE) begin
            if (p_valid_i) begin
                p_data_i_r <= p_data_i;
            end
        end
    end
end



always_comb begin  //fsm states transition
    case (state)
        IDLE:begin
            if (p_valid_i) begin
                if (!s_ready_i) begin
                    next_state = HOLD;
                end
                else if (s_ready_i) begin
                    next_state = OUT;
                end
            end
            else begin
                next_state = IDLE;
        end
        end
        HOLD: begin
            if (s_ready_i) begin
                next_state = OUT;
            end
            else begin
                next_state = HOLD;
            end
        end
        OUT: begin
            if (s_ready_i) begin
                if (&(countdown_r) == 1) begin
                    next_state = IDLE;
                end
                else begin
                    next_state = OUT;
                end
            end
            else begin
                next_state = HOLD;
            end
        end
        default:
        next_state = IDLE; 
    endcase
end
// --- wire assignment ---\\
assign countdown_w = (state == OUT) ? countdown_r +1 : countdown_r;
//--- outputs assignments ---\\
assign s_data_o = (state == OUT) ? p_data_i_r[countdown_r] :s_data_o_r;
assign s_valid_o = state ==OUT;
assign p_ready_o = (state == IDLE);

endmodule
