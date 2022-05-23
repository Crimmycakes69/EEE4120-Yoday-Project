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


module Section2(clk, interval, sample, min, max);

input clk;                    //Clock
input [15:0] interval;        //Interval in seconds
inout [15:0] min, max;      
inout [15:0] sample;
reg Reset;
wire [15:0] minAvg, maxAvg;

Min min1 (.clk (clk), .sample (sample), .min (min), .Reset(Reset));
Max max1 (.clk (clk), .sample (sample), .max (max), .Reset(Reset));
Mean minMean (.Reset(Reset), .InData(min), .average(minAvg));
Mean maxMean (.Reset(Reset), .InData(max), .average(maxAvg));

parameter frequency = 48000;
integer count, intcounter;
reg [15:0] arrMin[50:0];
reg [15:0] arrMax[50:0];


initial begin
    count <= 0;
    intcounter <= 1;
    Reset <= 0;
end

always@(posedge clk) begin      //repeats at each clock cycle on positive rise
//   if (intcounter > interval)
//      Reset = 1;
//   else Reset = 0;
   if (count == interval*frequency)
   begin
      arrMin[intcounter] = min;
      arrMax[intcounter] = max;
      Reset = 1;
      intcounter = intcounter + 1;
      count = 0;
   end else
   Reset = 0;
   count = count + 1;
end

endmodule
