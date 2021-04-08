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


module mat_mult_4_64(

  input signed [31:0] a,
  input signed [31:0] b,
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
   
   reg signed [31:0] zrjr = 0;
   reg signed [31:0] ziji = 0;
   reg signed [31:0] zrji = 0;
   reg signed [31:0] zijr = 0;
   reg signed [31:0] jrjr = 0;
   reg signed [31:0] jiji = 0;
   reg signed [31:0] jrji = 0;
   reg signed [31:0] jijr = 0;

   reg signed [31:0] multreal = 0;
   reg signed [31:0] multimage = 0;
   reg signed [31:0] multreal_j = 0;
   reg signed [31:0] multimage_j = 0;
   
   reg signed [31:0] sub[31:0];
   reg signed [31:0] sub_j[31:0];
   
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
   
   reg signed [31:0] zhreal = 0;
   reg signed [31:0] zhimage = 0;
   reg signed [31:0] jhreal = 0;
   reg signed [31:0] jhimage = 0;
   
   
    reg [3:0] state = 0;
    reg [3:0] row = 0;
    reg [3:0] colunm = 0;


   always@(posedge clk) begin//: genblk
   if ( rst == 1'b0) begin
     // z[si] <= 0;
      //j[si] <= 0;
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
                              flag   <= 1;
                              flag_k <= 1; 
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
   
   
   
 
   
    always@(posedge clk) begin
    if ( rst == 1'b0 ) begin
      
              sumout <= 0;
              checkout_1 <= 0;
              checkout_2 <= 0;

             end  
             
   else if  (flag_sum) begin
  
             sumout <= sub[index];
             checkout_1 <= index;
             checkout_2 <= jhreal;
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
                
                  zrjr <=  z[s_real]   *  j[k_real]; // Real * Real
                  ziji <=  z[s_image]  *  j[k_image]; // Imaginary * Imaginary
                  zrji <=  z[s_real]   *  j[k_image]; // Real * Imaginary
                  zijr <=  z[s_image]  *  j[k_real]; // Imaginary * Real
                               
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
                    //   flag_sub    <=0;
                    end
                       
                        
                    else if (flag_k) begin
                              
                              case (state)
                              4'd0 : begin
                                         if(row == 4) begin
                                              k <= 1;
                                              flag_sum <= 1;
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
                                                    k_image = colunm*64 + k + 256;
                                                    k <= k +1;
                                  
                                                        
                                         
                                                end
                                            end  
                                            
                                 default: begin
                                 end
                                     
                              endcase
                          end
                      end
                      
                                       
       
 

 
endmodule
