`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.05.2022 10:53:01
// Design Name: 
// Module Name: testbench
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


module testbench;
    reg clk;
    reg Enable;
    wire [15:0] sine;
    wire [15:0] Input_Data; //may be a reg
    wire [15:0] Min_Output;
    wire [15:0] Max_Output;
    wire [15:0] Mean_Output;
    wire [15:0] Std_Output;
    wire [15:0] N;
    
    //initates and connects the sine generator to the testBench
    sine_gen baseSineGen(.clk (clk), .sineOutput (sine));
    Section1 section1 (.clk(clk), .sample(sine), .min(Min_Output), .max(Max_Output));
    //Min min0(.clk (clk),.sample (sine), .min (Min_Output));
    //Max max0(.clk (clk),.sample (sine), .max (Max_Output), .out(out));
    //Mean mean1 (.clk(clk), .out(out));
    //Mean mean1(.clk (clk),.mean(Mean_Output));
    //std std1(.clk (clk),.mean(Mean_Output), .std(Std_Output));

    
    //frequency control
    parameter freq = 100000000; //100 MHz
    parameter SIZE = 1024; 
    parameter clockRate = 0.2; //clock time (make this an output from the sine modules)
    
    //Generate a clock with the above frequency control
initial
begin 
    Enable = 1;
    clk = 1'b0;
end
    //Set Somewhere somehow to 96kHz
always #clockRate clk = ~clk; //#1 is one nano second delay (#x controlls the speed)

endmodule
