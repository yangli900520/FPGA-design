`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2019 12:13:32 PM
// Design Name: 
// Module Name: test_QR_single
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


module test_QR_single(

  input signed [31:0] a,//cast data sfix 32 en 14
  input signed [31:0] b,//cast data sfix 32 en 14
  input clk,
  input [31:0] index,
  input rst,

  output reg signed [31:0] sumout,
  output reg signed [31:0] checkout_1,
  output reg signed [31:0] checkout_2

  );
  
  
  
   reg signed [31:0] z[511:0];
   reg signed [31:0] j[511:0];
  
   reg [10:0] i_z=0;
   reg [10:0] i_j=0;

   reg flag=0; 
   reg [10:0] i=0;
   reg [7:0] s=0;
   reg [7:0] k=0;
   reg flag_k = 0;

   
   reg [10:0] i_sub=0;
   reg [10:0] i_sub_j=0;

   
   reg flag_zz = 0;
   reg flag_64 = 0;
   reg flag_sum = 0;
   //reg flag_sub = 0;

   
   
   

    
   
    
    reg [10:0]i_data_qr;
    reg flag_data_qr;
    reg clock_en;
    reg signed [23:0]A1_r;
    reg signed [23:0]A1_i;
    reg signed [23:0]A2_r;
    reg signed [23:0]A2_i;
    reg signed [23:0]A3_r;
    reg signed [23:0]A3_i;
    reg signed [23:0]A4_r;
    reg signed [23:0]A4_i;
    reg signed [23:0]B_in_r_1;
    reg signed [23:0]B_in_i_1;

    reg en_bp44 = 0;
    reg en_in11 = 0;
 //   reg reset = 0;
    wire  ce_out;
    wire  signed [23:0] R_11_r_1;  // sfix24_En14
    wire  signed [23:0] R_11_i_1;  // sfix24_En14
    wire  signed [23:0] R_22_r_1;  // sfix24_En14
    wire  signed [23:0] R_22_i_1;  // sfix24_En14
    wire  signed [23:0] R_33_r_1;  // sfix24_En14
    wire  signed [23:0] R_33_i_1;  // sfix24_En14
    wire  signed [23:0] R_44_r_1;  // sfix24_En14
    wire  signed [23:0] R_44_i_1;  // sfix24_En14

    

    
    reg signed [31:0] Y_inv [31:0]; 

    
    reg [8:0] i_Y_inv; 
    reg [31:0] index_in4;
    reg [31:0] index_in4_1delay;
 //   reg [3:0] in_B;
    reg flag_out_qr;
    reg [10:0]counter_out_qr;

    reg en_4x4;
    reg flag_sub;


    


   always@(posedge clk) begin//: genblk
   if ( rst == 1'b0) begin

      for (i_z=0; i_z<512; i_z=i_z+1) z[i_z] <= 0 ;
      for (i_j=0; i_j<512; i_j=i_j+1) j[i_j] <= 0 ;


      flag  <= 0;
      flag_k<= 0;
      i     <= 0;
   end  

   else if (flag == 0) begin
    
         if (index!=i) begin 
               z[index-1] <= a;
               j[index-1] <= b;
               i          <= index;
          end  
          else if (index == 512) begin
                              flag    <=1;
                              flag_k  <=1; 
                         end
   end
   end



   
   
   
 
   
    always@(posedge clk) begin
    if ( rst == 1'b0 ) begin
             
              clock_en <= 0;
              B_in_r_1 <= 0;
              B_in_i_1 <= 0;

              
                            
              i_data_qr  <= 0;
              flag_data_qr <=0;
              A1_r <=0;
              A1_i <=0;
              A2_r <=0;
              A2_i <=0;
              A3_r <=0;
              A3_i <=0;              
              A4_r <=0;
              A4_i <=0;  
            //  in_B <=0; 
              flag_out_qr <=0;        
             end  
             
   else if  (flag_k) begin
        if  (flag_data_qr == 1'b0) begin
             
             clock_en <=1;
             en_in11   <= 1;
             A1_r <= z[i_data_qr];
             A1_i <= z[i_data_qr + 16];
             A2_r <= z[i_data_qr + 1];
             A2_i <= z[i_data_qr + 17];             
             A3_r <= z[i_data_qr + 2];
             A3_i <= z[i_data_qr + 18];             
             A4_r <= z[i_data_qr + 3];
             A4_i <= z[i_data_qr + 19]; 
             B_in_r_1 <= 0;
             B_in_i_1 <= 0;

             flag_data_qr  <= 1;      
             end     
          
         else if (i_data_qr <12)  begin
              i_data_qr = i_data_qr + 4 ;
              flag_data_qr <=0;
              //in_B <= in_B + 1;
         end
         
           else if (i_data_qr == 12)  begin
           i_data_qr <= 13;
           end
           else if (i_data_qr ==13) begin
              flag_data_qr  <= 1 ;
                      A1_r <=0;
                      A1_i <=0;
                      A2_r <=0;
                      A2_i <=0;
                      A3_r <=0;
                      A3_i <=0;              
                      A4_r <=0;
                      A4_i <=0;  
                      
                      B_in_r_1 <= 0;
                      B_in_i_1 <= 0;

                      flag_out_qr <= 1;
                      i_data_qr = i_data_qr + 1;
           end
           else if (flag_sub) begin
              clock_en <= 0;
              en_in11  <= 0;
            end
           
           
      end
      end
      
      
           always@(posedge clk) begin
                                       if ( rst == 1'b0 ) begin
                                 
                                         sumout <= 0;
                                        end                                            
                                          else if  (flag_sub) begin
                                 
                                            sumout <= Y_inv[index] ;  //z[index] - sum_out4x4 ;
                                            checkout_1 <= z[index];
                                            checkout_2 <= z[index];
                                        end
                                     end 
      
      
            
always@(posedge clk) begin
         if (rst == 1'b0) begin
                en_bp44         <=0;
                counter_out_qr  <=0;
                en_4x4          <=0;
                flag_sub        <=0;
       
                  for (i_Y_inv=0; i_Y_inv<32; i_Y_inv=i_Y_inv+1) begin
                       Y_inv[i_Y_inv] <= 0;
                  end 

          end
         else  if (flag_out_qr)begin
          if( counter_out_qr < 42) begin
                counter_out_qr  <= counter_out_qr + 1;
         end
            else if ( counter_out_qr<54) begin
                    en_bp44   <= 0;
                    counter_out_qr  <= counter_out_qr + 1;
            end
                    
                  else if (counter_out_qr == 54) begin
                    Y_inv[3]  <= R_44_r_1;
                    Y_inv[19] <= -R_44_i_1;
                                                        
                    counter_out_qr  <= counter_out_qr + 1;
                   end
                        else if (counter_out_qr <67 ) begin
                          counter_out_qr  <= counter_out_qr + 1;
                        end
                           else if (counter_out_qr == 67 ) begin
                           Y_inv[2]  <= R_33_r_1;
                           Y_inv[18] <= -R_33_i_1;

                           counter_out_qr  <= counter_out_qr + 1;
                           end
                             else if (counter_out_qr < 79 ) begin  
                             counter_out_qr  <= counter_out_qr + 1;
                             end
                                else if (counter_out_qr == 79) begin
                                counter_out_qr  <= counter_out_qr + 1;
                                Y_inv[1]  <= R_22_r_1;
                                Y_inv[17] <= -R_22_i_1;

                                end
                                    else if (counter_out_qr < 92) begin  
                                    counter_out_qr  <= counter_out_qr + 1;
                                    end
                                        else if (counter_out_qr == 92) begin  
                                        counter_out_qr  <= counter_out_qr + 1;
                                        Y_inv[0]  <= R_11_r_1;
                                        Y_inv[16] <= -R_11_i_1;

                                        en_4x4 <= 1;
                                        flag_sub <=1;
                                        end 
                                        
                                                                                          
          end       
end 

     
        
        
        
        
        
        

                 
            
                 
                 
                 
                 
                      
fourxfour_designfxdpt fourxfour_designfxdpt_instance_colunm1
                                    (
                                    
                                     .clk(clk),
                                     .reset(~rst),
                                     .clock_en(clock_en),
                                     .A1_r(A1_r),
                                     .A1_i(A1_i),
                                     .en_in11(en_in11),
                                     .A2_r(A2_r),
                                     .A2_i(A2_i),
                                     .A3_r(A3_r),
                                     .A3_i(A3_i),
                                     .A4_r(A4_r),
                                     .A4_i(A4_i),
                                     .B_in_r(B_in_r_1),
                                     .B_in_i(B_in_i_1),
                                     .en_bp44(en_bp44),
                                     .ce_out(ce_out),
                                     .R_11_r(R_11_r_1),
                                     .R_11_i(R_11_i_1),
/*                                     .R_12_r(R_12_r),
                                     .R_12_i(R_12_i),
                                     .R_13_r(R_13_r),
                                     .R_13_i(R_13_i),
                                     .R_14_r(R_14_r),
                                     .R_14_i(R_14_i),*/
                                     .R_22_r(R_22_r_1),
                                     .R_22_i(R_22_i_1),
/*                                     .R_23_r(R_23_r),
                                     .R_23_i(R_23_i),
                                     .R_24_r(R_24_r),
                                     .R_24_i(R_24_i),*/
                                     .R_33_r(R_33_r_1),
                                     .R_33_i(R_33_i_1),
/*                                     .R_34_r(R_34_r),
                                     .R_34_i(R_34_i),*/
                                     .R_44_r(R_44_r_1),
                                     .R_44_i(R_44_i_1)/*,
                                     .boutr_1(boutr_1),
                                     .bouti_1(bouti_1),
                                     .boutr_2(boutr_2),
                                     .bouti_2(bouti_2),
                                     .boutr_3(boutr_3),
                                     .bouti_3(bouti_3),
                                     .boutr_4(boutr_4),
                                     .bouti_4(bouti_4)*/
                                     );      
                                     
      
                                       

 

 
endmodule


