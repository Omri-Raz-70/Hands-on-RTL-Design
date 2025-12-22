module one_shot (
  input   wire        clk,
  input   wire        reset,

  input   wire        data_i,

  output  wire        shot_o

);
    reg data_i_reg;

    always_ff @(posedge clk or posedge reset) begin
        if(reset) begin
            data_i_reg <= 0;
        end
        else begin
            data_i_reg <= data_i; 
        end
    end

assign shot_o = data_i & !(data_i_reg); 

endmodule