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


module mat_mult_4_4(
  input signed [31:0] a,
  input signed [31:0] b,
  input clk,
  inout rst,
  input en,
  input [31:0] index,
  output reg signed [31:0] sum,
  output reg flag_sub

   );
   
    reg signed [31:0] z[31:0];
    reg signed [31:0] j[511:0];
    reg signed [63:0] zrjr = 0;
    reg signed [63:0] ziji = 0;
    reg signed [63:0] zrji = 0;
    reg signed [63:0] zijr = 0;
/*    reg signed [63:0] jrjr = 0;
    reg signed [63:0] jiji = 0;
    reg signed [63:0] jrji = 0;
    reg signed [62:0] jijr = 0;*/
    reg signed [62:0] multreal        = 0;
    reg signed [62:0] multimage       = 0;
  //  reg signed [62:0] multreal_j      = 0;
  //  reg signed [62:0] multimage_j     = 0;
    reg signed [62:0] sub[511:0];
  //  reg signed [62:0] sub_j[31:0];  
    reg flag   = 1;
    reg flag_k = 0;
    reg flag_s = 0;
    reg flag_h = 0;
    reg signed [31:0] Zq = 0;
    reg signed [31:0] Jq = 0;  
    //reg [10:0] i = 0 ;
    reg [7:0] k = 0;
    reg [10:0] s = 0;
    reg [9:0] s_real = 0 ;
    reg [9:0] k_real = 0;
    reg [9:0] s_image = 0 ;
    reg [9:0] k_image = 0;
    //reg rst = 0;
    reg [3:0] state = 0 ;
    reg [3:0] row = 0;
    reg [8:0] colunm = 0;
    reg [10:0] i_z=0;
    reg [10:0] i_j=0;
    
    reg [10:0] i_sub=0;
    reg [10:0] i_sub_j=0;
    reg flag_zz = 0;
    reg flag_64 = 0;
    reg flag_sum = 0;
    
    reg signed [62:0] zhreal = 0;
    reg signed [62:0] zhimage = 0;
  //  reg signed [62:0] jhreal = 0;
  //  reg signed [62:0] jhimage = 0;    
    
    
always@(posedge clk) begin //: genblk
    if ( rst == 1'b0) begin
 
       for (i_z=0; i_z<32;  i_z=i_z+1) z[i_z] <= 0 ;
       for (i_j=0; i_j<512; i_j=i_j+1) j[i_j] <= 0 ;
 
 
       flag  <= 0;
       flag_k<= 0;
     //  i     <= 0;
    end  
 
    else if (flag == 0) begin
           if (en == 1 )begin    
             if (index < 33) begin 
                z[index-1] <= a;
                j[index-1] <= b;
             //   i          <= index;
             end             
                else if (index == 512) begin
                  flag    <=1;
                  flag_k  <=1; 
                  j[index-1] <= b;
                end
                    else begin
                      j[index-1] <= b;
                    end    
           end  
    end
end
    
    
always@(posedge clk) begin//: genblk
   if ( rst == 1'b0) begin
      //sub[zi]   <= 0;
      //sub_j[zi] <= 0;
       for (i_sub=0; i_sub<512; i_sub=i_sub+1) sub[i_sub] <= 0 ;
    //   for (i_sub_j=0; i_sub_j<32; i_sub_j=i_sub_j+1) sub_j[i_sub_j] <= 0 ;
   end 
   
   if(flag_64 ) begin  
               sub[s-1]     <= zhreal;
               sub[s+255]    <= zhimage;
               
           //    sub_j[s-1]     <= jhreal;
           //    sub_j[s+15]    <= jhimage;
               end
               
            else      if(flag_sum ) begin  
                           sub[s-1]     <= zhreal;
                           sub[s+255]    <= zhimage;
                           
                       //    sub_j[s-1]     <= jhreal;
                       //    sub_j[s+15]    <= jhimage;
               
               
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
                          flag_sub    <=0;
                       end
                          
                           
                       else if (flag_k) begin
                                 
                                 case (state)
                                 4'd0 : begin
                                            if(row == 4) begin
                                                 k <= 1;
                                                 flag_sum <= 1;
                                                 flag_sub  <= 1;
   
                                            end
                                            else begin
                                                state <= 1'b1;
                                                colunm <= 0;
                                            end
                                        end                       
                                 4'd1 : begin
                                            if(colunm == 64) begin
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
                                                   if(k == 4) begin
                                                       
                                                       state  <= 4'd1;
                                                       colunm <= colunm + 1;
                                                       k      <= 0;
                                                       flag_zz <= 0;
                                                       flag_64<=1;
                    
                                                   end
                                                   else begin
                                                       flag_zz <= 1;
                                                       state <= 4'd2;
                                                       s_real <= row*4 + k ;
                                                       k_real <= colunm + k*64;
                                                       s_image <= row*4 + k + 16;
                                                       k_image <= colunm + k*64 + 256;
                                                       k <= k +1;
                                     
                                                           
                                            
                                                   end
                                               end  
                                               
                                    default: begin
                                    end
                                        
                                 endcase
                             end
                         end 
    
      always@(posedge clk)
                            if (rst == 1'b0) begin
                            zrjr <= 0; // Real * Real
                            ziji <= 0; // Imaginary * Imaginary
                            zrji <= 0; // Real * Imaginary
                            zijr <= 0; // Imaginary * Real

                            
                            multreal          <= 0;
                            multimage         <= 0;

                                end
                          
                              else if (!flag_zz) begin
                               zrjr <= 0; // Real * Real
                               ziji <= 0; // Imaginary * Imaginary
                               zrji <= 0; // Real * Imaginary
                               zijr <= 0; // Imaginary * Real

                               
                               multreal          <= 0;
                               multimage         <= 0;

                               
                         
                               
                         
                         
                               
                              end
                                     else if (flag_zz ) begin
                                   
                                     zrjr <=  j[k_real]   *  z[s_real]; // Real * Real
                                     ziji <=  j[k_image]  *  z[s_image]; // Imaginary * Imaginary
                                     zrji <=  j[k_image]  *  z[s_real]; // Real * Imaginary
                                     zijr <=  j[k_real]   *  z[s_image]; // Imaginary * Real

                                     
                                          
                                     multreal    <= multreal    + zrjr - ziji;
                                     multimage   <= multimage   + zrji + zijr;
          
                   end    
    
  always @(posedge clk) begin  
                                         if (rst == 1'b0) begin
                                               
                                         zhreal    <= 0;
                                         zhimage   <= 0;
//                                         jhreal    <= 0;
                                     //    jhimage   <= 0;
                                         s         <= 0;
                                    
                                         end
                                         else if (flag_64) begin    
                                         zhreal    <= multreal+ zrjr - ziji;
                                         zhimage   <= multimage+ zrji + zijr;

                                         s         <= row*64 +colunm;    
                                    
                                         end
                                    end    
    
     always@(posedge clk) begin
                                      if ( rst == 1'b0 ) begin
                                
                                        sum <= 0;
                                       end                                            
                                         else if  (flag_sub) begin
                                
                                           sum <= sub[index][45:14];
                                       end
                                    end   
    
    
    
    
    
    
    
        
    
  

  
endmodule
