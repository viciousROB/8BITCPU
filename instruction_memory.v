`timescale 1ns / 1ps

module InstructionMemory (
    input [7:0] pc,
    output [15:0] instruction
);
    reg [15:0] memory [255:0];

    initial begin
        // Example instructions
        memory[0] = 16'b0000000000000000;  // ADD R0, R0, R0
        memory[1] = 16'b0001000100100011;  // SUB R1, R2, R3
        // Add more instructions as needed
    end

    assign instruction = memory[pc];
endmodule
