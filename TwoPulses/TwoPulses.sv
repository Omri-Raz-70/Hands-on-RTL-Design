module two_pulses #(
    parameter REGWIDTH =2
)
(
  input   wire       clk,
  input   wire       reset,

  input   wire       x_i,
  input   wire       y_i,

  output  wire       p_o

);

    reg [REGWIDTH -1 :0] y_i_reg;
    reg p_o_reg;
    reg [REGWIDTH -1 :0] state , next_state;
    reg more_than_2;

    parameter [REGWIDTH-1 :0] RESET = 2'b00, IDLE = 2'b01, WAITING = 2'b10;

    always_ff @(  posedge clk or posedge reset ) begin // FSM ff and p_out_reg_ff
        if (reset) begin
            state <= RESET;
            p_o_reg <= '0;
        end
        else begin
            state <= next_state;
            p_o_reg <= p_o;
        end
    end

    
    
    
    
    always @(state or y_i or x_i) begin
        case (state)
            RESET: begin
                next_state = (y_i) ? IDLE : RESET;
            end
            IDLE : begin
                next_state = (x_i) ? WAITING : IDLE; 
                end
            WAITING: begin
                next_state = (y_i) ? IDLE : WAITING;
            end
            default:
            next_state = RESET;
        endcase   
    end

    always_ff @(posedge clk or posedge reset) begin //y_i_reg_ff
        if (reset) begin
            y_i_reg <= '0;
            more_than_2 <= 0;
        end
        else begin
            if (x_i) begin
                y_i_reg <= {1'b0, y_i};
                more_than_2 <= 0;
            end
            else begin
                if (y_i) begin
                    y_i_reg <= {y_i_reg[0] , y_i};
                    more_than_2 <= (y_i_reg == 2'b11) && y_i;
                end
            end 
        end
    end

    assign p_o = (state == RESET) ? 0 : (state == IDLE) ? ((y_i_reg == 2'b11) && x_i && !(more_than_2)) : (y_i) ? ((y_i_reg == 2'b11) && x_i && !(more_than_2)) : p_o_reg;


    

endmodule
