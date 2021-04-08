`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/26/2019 04:07:43 PM
// Design Name: 
// Module Name: tb_test
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




module mat_tb(

    );
    
        reg signed [31:0] A ;
        reg signed [31:0] B ;
        reg clk;
        wire [31:0] Res;
        reg [10:0] index_limit;
        reg [31:0] index;
        reg reset;
        reg signed [31:0] z_real[0:255];
        reg signed [31:0] z_image[0:255];
        reg signed [31:0] z[0:511];
        reg signed [31:0] s[0:511];
        reg signed [31:0] s_real[0:255];
        reg signed [31:0] s_image[0:255];
        integer i;
        integer j = 0;

        integer outfile0,outfile1,outfile2,outfile3;
        reg flag;
        reg [10:0] i_index = 0;
        reg [10:0] out_index = 0;
        
        initial begin
            i=0;
             outfile0=$fopen("/home/yangli18/Documents/yangzai/FPGA/AXI_project/firstip_0826/my_first_ip/z_real.txt","r");
             outfile1=$fopen("/home/yangli18/Documents/yangzai/FPGA/AXI_project/firstip_0826/my_first_ip/z_image.txt","r");
             outfile2=$fopen("/home/yangli18/Documents/yangzai/FPGA/AXI_project/firstip_0826/my_first_ip/j_real.txt","r");
             outfile3=$fopen("/home/yangli18/Documents/yangzai/FPGA/AXI_project/firstip_0826/my_first_ip/j_image.txt","r");
                  
            while (! $feof(outfile0)) begin //read until an "end of file" is reached.
                     $fscanf(outfile0,"%d\n ",z_real[i]);
                     i = i+1;
                     end
            i=0;
            while (! $feof(outfile1)) begin //read until an "end of file" is reached.
                              $fscanf(outfile1,"%d\n ",z_image[i]);
                              i = i+1;
                              end         
            i=0;
            while (! $feof(outfile2)) begin //read until an "end of file" is reached.
                                       $fscanf(outfile2,"%d\n ",s_real[i]);
                                       i = i+1;
                                       end            
           i=0;
            while (! $feof(outfile3)) begin //read until an "end of file" is reached.

                                                $fscanf(outfile3,"%d\n ",s_image[i]);                         
                                                i = i+1;
                                                end                     
             $fclose(outfile0);
             $fclose(outfile1);
             $fclose(outfile2);
             $fclose(outfile3);
             for (i = 0; i < 256; i = i +1) begin
                                            z[i]       = z_real[i];
                                            z[i+256]   = z_image[i];
                                            s[i]       = s_real[i];
                                            s[i+256]   = s_image[i];                                   
                                             //b[i][j] = A [i+j*64];
                                         end
             
             //        $finish #3000;

             
              end 

        always  begin
        #5 clk =  ~ clk; 

        end

         initial begin
                 clk = 1;
         index = 0;
         index_limit = 0;
         reset = 0;
//         A = 0;
//         B = 0;
         #10; 
         reset = 1;
         flag  = 0;
         #10;
         reset = 1;
         #30; 
         flag  = 1;
         
         
         
         #1000; 
         flag = 0;
         #2000; 
       //  index = 0;
         
         
         end
         
/*         
always begin
   if (flag) begin
     //  if (index < 512) begin          
          #10;
          A = z[index];
          B = s[index];
          #10;
          index = i_index;
          #10;
          i_index = i_index+1;
        end
        //  else if (i_index == 512) begin
         //    index = out_index;
         //    out_index = out_index+1;
         // end
  //  end
end*/
        
         
         
         
         
         
        always
         begin
         


 // if (flag) begin       
//  if (index<513) begin
        #20;
         A<=z[index];
         B<=s[index];
         #10;
      //   index <= 0;
         index_limit <= index_limit+1;
         index<=index_limit;

         #10;
        // index <= 1;
          #20 ;//clk =~clk;

          
          
        A<=z[index];
        B<=s[index];
        //index <= 0;
          #10;
         index_limit <= index_limit+1;
          index<=index_limit;

      #20 ;//clk =~clk;  
      A<=z[index];
      B<=s[index];
    //  index <=index +1;
    
    
            #10;
         index_limit <= index_limit+1;
            index<=index_limit;

          //   end
//              else begin 
//             index <= 0;
//    end
     end
     
        
        
        
        
     collect_data uut(
       .a(A),
       .b(B),
       .index(index),
       .rst(reset),
       .clk(clk),
       .sumout(Res)
     
        );
        
         

endmodule
