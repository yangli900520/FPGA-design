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


module collect_data(

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
   
   reg signed [62:0] zrjr = 0;
   reg signed [62:0] ziji = 0;
   reg signed [62:0] zrji = 0;
   reg signed [62:0] zijr = 0;
   reg signed [62:0] jrjr = 0;
   reg signed [62:0] jiji = 0;
   reg signed [62:0] jrji = 0;
   reg signed [62:0] jijr = 0;

   reg signed [62:0] multreal = 0;
   reg signed [62:0] multimage = 0;
   reg signed [62:0] multreal_j = 0;
   reg signed [62:0] multimage_j = 0;
   
   reg signed [62:0] sub[31:0];
   reg signed [62:0] sub_j[31:0];
   
   reg [10:0] i_sub=0;
   reg [10:0] i_sub_j=0;
   reg [9:0] s_real=0;
   reg [9:0] k_real;
   reg [9:0] s_image;
   reg [9:0] k_image;
   
   reg flag_zz = 0;
   reg flag_64 = 0;
   reg flag_sum = 0;
   //reg flag_sub = 0;
   
   reg signed [62:0] zhreal = 0;
   reg signed [62:0] zhimage = 0;
   reg signed [62:0] jhreal = 0;
   reg signed [62:0] jhimage = 0;
   
   
    reg [3:0] state = 0;
    reg [3:0] row = 0;
    reg [3:0] colunm = 0;
    
   
    
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
    reg signed [23:0]B_in_r_2;
    reg signed [23:0]B_in_i_2;
    reg signed [23:0]B_in_r_3;
    reg signed [23:0]B_in_i_3;
    reg signed [23:0]B_in_r_4;
    reg signed [23:0]B_in_i_4;
    reg en_bp44 = 0;
    reg en_in11 = 0;
    reg reset = 0;
    
    
    
    wire  ce_out;
    wire  signed [23:0] R_11_r_1;  // sfix24_En14
    wire  signed [23:0] R_11_i_1;  // sfix24_En14
    wire  signed [23:0] R_11_r_2;  // sfix24_En14
    wire  signed [23:0] R_11_i_2;  // sfix24_En14    
    wire  signed [23:0] R_11_r_3;  // sfix24_En14
    wire  signed [23:0] R_11_i_3;  // sfix24_En14    
    wire  signed [23:0] R_11_r_4;  // sfix24_En14
    wire  signed [23:0] R_11_i_4;  // sfix24_En14    
      
    wire  signed [23:0] R_12_r;  // sfix24_En14
    wire  signed [23:0] R_12_i;  // sfix24_En14
    wire  signed [23:0] R_13_r;  // sfix24_En14
    wire  signed [23:0] R_13_i;  // sfix24_En14
    wire  signed [23:0] R_14_r;  // sfix24_En14
    wire  signed [23:0] R_14_i;  // sfix24_En14
    wire  signed [23:0] R_22_r_1;  // sfix24_En14
    wire  signed [23:0] R_22_i_1;  // sfix24_En14
    wire  signed [23:0] R_22_r_2;  // sfix24_En14
    wire  signed [23:0] R_22_i_2;  // sfix24_En14    
    wire  signed [23:0] R_22_r_3;  // sfix24_En14
    wire  signed [23:0] R_22_i_3;  // sfix24_En14    
    wire  signed [23:0] R_22_r_4;  // sfix24_En14
    wire  signed [23:0] R_22_i_4;  // sfix24_En14    
    
    
    wire  signed [23:0] R_23_r;  // sfix24_En14
    wire  signed [23:0] R_23_i;  // sfix24_En14
    wire  signed [23:0] R_24_r;  // sfix24_En14
    wire  signed [23:0] R_24_i;  // sfix24_En14
    wire  signed [23:0] R_33_r_1;  // sfix24_En14
    wire  signed [23:0] R_33_i_1;  // sfix24_En14
    wire  signed [23:0] R_33_r_2;  // sfix24_En14
    wire  signed [23:0] R_33_i_2;  // sfix24_En14    
    wire  signed [23:0] R_33_r_3;  // sfix24_En14
    wire  signed [23:0] R_33_i_3;  // sfix24_En14    
    wire  signed [23:0] R_33_r_4;  // sfix24_En14
    wire  signed [23:0] R_33_i_4;  // sfix24_En14    
    
    
    wire  signed [23:0] R_34_r;  // sfix24_En14
    wire  signed [23:0] R_34_i;  // sfix24_En14
    wire  signed [23:0] R_44_r_1;  // sfix24_En14
    wire  signed [23:0] R_44_i_1;  // sfix24_En14
    wire  signed [23:0] R_44_r_2;  // sfix24_En14
    wire  signed [23:0] R_44_i_2;  // sfix24_En14    
    wire  signed [23:0] R_44_r_3;  // sfix24_En14
    wire  signed [23:0] R_44_i_3;  // sfix24_En14    
    wire  signed [23:0] R_44_r_4;  // sfix24_En14
    wire  signed [23:0] R_44_i_4;  // sfix24_En14
    
        
    wire  signed [23:0] boutr_1;  // sfix24_En14
    wire  signed [23:0] bouti_1;  // sfix24_En14
    wire  signed [23:0] boutr_2;  // sfix24_En14
    wire  signed [23:0] bouti_2;  // sfix24_En14
    wire  signed [23:0] boutr_3;  // sfix24_En14
    wire  signed [23:0] bouti_3;  // sfix24_En14
    wire  signed [23:0] boutr_4;  // sfix24_En14
    wire  signed [23:0] bouti_4;  // sfix24_En14
    
    reg signed [31:0] Y_inv [31:0]; 
    reg signed [31:0] Y_inv_in4; 
    reg signed [31:0] j_in4; 
    
    reg [8:0] i_Y_inv; 
    reg [31:0] index_in4;
    reg [31:0] index_in4_1delay;

    reg flag_out_qr;
    reg [10:0]counter_out_qr;
    reg [3:0] state_out_Y;
    reg [5:0] i_Y;
    reg en_4x4;
    wire flag_sub;
    
    wire  signed [31:0] sum_out4x4;
    wire  signed [31:0] sum_j_out4x4;
    
    reg [3:0] state_qr;
    reg [3:0] colunm_bp; 


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


always@(posedge clk) begin//: genblk
   if ( rst == 1'b0) begin
      //sub[zi]   <= 0;
      //sub_j[zi] <= 0;
       for (i_sub=0; i_sub<32; i_sub=i_sub+1) sub[i_sub] <= 0 ;
       for (i_sub_j=0; i_sub_j<32; i_sub_j=i_sub_j+1) sub_j[i_sub_j] <= 0 ;
   end 
   
   if(flag_64 ) begin  
               sub[s-1]     <= zhreal;
               sub[s+15]    <= zhimage;
               
               sub_j[s-1]     <= jhreal;
               sub_j[s+15]    <= jhimage;
               end
               
            else      if(flag_sum ) begin  
                           sub[s-1]     <= zhreal;
                           sub[s+15]    <= zhimage;
                           
                           sub_j[s-1]     <= jhreal;
                           sub_j[s+15]    <= jhimage;
               
               
          end  

   end
   
   
   
 
   
  /*  always@(posedge clk) begin
    if ( rst == 1'b0 ) begin
             
              clock_en <= 0;
              B_in_r_1 <= 0;
              B_in_i_1 <= 0;
              B_in_r_2 <= 0;
              B_in_i_2 <= 0;              
              B_in_r_3 <= 0;
              B_in_i_3 <= 0;
              B_in_r_4 <= 0;
              B_in_i_4 <= 0;             
              
                            
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
             
   else if  (flag_sum) begin
        if  (flag_data_qr == 1'b0) begin
             
             clock_en <=1;
             en_in11   <= 1;
             A1_r <= sub_j[i_data_qr][37:14];
             A1_i <= sub_j[i_data_qr + 16][37:14];
             A2_r <= sub_j[i_data_qr + 1][37:14];
             A2_i <= sub_j[i_data_qr + 17][37:14];             
             A3_r <= sub_j[i_data_qr + 2][37:14];
             A3_i <= sub_j[i_data_qr + 18][37:14];             
             A4_r <= sub_j[i_data_qr + 3][37:14];
             A4_i <= sub_j[i_data_qr + 19][37:14]; 
             B_in_r_1 <= sub[i_data_qr][37:14];
             B_in_i_1 <= sub[i_data_qr+16][37:14];
             B_in_r_2 <= sub[i_data_qr+1][37:14];
             B_in_i_2 <= sub[i_data_qr+17][37:14];              
             B_in_r_3 <= sub[i_data_qr+2][37:14];
             B_in_i_3 <= sub[i_data_qr+18][37:14];
             B_in_r_4 <= sub[i_data_qr+3][37:14];
             B_in_i_4 <= sub[i_data_qr+19][37:14]; 
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
                      B_in_r_2 <= 0;
                      B_in_i_2 <= 0;              
                      B_in_r_3 <= 0;
                      B_in_i_3 <= 0;
                      B_in_r_4 <= 0;
                      B_in_i_4 <= 0;    
                      flag_out_qr <= 1;
                      i_data_qr = i_data_qr + 1;
           end
           else if (flag_sub) begin
              clock_en <= 0;
              en_in11  <= 0;
            end
           
           
      end
      end*/
      
      
           always@(posedge clk) begin
                                       if ( rst == 1'b0 ) begin
                                 
                                         sumout <= 0;
                                        end                                            
                                          else if  (flag_sub) begin
                                 
                                            sumout <= sum_out4x4 ;  //z[index] - sum_out4x4 ;
                                            checkout_1 <= z[index_in4_1delay];
                                            checkout_2 <= z[index_in4_1delay] - sum_out4x4;
                                        end
                                     end 
      
      
            
always@(posedge clk) begin
           if (rst == 1'b0) begin
                 en_bp44         <=0;
                 counter_out_qr  <=0;
                 en_4x4          <=0;
                 reset           <=1;
                 en_in11         <=0;
                 clock_en <= 0;
                 B_in_r_1 <= 0;
                 B_in_i_1 <= 0;
                 B_in_r_2 <= 0;
                 B_in_i_2 <= 0;              
                 B_in_r_3 <= 0;
                 B_in_i_3 <= 0;
                 B_in_r_4 <= 0;
                 B_in_i_4 <= 0;                                  
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
                 flag_out_qr <=0;  
                 state_qr <=0;      
                 colunm_bp <= 0;
                 for (i_Y_inv=0; i_Y_inv<32; i_Y_inv=i_Y_inv+1) begin
                       Y_inv[i_Y_inv] <= 0;
                 end 

          end
          
               else if (flag_sum) begin
                    
                    case (state_qr)
                    4'd0 : begin
                               if(colunm_bp == 4) begin
                                   // k      <= 1;
                                    en_4x4 <= 1;
                                  //  reset <= 0;
                                 //   flag_sub  <= 1;
                                 clock_en <= 0;
                                 en_in11  <= 0;

                               end
                               else begin
                                   state_qr <= 4'd2;
                                   reset    <= 0;                                   
                                   clock_en <= 1;
                                   en_in11  <= 1;
                               end
                           end                       
                    4'd1 : begin
                               if(counter_out_qr == 93) begin
                                   state_qr  <= 4'd0;
                                   colunm_bp <= colunm_bp + 1;
                                   counter_out_qr <= 0;
                                   reset <= 1;
                               end
                               else begin
                               if( counter_out_qr < 42) begin
                                          counter_out_qr  <= counter_out_qr + 1;
                                        end
                                  else if ( counter_out_qr<54) begin
                                                   en_bp44   <= 1;
                                                   counter_out_qr  <= counter_out_qr + 1;
                                           end
                                                   
                                                 else if (counter_out_qr == 54) begin
                                                   Y_inv[3+colunm_bp*4]  <= R_44_r_1;
                                                   Y_inv[19+colunm_bp*4] <= -R_44_i_1;
                                                                                        
                                                   counter_out_qr  <= counter_out_qr + 1;
                                                  end
                                                       else if (counter_out_qr <67 ) begin
                                                         counter_out_qr  <= counter_out_qr + 1;
                                                       end
                                                          else if (counter_out_qr == 67 ) begin
                                                          Y_inv[2+colunm_bp*4]  <= R_33_r_1;
                                                          Y_inv[18+colunm_bp*4] <= -R_33_i_1;
  
                                                          counter_out_qr  <= counter_out_qr + 1;
                                                          end
                                                            else if (counter_out_qr < 79 ) begin  
                                                            counter_out_qr  <= counter_out_qr + 1;
                                                            end
                                                               else if (counter_out_qr == 79) begin
                                                               counter_out_qr  <= counter_out_qr + 1;
                                                               Y_inv[1+colunm_bp*4]  <= R_22_r_1;
                                                               Y_inv[17+colunm_bp*4] <= -R_22_i_1;

                                                               end
                                                                   else if (counter_out_qr < 92) begin  
                                                                   counter_out_qr  <= counter_out_qr + 1;
                                                                   end
                                                                       else if (counter_out_qr == 92) begin  
                                                                       counter_out_qr  <= counter_out_qr + 1;
                                                                       Y_inv[0 + colunm_bp*4]  <= R_11_r_1;
                                                                       Y_inv[16+colunm_bp*4] <= -R_11_i_1;

                                                                       state_qr  <= 4'd1;
                                                                       reset     <= 1;
                                                                       en_bp44   <= 0;
                                                                       end 

                                   
                               end
                           end
                     4'd2 : begin
                                      if(i_data_qr == 16) begin
                                          
                                          state_qr  <= 4'd1;
                                          i_data_qr <= 0;
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
       
       
                                      end
                                      else begin
                                          if (flag_data_qr == 0) begin
                                          state_qr <= 4'd2;
                                          A1_r <= sub_j[i_data_qr][37:14];
                                          A1_i <= sub_j[i_data_qr + 16][37:14];
                                          A2_r <= sub_j[i_data_qr + 1][37:14];
                                          A2_i <= sub_j[i_data_qr + 17][37:14];             
                                          A3_r <= sub_j[i_data_qr + 2][37:14];
                                          A3_i <= sub_j[i_data_qr + 18][37:14];             
                                          A4_r <= sub_j[i_data_qr + 3][37:14];
                                          A4_i <= sub_j[i_data_qr + 19][37:14]; 
                                          B_in_r_1 <= sub[i_data_qr    + colunm_bp][37:14];
                                          B_in_i_1 <= sub[i_data_qr+16 + colunm_bp][37:14];
                                          flag_data_qr  <= 1;

                                          end 
                                            else if  (flag_data_qr == 1) begin
                                            i_data_qr     <= i_data_qr + 4;
                                            flag_data_qr  <= 0;
                                            state_qr      <= 4'd2;

                                            end
                                      end
                                  end  
                                  
                       default: begin
                       end
                           
                    endcase
                end
            end        
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
/*         else  if (flag_out_qr)begin
          if( counter_out_qr < 42) begin
                counter_out_qr  <= counter_out_qr + 1;
         end
            else if ( counter_out_qr<54) begin
                    en_bp44   <= 1;
                    counter_out_qr  <= counter_out_qr + 1;
            end
                    
                  else if (counter_out_qr == 54) begin
                    Y_inv[3]  <= R_44_r_1;
                    Y_inv[19] <= -R_44_i_1;
                    Y_inv[7]  <= R_44_r_2;
                    Y_inv[23] <= -R_44_i_2;
                    Y_inv[11]  <= R_44_r_3;
                    Y_inv[27] <= -R_44_i_3;                    
                    Y_inv[15]  <= R_44_r_4;
                    Y_inv[31] <= -R_44_i_4;                                                           
                    counter_out_qr  <= counter_out_qr + 1;
                   end
                        else if (counter_out_qr <67 ) begin
                          counter_out_qr  <= counter_out_qr + 1;
                        end
                           else if (counter_out_qr == 67 ) begin
                           Y_inv[2]  <= R_33_r_1;
                           Y_inv[18] <= -R_33_i_1;
                           Y_inv[6]  <= R_33_r_2;
                           Y_inv[22] <= -R_33_i_2;
                           Y_inv[10]  <= R_33_r_3;
                           Y_inv[26] <= -R_33_i_3;                    
                           Y_inv[14]  <= R_33_r_4;
                           Y_inv[30] <= -R_33_i_4;  
                           counter_out_qr  <= counter_out_qr + 1;
                           end
                             else if (counter_out_qr < 79 ) begin  
                             counter_out_qr  <= counter_out_qr + 1;
                             end
                                else if (counter_out_qr == 79) begin
                                counter_out_qr  <= counter_out_qr + 1;
                                Y_inv[1]  <= R_22_r_1;
                                Y_inv[17] <= -R_22_i_1;
                                Y_inv[5]  <= R_22_r_2;
                                Y_inv[21] <= -R_22_i_2;
                                Y_inv[9]  <= R_22_r_3;
                                Y_inv[25] <= -R_22_i_3;                    
                                Y_inv[13]  <= R_22_r_4;
                                Y_inv[29] <= -R_22_i_4; 
                                end
                                    else if (counter_out_qr < 92) begin  
                                    counter_out_qr  <= counter_out_qr + 1;
                                    end
                                        else if (counter_out_qr == 92) begin  
                                        counter_out_qr  <= counter_out_qr + 1;
                                        Y_inv[0]  <= R_11_r_1;
                                        Y_inv[16] <= -R_11_i_1;
                                        Y_inv[4]  <= R_11_r_2;
                                        Y_inv[20] <= -R_11_i_2;
                                        Y_inv[8]  <= R_11_r_3;
                                        Y_inv[24] <= -R_11_i_3;                    
                                        Y_inv[12]  <= R_11_r_4;
                                        Y_inv[28] <= -R_11_i_4;  
                                        en_4x4 <= 1;
                                        end 
                                        
                                                                                          
          end       
end */

always @(posedge clk) begin        
   if ( rst == 1'b0) begin
      Y_inv_in4 <= 0;
      j_in4     <= 0;
      index_in4 <= 0;
      index_in4_1delay <=0;
   end      
   if (flag_sub == 0) begin 
   if (en_4x4) begin
        if (index_in4 <32) begin
             Y_inv_in4 <= Y_inv[index_in4];
             j_in4     <= j[index_in4];
             index_in4 <= index_in4 + 1;
        end
            else if (index_in4 < 512) begin
             j_in4     <= j[index_in4];     
             index_in4 <= index_in4 + 1;
            end 
    end
    end        
                else if (flag_sub)begin
                index_in4 <= index;
                index_in4_1delay <= index_in4;
                end
    
end        
        
        
        
 
      
      always@(posedge clk)
         if (rst == 1'b0) begin
         zrjr <= 0; // Real * Real
         ziji <= 0; // Imaginary * Imaginary
         zrji <= 0; // Real * Imaginary
         zijr <= 0; // Imaginary * Real
         
         jrjr <=  0;
         jiji <=  0;
         jrji <=  0;
         jijr <=  0;
         
         multreal          <= 0;
         multimage         <= 0;
         multreal_j        <= 0;
         multimage_j       <= 0;
             end
       
           else if (!flag_zz) begin
            zrjr <= 0; // Real * Real
            ziji <= 0; // Imaginary * Imaginary
            zrji <= 0; // Real * Imaginary
            zijr <= 0; // Imaginary * Real
            
            jrjr <=  0;
            jiji <=  0;
            jrji <=  0;
            jijr <=  0;
            
            multreal          <= 0;
            multimage         <= 0;
            multreal_j        <= 0;
            multimage_j       <= 0;
            
      
            
      
      
            
           end
                  else if (flag_zz ) begin
                
                  zrjr <=  j[s_real]   *  z[k_real]; // Real * Real
                  ziji <=  j[s_image]  *  z[k_image]; // Imaginary * Imaginary
                  zrji <=  j[s_real]   *  z[k_image]; // Real * Imaginary
                  zijr <=  j[s_image]  *  z[k_real]; // Imaginary * Real
                               
                  jrjr <=  j[s_real]   *  j[k_real];
                  jiji <=  j[s_image]  *  j[k_image];
                  jrji <=  j[s_real]   *  j[k_image];
                  jijr <=  j[s_image]  *  j[k_real];
                  
                       
                  multreal    <= multreal    + zrjr + ziji;
                  multimage   <= multimage   - zrji + zijr;
                  multreal_j  <= multreal_j  + jrjr + jiji;
                  multimage_j <= multimage_j - jrji + jijr;             
end
                 
always @(posedge clk) begin  
                      if (rst == 1'b0) begin
                            
                      zhreal    <= 0;
                      zhimage   <= 0;
                      jhreal    <= 0;
                      jhimage   <= 0;
                      s         <=0;
                 
                      end
                      else if (flag_64) begin    
                      zhreal    <= multreal+ zrjr + ziji;
                      zhimage   <= multimage- zrji + zijr;
                      jhreal    <= multreal_j+ jrjr + jiji;
                      jhimage   <= multimage_j- jrji + jijr;
                      s         <= row*4 +colunm;    
                 
                      end
                 end                 
                 
                 
                 
                 
always @(posedge clk) begin
                   if (rst == 1'b0) begin
                       k           <=0;
                       state       <=0;
                       colunm      <=0;
                       row         <=0;
                       s_real      <=0;
                       s_image     <=0;
                       k_real      <=0;
                       k_image     <=0;
                       flag_zz     <=0;
                       flag_64     <=0;
                     //  reset       <=1;
                    //   flag_sub    <=0;
                    end
                       
                        
                    else if (flag_k) begin
                              
                              case (state)
                              4'd0 : begin
                                         if(row == 4) begin
                                              k <= 1;
                                              flag_sum <= 1;
                                            //  reset <= 0;
                                           //   flag_sub  <= 1;

                                         end
                                         else begin
                                             state <= 1'b1;
                                             colunm <= 0;
                                         end
                                     end                       
                              4'd1 : begin
                                         if(colunm == 4) begin
                                             state  <= 4'd0;
                                             row    <= row + 1;
                                             colunm <= 0;
                                             flag_zz <= 0;
                                              flag_64<=0;
                                             
                                         end
                                         else begin
                                             state <= 4'd2;
                                                
                                             flag_zz <= 0;
                                              flag_64<=0;
                                             
                                         end
                                     end
                               4'd2 : begin
                                                if(k == 64) begin
                                                    
                                                    state  <= 4'd1;
                                                    colunm <= colunm + 1;
                                                    k      <= 0;
                                                    flag_zz <= 1;
                                                    flag_64<=1;
                 
                                                end
                                                else begin
                                                    flag_zz <= 1;
                                                    state <= 4'd2;
                                                    s_real <= row*64 + k ;
                                                    k_real <= colunm*64 + k;
                                                    s_image <= row*64 + k + 256;
                                                    k_image <= colunm*64 + k + 256;
                                                    k <= k +1;
                                  
                                                        
                                         
                                                end
                                            end  
                                            
                                 default: begin
                                 end
                                     
                              endcase
                          end
                      end
                      
fourxfour_designfxdpt fourxfour_designfxdpt_instance_colunm1
                                    (
                                    
                                     .clk(clk),
                                     .reset(reset),
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
                                     .R_22_r(R_22_r_1),
                                     .R_22_i(R_22_i_1),
                                     .R_33_r(R_33_r_1),
                                     .R_33_i(R_33_i_1),
                                     .R_44_r(R_44_r_1),
                                     .R_44_i(R_44_i_1)
                                     );      
                                     
                                                     
 
           
  mat_mult_4_4 mat_mult_4_4_instant_Yj(
     .a(Y_inv_in4),
     .b(j_in4),
     .clk(clk),
     .rst(rst),
     .en(en_4x4),
     .index(index_in4),
     .sum(sum_out4x4),
     .flag_sub(flag_sub)
      );                     
                      
                                       

 

 
endmodule
