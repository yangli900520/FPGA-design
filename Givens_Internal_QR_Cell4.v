// -------------------------------------------------------------
// 
// File Name: /home/yangli18/Documents/yangzai/PFC/qr_simulink/HDL/qr10/fourxfour_designfxdpt_givens/Givens_Internal_QR_Cell4.v
// Created: 2019-10-01 15:17:02
// 
// Generated by MATLAB 9.5 and HDL Coder 3.13
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: Givens_Internal_QR_Cell4
// Source Path: fourxfour_designfxdpt_givens/fourxfour_designfxdpt/Givens_Internal_QR_Cell4
// Hierarchy Level: 1
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module Givens_Internal_QR_Cell4
          (clk,
           reset,
           enb,
           uin_r,
           uin_i,
           cin,
           sin_r,
           sin_i,
           Bin_r,
           Bin_i,
           Xin_r,
           Xin_i,
           en_bp,
           Enable,
           uout_r,
           uout_i,
           cout,
           sout_r,
           sout_i,
           rout_r,
           rout_i);


  input   clk;
  input   reset;
  input   enb;
  input   signed [23:0] uin_r;  // sfix24_En14
  input   signed [23:0] uin_i;  // sfix24_En14
  input   signed [23:0] cin;  // sfix24_En14
  input   signed [23:0] sin_r;  // sfix24_En14
  input   signed [23:0] sin_i;  // sfix24_En14
  input   signed [23:0] Bin_r;  // sfix24_En14
  input   signed [23:0] Bin_i;  // sfix24_En14
  input   signed [23:0] Xin_r;  // sfix24_En14
  input   signed [23:0] Xin_i;  // sfix24_En14
  input   en_bp;
  input   Enable;
  output  signed [23:0] uout_r;  // sfix24_En14
  output  signed [23:0] uout_i;  // sfix24_En14
  output  signed [23:0] cout;  // sfix24_En14
  output  signed [23:0] sout_r;  // sfix24_En14
  output  signed [23:0] sout_i;  // sfix24_En14
  output  signed [23:0] rout_r;  // sfix24_En14
  output  signed [23:0] rout_i;  // sfix24_En14


  wire signed [47:0] c_uin_r_out1;  // sfix48_En28
  wire signed [24:0] Unary_Minus_cast;  // sfix25_En14
  wire signed [24:0] Unary_Minus_cast_1;  // sfix25_En14
  wire signed [23:0] Unary_Minus_out1;  // sfix24_En14
  wire signed [48:0] complex_mul1_out1;  // sfix49_En28
  wire signed [48:0] complex_mul1_out2;  // sfix49_En28
  wire enb_gated;
  reg signed [23:0] Delay1_out1;  // sfix24_En14
  wire signed [47:0] c_r_r_out1;  // sfix48_En28
  wire signed [49:0] r_new_r_add_cast;  // sfix50_En28
  wire signed [49:0] r_new_r_add_cast_1;  // sfix50_En28
  wire signed [49:0] r_new_r_out1;  // sfix50_En28
  wire signed [23:0] Data_Type_Conversion9_out1;  // sfix24_En14
  wire enb_gated_1;
  reg signed [23:0] Delay_out1;  // sfix24_En14
  wire signed [47:0] c_r_i_out1;  // sfix48_En28
  wire signed [49:0] r_im_r_add_cast;  // sfix50_En28
  wire signed [49:0] r_im_r_add_cast_1;  // sfix50_En28
  wire signed [49:0] r_im_r_out1;  // sfix50_En28
  wire signed [23:0] Data_Type_Conversion8_out1;  // sfix24_En14
  wire signed [48:0] complex_mul_out1;  // sfix49_En28
  wire signed [48:0] complex_mul_out2;  // sfix49_En28
  wire signed [49:0] Add_sub_cast;  // sfix50_En28
  wire signed [49:0] Add_sub_cast_1;  // sfix50_En28
  wire signed [49:0] Add_out1;  // sfix50_En28
  wire signed [23:0] Data_Type_Conversion10_out1;  // sfix24_En14
  wire signed [47:0] c_uin_i_out1;  // sfix48_En28
  wire signed [49:0] Add1_sub_cast;  // sfix50_En28
  wire signed [49:0] Add1_sub_cast_1;  // sfix50_En28
  wire signed [49:0] Add1_out1;  // sfix50_En28
  wire signed [23:0] Data_Type_Conversion11_out1;  // sfix24_En14
  wire signed [24:0] complex_mul_rz1_out1;  // sfix25_En14
  wire signed [24:0] complex_mul_rz1_out2;  // sfix25_En14
  wire signed [23:0] Data_Type_Conversion13_out1;  // sfix24_En14
  wire signed [24:0] Add2_sub_cast;  // sfix25_En14
  wire signed [24:0] Add2_sub_cast_1;  // sfix25_En14
  wire signed [24:0] Add2_out1;  // sfix25_En14
  wire signed [23:0] Data_Type_Conversion16_out1;  // sfix24_En14
  wire signed [23:0] Switch_real_out1;  // sfix24_En14
  wire signed [23:0] Data_Type_Conversion14_out1;  // sfix24_En14
  wire signed [24:0] Add3_sub_cast;  // sfix25_En14
  wire signed [24:0] Add3_sub_cast_1;  // sfix25_En14
  wire signed [24:0] Add3_out1;  // sfix25_En14
  wire signed [23:0] Data_Type_Conversion15_out1;  // sfix24_En14
  wire signed [23:0] Switch_real1_out1;  // sfix24_En14


  assign c_uin_r_out1 = cin * uin_r;



  assign Unary_Minus_cast = {sin_i[23], sin_i};
  assign Unary_Minus_cast_1 =  - (Unary_Minus_cast);
  assign Unary_Minus_out1 = Unary_Minus_cast_1[23:0];



  complex_mul1_block3 u_complex_mul1 (.In1_r(sin_r),  // sfix24_En14
                                      .In1_i(Unary_Minus_out1),  // sfix24_En14
                                      .In2_r(uin_r),  // sfix24_En14
                                      .In2_i(uin_i),  // sfix24_En14
                                      .Out1_r(complex_mul1_out1),  // sfix49_En28
                                      .Out1_i(complex_mul1_out2)  // sfix49_En28
                                      );

  assign enb_gated = Enable && enb;

  assign c_r_r_out1 = cin * Delay1_out1;



  assign r_new_r_add_cast = {complex_mul1_out1[48], complex_mul1_out1};
  assign r_new_r_add_cast_1 = {{2{c_r_r_out1[47]}}, c_r_r_out1};
  assign r_new_r_out1 = r_new_r_add_cast + r_new_r_add_cast_1;



  assign Data_Type_Conversion9_out1 = r_new_r_out1[37:14];



  always @(posedge clk)
    begin : Delay1_process
      if (reset == 1'b1) begin
        Delay1_out1 <= 24'sb000000000000000000000000;
      end
      else begin
        if (enb_gated) begin
          Delay1_out1 <= Data_Type_Conversion9_out1;
        end
      end
    end



  assign enb_gated_1 = Enable && enb;

  assign c_r_i_out1 = cin * Delay_out1;



  assign r_im_r_add_cast = {{2{c_r_i_out1[47]}}, c_r_i_out1};
  assign r_im_r_add_cast_1 = {complex_mul1_out2[48], complex_mul1_out2};
  assign r_im_r_out1 = r_im_r_add_cast + r_im_r_add_cast_1;



  assign Data_Type_Conversion8_out1 = r_im_r_out1[37:14];



  always @(posedge clk)
    begin : Delay_process
      if (reset == 1'b1) begin
        Delay_out1 <= 24'sb000000000000000000000000;
      end
      else begin
        if (enb_gated_1) begin
          Delay_out1 <= Data_Type_Conversion8_out1;
        end
      end
    end



  complex_mul_block3 u_complex_mul (.In1_r(sin_r),  // sfix24_En14
                                    .In1_i(sin_i),  // sfix24_En14
                                    .In2_r(Delay1_out1),  // sfix24_En14
                                    .In2_i(Delay_out1),  // sfix24_En14
                                    .Out1_r(complex_mul_out1),  // sfix49_En28
                                    .Out1_i(complex_mul_out2)  // sfix49_En28
                                    );

  assign Add_sub_cast = {{2{c_uin_r_out1[47]}}, c_uin_r_out1};
  assign Add_sub_cast_1 = {complex_mul_out1[48], complex_mul_out1};
  assign Add_out1 = Add_sub_cast - Add_sub_cast_1;



  assign Data_Type_Conversion10_out1 = Add_out1[37:14];



  assign uout_r = Data_Type_Conversion10_out1;

  assign c_uin_i_out1 = cin * uin_i;



  assign Add1_sub_cast = {{2{c_uin_i_out1[47]}}, c_uin_i_out1};
  assign Add1_sub_cast_1 = {complex_mul_out2[48], complex_mul_out2};
  assign Add1_out1 = Add1_sub_cast - Add1_sub_cast_1;



  assign Data_Type_Conversion11_out1 = Add1_out1[37:14];



  assign uout_i = Data_Type_Conversion11_out1;

  assign cout = cin;

  assign sout_r = sin_r;

  assign sout_i = sin_i;

  complex_mul_rz1_block u_complex_mul_rz1 (.In1_r(Xin_r),  // sfix24_En14
                                           .In1_i(Xin_i),  // sfix24_En14
                                           .In2_r(Data_Type_Conversion9_out1),  // sfix24_En14
                                           .In2_i(Data_Type_Conversion8_out1),  // sfix24_En14
                                           .Out1_r(complex_mul_rz1_out1),  // sfix25_En14
                                           .Out1_i(complex_mul_rz1_out2)  // sfix25_En14
                                           );

  assign Data_Type_Conversion13_out1 = complex_mul_rz1_out1[23:0];



  assign Add2_sub_cast = {Bin_r[23], Bin_r};
  assign Add2_sub_cast_1 = {Data_Type_Conversion13_out1[23], Data_Type_Conversion13_out1};
  assign Add2_out1 = Add2_sub_cast - Add2_sub_cast_1;



  assign Data_Type_Conversion16_out1 = Add2_out1[23:0];



  assign Switch_real_out1 = (en_bp == 1'b0 ? Data_Type_Conversion9_out1 :
              Data_Type_Conversion16_out1);



  assign rout_r = Switch_real_out1;

  assign Data_Type_Conversion14_out1 = complex_mul_rz1_out2[23:0];



  assign Add3_sub_cast = {Bin_i[23], Bin_i};
  assign Add3_sub_cast_1 = {Data_Type_Conversion14_out1[23], Data_Type_Conversion14_out1};
  assign Add3_out1 = Add3_sub_cast - Add3_sub_cast_1;



  assign Data_Type_Conversion15_out1 = Add3_out1[23:0];



  assign Switch_real1_out1 = (en_bp == 1'b0 ? Data_Type_Conversion8_out1 :
              Data_Type_Conversion15_out1);



  assign rout_i = Switch_real1_out1;

endmodule  // Givens_Internal_QR_Cell4

