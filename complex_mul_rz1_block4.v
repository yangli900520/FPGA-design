// -------------------------------------------------------------
// 
// File Name: /home/yangli18/Documents/yangzai/PFC/qr_simulink/HDL/qr10/fourxfour_designfxdpt_givens/complex_mul_rz1_block4.v
// Created: 2019-10-01 15:17:02
// 
// Generated by MATLAB 9.5 and HDL Coder 3.13
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: complex_mul_rz1_block4
// Source Path: fourxfour_designfxdpt_givens/fourxfour_designfxdpt/Givens_Internal_QR_Cell/complex_mul_rz1
// Hierarchy Level: 2
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module complex_mul_rz1_block4
          (In1_r,
           In1_i,
           In2_r,
           In2_i,
           Out1_r,
           Out1_i);


  input   signed [23:0] In1_r;  // sfix24_En14
  input   signed [23:0] In1_i;  // sfix24_En14
  input   signed [23:0] In2_r;  // sfix24_En14
  input   signed [23:0] In2_i;  // sfix24_En14
  output  signed [24:0] Out1_r;  // sfix25_En14
  output  signed [24:0] Out1_i;  // sfix25_En14


  wire signed [47:0] Product_out1;  // sfix48_En28
  wire signed [23:0] Data_Type_Conversion13_out1;  // sfix24_En14
  wire signed [47:0] Product1_out1;  // sfix48_En28
  wire signed [23:0] Data_Type_Conversion1_out1;  // sfix24_En14
  wire signed [24:0] Add_sub_cast;  // sfix25_En14
  wire signed [24:0] Add_sub_cast_1;  // sfix25_En14
  wire signed [24:0] Add_out1;  // sfix25_En14
  wire signed [47:0] Product2_out1;  // sfix48_En28
  wire signed [23:0] Data_Type_Conversion2_out1;  // sfix24_En14
  wire signed [47:0] Product3_out1;  // sfix48_En28
  wire signed [23:0] Data_Type_Conversion3_out1;  // sfix24_En14
  wire signed [24:0] Add1_add_cast;  // sfix25_En14
  wire signed [24:0] Add1_add_cast_1;  // sfix25_En14
  wire signed [24:0] Add1_out1;  // sfix25_En14


  assign Product_out1 = In1_r * In2_r;



  assign Data_Type_Conversion13_out1 = Product_out1[37:14];



  assign Product1_out1 = In1_i * In2_i;



  assign Data_Type_Conversion1_out1 = Product1_out1[37:14];



  assign Add_sub_cast = {Data_Type_Conversion13_out1[23], Data_Type_Conversion13_out1};
  assign Add_sub_cast_1 = {Data_Type_Conversion1_out1[23], Data_Type_Conversion1_out1};
  assign Add_out1 = Add_sub_cast - Add_sub_cast_1;



  assign Out1_r = Add_out1;

  assign Product2_out1 = In1_i * In2_r;



  assign Data_Type_Conversion2_out1 = Product2_out1[37:14];



  assign Product3_out1 = In1_r * In2_i;



  assign Data_Type_Conversion3_out1 = Product3_out1[37:14];



  assign Add1_add_cast = {Data_Type_Conversion2_out1[23], Data_Type_Conversion2_out1};
  assign Add1_add_cast_1 = {Data_Type_Conversion3_out1[23], Data_Type_Conversion3_out1};
  assign Add1_out1 = Add1_add_cast + Add1_add_cast_1;



  assign Out1_i = Add1_out1;

endmodule  // complex_mul_rz1_block4

