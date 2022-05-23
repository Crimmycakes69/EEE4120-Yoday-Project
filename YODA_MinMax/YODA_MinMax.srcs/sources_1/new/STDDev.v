`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.05.2022 10:50:58
// Design Name: 
// Module Name: STDDev
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


//module STDDev(
//    input Clk,
//    input [15:0] Mean,
//    output [15:0] StdDev
//    );

//parameter SIZE = 1024;                      //the size of the array of sine signals
//reg [15:0] rom_memory [SIZE-1:0];           //the array where the sine signals are stored. This is the data acessed in the code
//integer i, std_sum,x_value, count,top,top_sqrd,inside_brackets; //i is used to access array elements, x_values is the current array element, count is the number of elements that have been acessed

//initial begin                   //initial block, run once
//    $readmemh("sine_LUT_values.mem", rom_memory); //could use IP of BRAM instead of this command
//    i = 0;              //initialise to 0 to access first element in array
//    std=0;              //set std to zero, will change during simulation
//    count=1;            //number of elements accessed, used as N in mean and std formula, increased during each clock cycle

//    //NOTE: The following variables are for the purposes of calculating the std of the data. Their names are more descriptive of their place in the formula of std calculation
//    x_value=0;          //set to zero in begining, will take on array element values during each clock cycle
//    top=0;              //describes x_value-mean
//    top_sqrd=0;         //describes (x_value-mean)^2
//    std_sum=0;          //describes sum((x_values-mean)^2)
//    inside_brackets=0;  //describes sum((x_value-mean)^2)/N

//end

//always@(posedge clk) begin              //repeats at each clock cycle on positive rise
//    x_value = rom_memory[i];            //set x_value of array element
//    top=x_value-mean;                   //x_value-mean
//    top_sqrd=top*top;                   //(x_value-mean)^2
//    std_sum=std_sum+top_sqrd;           //sum((x_values-mean)^2)

//    if(i == SIZE)

//    i = i+ 1;                           //increment the counter for the next cycle     
//    count=count+1;                      //increment no of accessed elements during each clock cycle
     
//inside_brackets=std_sum/count;          // sum((x_value-mean)^2)/clk
////srd=sqrt(inside_brackets);                      //finally, calculate the std of a set of data
//end

//endmodule

//Below is alternative code section added from Phalo's section of the code
module std(
    input clk, mean,                        // takes an input of the clock signal and mean calculated using the mean module
    output reg [15:0] std                   // outputs the calculated standard deviation
    );

parameter SIZE = 1024;                      //the size of the array of sine signals
reg [15:0] rom_memory [SIZE-1:0];           //the array where the sine signals are stored. This is the data acessed in the code
integer i, std_sum,x_value, count,top,top_sqrd,inside_brackets; //i is used to access array elements, x_values is the current array element, count is the number of elements that have been acessed

//squareroot function
    reg [15:0] sqr;

    //Verilog function to find square root of a 32 bit number.
    //The output is 16 bit.
    function [15:0] sqrt;
        input [31:0] num;  //declare input
        //intermediate signals.
        reg [31:0] a;
        reg [15:0] q;
        reg [17:0] left,right,r;    
        integer i;
    begin
        //initialize all the variables.
        a = num;
        q = 0;
        i = 0;
        left = 0;   //input to adder/sub
        right = 0;  //input to adder/sub
        r = 0;  //remainder
        //run the calculations for 16 iterations.
        for(i=0;i<16;i=i+1) begin 
            right = {q,r[17],1'b1};
            left = {r[15:0],a[31:30]};
            a = {a[29:0],2'b00};    //left shift by 2 bits.
            if (r[17] == 1) //add if r is negative
                r = left + right;
            else    //subtract if r is positive
                r = left - right;
            q = {q[14:0],!r[17]};       
        end
        sqrt = q;   //final assignment of output.
    end
    endfunction //end of Function


initial begin                   //initial block, run once
    $readmemh("sine_LUT_values.mem", rom_memory); //could use IP of BRAM instead of this command
    i = 0;              //initialise to 0 to access first element in array
    std=0;              //set std to zero, will change during simulation
    count=1;            //number of elements accessed, used as N in mean and std formula, increased during each clock cycle

    //NOTE: The following variables are for the purposes of calculating the std of the data. Their names are more descriptive of their place in the formula of std calculation
    x_value=0;          //set to zero in begining, will take on array element values during each clock cycle
    top=0;              //describes x_value-mean
    top_sqrd=0;         //describes (x_value-mean)^2
    std_sum=0;          //describes sum((x_values-mean)^2)
    inside_brackets=0;  //describes sum((x_value-mean)^2)/N

end

always@(posedge clk) begin              //repeats at each clock cycle on positive rise
    x_value = rom_memory[i];            //set x_value of array element
    top=x_value-mean;                   //x_value-mean
    top_sqrd=top*top;                   //(x_value-mean)^2
    std_sum=std_sum+top_sqrd;           //sum((x_values-mean)^2)
    i =  i+ 1;                           //increment the counter for the next cycle     
    count=count+1;                      //increment no of accessed elements during each clock cycle
    inside_brackets=std_sum/count;      // sum((x_value-mean)^2)/clk
    std = sqrt(inside_brackets);       //finally, calculate the std of a set of data
    
    if(i == SIZE)
        i = 0;
end

endmodule