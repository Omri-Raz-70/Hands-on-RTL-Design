module div_by_three #(
parameter REMIND_LEN = 2
)(
  input   wire    clk,
  input   wire    reset,

  input   wire    x_i,

  output  wire    div_o

);

parameter [REMIND_LEN-1:0] REM_0 = 2'b00, REM_1 = 2'b01, REM_2 = 2'b10;

reg [REMIND_LEN-1:0] reminder_reg;
wire [REMIND_LEN-1:0] reminder;


always_ff @(posedge clk or reset) begin
  if (reset) begin
    reminder_reg <= '0;
  end
  else begin
    reminder_reg <= reminder;
  end
end

assign reminder = (reminder_reg == REM_0) ? (x_i ? REM_1 : REM_0) :
                  (reminder_reg == REM_1) ? (x_i ? REM_0 : REM_2) :
                  (x_i ? REM_2 : REM_1) ; // this line is when reminder_reg == REM_2

assign div_o = (reminder == REM_0);

endmodule
