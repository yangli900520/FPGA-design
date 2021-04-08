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


module mat_pipeline(

   
 input signed [31:0] a,
  input signed [31:0] b,
  input clk,
  input [31:0] index,
  input rst,

  output reg signed [31:0] sumout
   );
   
    reg signed [31:0] z[511:0];
    reg signed [31:0] j[511:0];
    reg signed [31:0] sum_j; 
    wire signed [31:0]sum_4_4;
    wire signed [31:0] sum_4_64;
    wire signed [31:0] sum_j_4_64;
    wire signed [31:0] sum_j_4_4; 

    reg flag;
    wire flag_k;
    
    wire [7:0] s;
    reg [10:0] i;
    reg [31:0] sub [31:0];
    reg [31:0] sub_j [31:0];
    
    
    //assign flag_out = flag_4_4;

    genvar si;
    generate
        for(si=0; si<512; si=si+1) begin
    always@(posedge clk) begin: genblk
    if ( !rst) begin
       z[si] <= 0;
       j[si] <= 0;
       flag  <= 0;
       i     <= 0;
    end  
    if (!flag) begin
     
          if (index!=i) begin 
                z[index-1] <= a;
                j[index-1] <= b;
                i          <= index;
           end  
           else if (index>512) begin
                               flag   <= 1;
                          end
    end
    end
    end  
    endgenerate
    
    
    genvar zi;
    generate
        for(zi=0; zi<32; zi=zi+1) begin
    always@(posedge clk) begin: genblk
    if ( !rst) begin
       sub[zi]   <= 0;
       sub_j[zi] <= 0;
    end  
    
    if(flag_k) begin  
                sub[s-1]     <= sum_4_64;
                sub[s+15]    <= sum_j_4_64;
                
                sub_j[s-1]     <= sum_4_4;
                sub_j[s+15]    <= sum_j_4_4;
                
                
                
           end  

    end
    end
    
    endgenerate
    
    
    
    
    
     
        
    always@(posedge clk) begin
      if ( rst == 1'b0 ) begin

        sumout <= 0;
       end  
         // if (flag_h) begin
          
         else if  (flag_k) begin

           sumout <= sub[index];
       end
    end
    

        


              


 mat_mult_4_64 uut(
 
   .a(a),
   .b(b),
   .clk(clk),
   .index(index),
   .rst(rst),
   .zhreal(sum_4_64),
   .zhimage(sum_j_4_64),
   .jhreal(sum_4_4),
   .jhimage(sum_j_4_4),
   .flag_k(flag_k),
   .s(s)
   );
  

     

/*mat_mult_4_4 uut4(
 
   .a(sum_4_64),
   .b(sum_j_4_64),
   .clk(clk),
   .index(s),
   .en(flag_4_4),
   .sum(sum_4_4),
   .sum_j(sum_j_4_4)
   
   );*/                                                                                                                                                                                                                                                                                                         
  



  
endmodule







