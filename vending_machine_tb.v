`timescale 1ns/1ns
`include "vending_machine.v"

module vending_machine_tb; 

reg clk, rst;
reg [1:0] in;
wire [1:0] change;
wire out;

vending_machine uut (clk, rst, in, out, change);

initial begin
    $dumpfile("vending_machine.vcd");
    $dumpvars(0, vending_machine_tb);

    $monitor("time: %0t || clk: %0b || rst: %0b || in: %b || out: %b || change: %b", $time, clk, rst, in, out, change);
    
    clk = 0;
    rst = 1;
    in = 2'b00;
     
    #6 rst = 0; in = 2'b01;  

    #10 in = 2'b01;          
    #10 in = 2'b01;         
    #10 in = 2'b00;          
    #10 in = 2'b10;          
    #10 in = 2'b01;          
    #10 in = 2'b10;          
    #10 in = 2'b10;          
    #20 $finish;
end

always #5 clk = ~clk;

endmodule