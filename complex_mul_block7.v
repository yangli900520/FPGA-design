// -------------------------------------------------------------
// 
// File Name: /home/yangli18/Documents/yangzai/PFC/qr_simulink/HDL/qr10/fourxfour_designfxdpt_givens/complex_mul_block7.v
// Created: 2019-10-01 15:17:02
// 
// Generated by MATLAB 9.5 and HDL Coder 3.13
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: complex_mul_block7
// Source Path: fourxfour_designfxdpt_givens/fourxfour_designfxdpt/Givens_Internal_QR_Cell1/complex_mul
// Hierarchy Level: 2
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module complex_mul_block7
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
  output  signed [48:0] Out1_r;  // sfix49_En28
  output  signed [48:0] Out1_i;  // sfix49_En28


  wire signed [47:0] Product_out1;  // sfix48_En28
  wire signed [47:0] Product1_out1;  // sfix48_En28
  wire signed [48:0] Add_sub_cast;  // sfix49_En28
  wire signed [48:0] Add_sub_cast_1;  // sfix49_En28
  wire signed [48:0] Add_out1;  // sfix49_En28
  wire signed [47:0] Product2_out1;  // sfix48_En28
  wire signed [47:0] Product3_out1;  // sfix48_En28
  wire signed [48:0] Add1_add_cast;  // sfix49_En28
  wire signed [48:0] Add1_add_cast_1;  // sfix49_En28
  wire signed [48:0] Add1_out1;  // sfix49_En28


  assign Product_out1 = In1_r * In2_r;



  assign Product1_out1 = In1_i * In2_i;



  assign Add_sub_cast = {Product_out1[47], Product_out1};
  assign Add_sub_cast_1 = {Product1_out1[47], Product1_out1};
  assign Add_out1 = Add_sub_cast - Add_sub_cast_1;



  assign Out1_r = Add_out1;

  assign Product2_out1 = In1_i * In2_r;



  assign Product3_out1 = In1_r * In2_i;



  assign Add1_add_cast = {Product2_out1[47], Product2_out1};
  assign Add1_add_cast_1 = {Product3_out1[47], Product3_out1};
  assign Add1_out1 = Add1_add_cast + Add1_add_cast_1;



  assign Out1_i = Add1_out1;

endmodule  // complex_mul_block7

