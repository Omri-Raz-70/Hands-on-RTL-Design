module palindrome3b #(STATEWIDTH =2)(
  input   wire        clk,
  input   wire        reset,

  input   wire        x_i,

  output  wire        palindrome_o
);

  // Write your logic here...
parameter [STATEWIDTH-1:0] RESET = 2'b00, S_1 = 2'b01, WORK = 2'b10; 
reg [1:0] x_i_reg;
reg [STATEWIDTH-1 :0] state, next_state;

always_ff@(posedge clk or posedge reset) begin 
    if (reset) begin
        state <= RESET;
    end
    else begin
        state <= next_state;
    end
end

always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        x_i_reg <= '0;
        end
    else begin
        x_i_reg <= {x_i_reg[0],x_i};
    end
end

always_comb begin 
        case (state)
        RESET : next_state = S_1;
        S_1 : next_state = WORK;
        WORK : begin
            next_state = WORK;
        end 
        default: begin
        next_state = RESET;
        end 
    endcase   
end



assign palindrome_o = (state == WORK) ? ~((x_i_reg[1] ^x_i_reg[0]) ^(x_i_reg[0] ^ x_i)) :0; // 
endmodule