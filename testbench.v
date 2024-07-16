`timescale 1ns / 1ps

//Sample Testbench

module testbench;
    // Inputs
    reg clk;
    reg reset;

    // Initiate CPU
    CPU uut (
        .clk(clk),
        .reset(reset)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;  // Toggle clock every 5 time units
    end

    // Initial block for setup
    initial begin
        // Initialize Inputs
        clk = 0;
        reset = 1;

        // Wait for global reset to finish
        #10;
        reset = 0;

        // Wait for a few clock cycles to observe the CPU's behavior
        #100;
        
        // End simulation
        $stop;
    end

endmodule
