`timescale 1ns / 1ps

module testBench;
    reg clk;
    wire [15:0] sine;
    wire [15:0] Input_Data; //may be a reg
    wire [15:0] Min_Output;
    wire [15:0] Max_Output;
    wire [15:0] Mean_Output;
    wire [15:0] Std_Output;
    
    //initates and connects the sine generator to the testBench
    sine_gen baseSineGen(.clk (clk), .sineOutput (sine));
    min_max samp(.clk (clk),.samples (Input_Data), .min (Min_Output), .max(Max_Output));
    mean mean1(.clk (clk),.mean(Mean_Output));
    std std1(.clk (clk),.mean(Mean_Output), .std(Std_Output));

    
    //frequency control
    parameter freq = 100000000; //100 MHz
    parameter SIZE = 1024; 
    parameter clockRate = 0.2; //clock time (make this an output from the sine modules)
    
    //Generate a clock with the above frequency control
    initial
    begin 
    clk = 1'b0;
    end
    
    always #clockRate clk = ~clk; //#1 is one nano second delay (#x controlls the speed)
    
endmodule

