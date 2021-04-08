`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/26/2019 02:36:53 PM
// Design Name: 
// Module Name: test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mat_sub(

  input signed [31:0] a,

  input signed [31:0] b,

  input clk,
  
  input [31:0] index,

  output signed [31:0] sum

   );
   
 reg signed [31:0] z[64*2-1:0];
 reg signed [31:0] j[64*2-1:0];
 reg signed [62:0] j_inv[1:0];
 reg signed [62:0] zjh[1:0];
 reg signed [62:0] result[64*2-1:0];
 reg signed [63:0] temp1;
 reg signed [63:0] temp2;
  reg signed [63:0] temp3;
  reg signed [63:0] temp4;
reg signed [63:0] temp5;
   reg signed [63:0] temp6;   
 //reg signed [31:0] sub[64*2-1:0];
 
 

 integer i = 0 ;
 integer s = 0 ;
 integer k = 0;
 always@(posedge clk)
 
 
   begin
     if (i < 64*2 && a)
 
 
     begin
 
     if (a !==  z[i-1])
 
     begin 
     z[i] = a;
     j[i] = b;
     
     //sub[i] = z[i] - j[i];
     j_inv[0] = 0;
     zjh[0] = 0;
     zjh[1] = 0;
     i = i + 1;
     end
     
     end
     //else if (i == 128)
      
    // begin
     //   for (k = 0; k < 64 ; k = k +1)
    // begin
    // j_inv[0] = j_inv[0] + j[k]*j[k] + j[k+64] * j[k+64];
    // j_inv[1] = 0;

    // end  
     
 //    i = i+1;
  //   end
     
     else if (i == 128 && k<64)
           
         // begin
             //for (k = 0; k < 64 ; k = k +1)
          begin
          temp1 <= z[k]*j[k]; // Real * Real
          temp2 <= z[k+64] * j[k+64]; // Imaginary * Imaginary
          temp3 <= z[k] * j[k+64]; // Real * Imaginary
          temp4 <= z[k+64] * j[k]; // Imaginary * Real
          #1
          //temp5 = @(temp1 && temp2) temp1 - temp2; // One delay calculate real product
         // temp6 = @(temp3 && temp4) temp3 + temp4; // One delay calculate imaginary product
          temp5 <=  temp1 - temp2; // One delay calculate real product
          temp6 <=  temp3 + temp4; // One delay calculate imaginary product
          #1
         zjh[0] <= zjh[0] + temp5; //Vector vector product (real)
         zjh[1] <=  zjh[1] + temp6; //Vector vector product (Imaginary)
         //j_inv[0] = 1;
         //j_inv[1] = 1;
          //zjh[0] = zjh[0] + z[k]*j[k] + z[k+64] * j[k+64];
          //zjh[1] = zjh[1] - z[k] * j[k+64] + z[k+64] * j[k];  
          //j_inv[0] = j_inv[0] + j[k]*j[k] + j[k+64] * j[k+64]
          //j_inv[1] = 0;
          k<=k+1;
          //i = i+1;
          end
          
        //  else if (i == 130)
                
             //  begin
             //     for (k = 0; k < 64 ; k = k +1)
            //   begin
               //zjh[1] = zjh[1] - z[k] * j[k+64] + z[k+64] * j[k];
           //    end  
               
             //  i = i+1;
             //  end
     
     
     
     
     else if (k==64 && s <64)
     begin 
    // for (s = 0; s < 64; s = s +1)
    // begin
    // result[s] = (zjh[0]*j[s] - zjh[1]*j[s+64])/j_inv[0];
    // result[s+64] = (zjh[0]*j[s+64] + zjh[1]*j[s])/j_inv[0];
    result[s] = zjh[0];
    result[s+64] = zjh[1];
     s = s +1;
     end
    // i=i+1;
    // end
     
     //     else if (i == 132)
    // begin 
    // for (s = 0; s < 64; s = s +1)
    // begin
     //result[s+64] = (zjh[0]*j[s+64] + zjh[1]*j[s])/j_inv[0];
    // end
   //  i=i+1;
   //  end
     
     
    sum = result[index];
 end  



endmodule
