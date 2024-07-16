`timescale 1ns / 1ps

module ALU (
    input [7:0] A, B,
    input [1:0] ALUOp,
    output reg [7:0] ALUResult,
    output reg Zero
);
    always @(*) begin
        case (ALUOp)
            2'b00: ALUResult = A + B;  // Addition
            2'b01: ALUResult = A - B;  // Subtraction
            2'b10: ALUResult = A & B;  // AND
            2'b11: ALUResult = A | B;  // OR
            default: ALUResult = 8'b00000000;
        endcase
        Zero = (ALUResult == 8'b00000000) ? 1 : 0;
    end
endmodule
