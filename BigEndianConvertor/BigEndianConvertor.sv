module big_endian_converter #(
  parameter DATA_W = 32,
  parameter BYTE = 8
)(
  input   wire              clk,
  input   wire              reset,

  input   wire [DATA_W-1:0] le_data_i,

  output  wire [DATA_W-1:0] be_data_o

);

assign be_data_o[(4*BYTE)-1 : 3*BYTE] = le_data_i[(BYTE*1)-1:0];
assign be_data_o[(3*BYTE)-1 : 2*BYTE] = le_data_i[(2*BYTE)-1: 1*BYTE];
assign be_data_o [(2*BYTE) -1 : 1*BYTE] = le_data_i[(3*BYTE)-1 : 2*BYTE];
assign be_data_o[(1*BYTE)-1 : 0] = le_data_i [(4*BYTE)-1 :(3*BYTE)];
endmodule
