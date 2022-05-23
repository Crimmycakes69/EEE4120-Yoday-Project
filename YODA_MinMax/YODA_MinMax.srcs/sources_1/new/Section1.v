`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.05.2022 23:03:16
// Design Name: 
// Module Name: Section1
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


module Section1(clk, sample, min, max);

input clk;                 //Clock
inout [15:0] min, max;      
inout [15:0] sample;
reg Reset;

Min min0 (.clk (clk), .sample (sample), .min (min), .Reset(Reset));
Max max0 (.clk (clk), .sample (sample), .max (max), .Reset(Reset));

parameter frequency = 48000; //48 kHz
reg [31:0] count;

initial begin
count = 0;
Reset = 0;
end

always@(posedge clk) begin      //repeats at each clock cycle on positive rise
    count = count + 1;
    if (count == frequency)
        count = 0;
end
endmodule

