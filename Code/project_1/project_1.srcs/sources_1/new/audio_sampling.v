`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: UCT Department of Electrical Engineering
// Engineers: Joyce Ejumu, Phalo Mathungana, Tyran Naidoo, Christal Sima
// 
// Create Date: 09.05.2022 21:46:11
// Design Name: YODA: FPGA Flavour
// Module Name: YODA testbench
// Project Name: yoda testbench
// Target Devices: Nexys A7
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision: 1
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module min_max(clk, samples, max, min);

input clk;                      // clock signal 
output reg [15:0] samples;      //audio wave
output reg [15:0] min, max;     //minumum and maximum values of the audio

parameter SIZE = 1024;    
reg [15:0] rom_memory [SIZE-1:0];
integer i;

initial begin                   //initial block, run once
    $readmemh("sine_LUT_values.mem", rom_memory); //Use IP of BRAM instead of this command
    i = 0;
    max=rom_memory[0];
    min=rom_memory[0];
end
  

//At every positive edge of the clock, output a sine wave sample.
always@(posedge clk) begin      //repeats at each clock cycle on positive rise
    samples = rom_memory[i];
    if(i == SIZE)               //end of loop
        i = 0;                  //reset counter to 0
    if (min>rom_memory[i])      //checking the minimum value against the current element
        min=rom_memory[i];      //if the current minimum values is greater than the current element, the element will now replace the min value
    if (max<=rom_memory[i])     //checking the maximum value againt the current element
        max=rom_memory[i];      //if the current maximum values is greater than the current element, the element will now replace the max value 
    i = i+ 1;                   //increment the counter for the next cycle
end
endmodule