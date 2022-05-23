`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.05.2022 10:50:58
// Design Name: 
// Module Name: Mean
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


module Mean(Reset, InData, average);

input Reset;
input [15:0] InData;
output reg [15:0] average;


integer count;
integer sum;

initial begin                       //initial block, run once
count = 0;
sum = 0;
end

always@(posedge Reset) begin                          //repeats at each clock cycle on positive rise
    count = count + 1;
    sum = sum + InData;
    average = sum/count;                         // calculate and set average of a set of data
end

endmodule
