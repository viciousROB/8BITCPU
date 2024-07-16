`timescale 1ns / 1ps

module ControlUnit (
    input [3:0] opcode,
    output reg regWrite,
    output reg memRead,
    output reg memWrite,
    output reg jump,
    output reg [1:0] ALUOp,
    output reg ALUSrc
);
    always @(*) begin
        // Default control signals
        regWrite = 0;
        memRead = 0;
        memWrite = 0;
        jump = 0;
        ALUOp = 2'b00;
        ALUSrc = 0;

        case (opcode)
            4'b0000: begin  // ADD
                regWrite = 1;
                ALUOp = 2'b00;
            end
            4'b0001: begin  // SUB
                regWrite = 1;
                ALUOp = 2'b01;
            end
            4'b0010: begin  // AND
                regWrite = 1;
                ALUOp = 2'b10;
            end
            4'b0011: begin  // OR
                regWrite = 1;
                ALUOp = 2'b11;
            end
            4'b0100: begin  // LOAD
                regWrite = 1;
                memRead = 1;
                ALUSrc = 1;
            end
            4'b0101: begin  // STORE
                memWrite = 1;
                ALUSrc = 1;
            end
            4'b0110: begin  // JUMP
                jump = 1;
            end
        endcase
    end
endmodule
