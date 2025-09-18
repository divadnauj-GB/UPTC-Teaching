module mux2to1_v0 (
  input  i_X0,  
  input  i_X1, 
  input  i_sel, 
  output  o_Y );

  assign o_Y = (i_X0 & (~i_sel)) | (i_X1 & (i_sel));

endmodule;
