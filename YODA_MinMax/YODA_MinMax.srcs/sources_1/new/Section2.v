`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.05.2022 23:05:55
// Design Name: 
// Module Name: Section2
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


module Section2(clk, sample, min, max);

input clk;                 //Clock
inout [15:0] min, max;      
inout [15:0] sample;

Min min0 (.clk (clk), .sample (sample), .min (min));
Max max0 (.clk (clk), .sample (sample), .max (max));

integer count;

initial begin
count = 0;
end

endmodule
