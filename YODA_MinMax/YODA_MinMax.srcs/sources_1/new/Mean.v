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


module Mean(clk, out);

input clk;
////input [15:0] Sample;
//output reg [15:0] mean;
output reg [31:0] out;

//parameter SIZE = 1024;              //the size of the array of sine signals
//reg [15:0] rom_memory [SIZE-1:0];   //the array where the sine signals are stored. This is the data acessed in the code
//integer i, sum,x_value, count;      //i is used to access array elements, x_values is the current array element, count is the number of elements that have been acessed
integer count;

initial begin                       //initial block, run once
//    $readmemh("sine_LUT_values.mem", rom_memory);   //could use IP of BRAM instead of this command
//    i = 0;                                          //initialise to 0 to access first element in array
//    mean=0;                                         //set mean to zero, will change during simulation
//    sum=0;                                          //set sum to zero, will increase using cumulative addition
//    x_value=0;                                      //set to zero in begining, will take on array element values during each clock cycle
//    count=1;
                                        //number of elements accessed, used as N in mean and std formula, increased during each clock cycle
end

always@(posedge clk) begin                          //repeats at each clock cycle on positive rise
//    x_value = rom_memory[i];                        //set x_value of array element
//    sum = sum + x_value;                            //cumulative addition of x_value

//    if(i == SIZE)
    
//    i = i+ 1;                                       //increment the counter for the next cycle     
//    count=count+1;                                  //increment no of accessed elements during each clock cycle
     
//mean=sum/count;                                     //finally, calculate the mean of a set of data
end

endmodule
