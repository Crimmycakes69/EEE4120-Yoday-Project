`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.05.2022 10:50:58
// Design Name: 
// Module Name: MinMax
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


module Max(clk, sample, max, Reset);

input clk;                      // clock signal 
input  [15:0] sample;      //audio wave
output reg [15:0] max;     //maximum value of the audio
input Reset;

initial begin                   //initial block, run once
    max <= 0;
end

always@(posedge clk) begin      //repeats at each clock cycle on positive rise
    if (Reset == 1)
        max <= 0;
    else if (max <= sample)          //checking the maximum value againt the current element
        max <= sample;          //if the current maximum values is greater than the current element, the element will now replace the max value

end

endmodule


module Min(clk, sample, min, Reset);

input clk;                      // clock signal 
input  [15:0] sample;           //audio wave
output reg [15:0] min;          //minumum value of the audio
input Reset;

initial begin                   //initial block, run once
    min <= 16'hFFFF;
end

always@(posedge clk) begin      //repeats at each clock cycle on positive rise
    if (Reset == 1)
        min <= 16'hFFFF;
    else if (min > sample)       //checking the minimum value against the current element
        min <= sample;      //if the current minimum values is greater than the current element, the element will now replace the min value

end

endmodule