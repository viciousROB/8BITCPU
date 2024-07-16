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


module RegisterFile (
    input clk,
    input [2:0] readReg1, readReg2, writeReg,
    input [7:0] writeData,
    input regWrite,
    output [7:0] readData1, readData2
);
    reg [7:0] registers [7:0];

    always @(posedge clk) begin
        if (regWrite)
            registers[writeReg] <= writeData;
    end

    assign readData1 = registers[readReg1];
    assign readData2 = registers[readReg2];
endmodule


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


module DataMemory (
    input clk,
    input [7:0] address,
    input [7:0] writeData,
    input memWrite, memRead,
    output reg [7:0] readData
);
    reg [7:0] memory [255:0];

    always @(posedge clk) begin
        if (memWrite)
            memory[address] <= writeData;
    end

    always @(*) begin
        if (memRead)
            readData = memory[address];
        else
            readData = 8'b00000000;
    end
endmodule



module CPU (
    input clk,
    input reset
);
    wire [7:0] instruction, readData1, readData2, ALUResult, readData, writeData;
    wire [1:0] ALUOp;
    wire regWrite, memRead, memWrite, jump, ALUSrc, Zero;

    // Program Counter
    reg [7:0] pc;
    always @(posedge clk or posedge reset) begin
        if (reset)
            pc <= 8'b00000000;
        else if (jump)
            pc <= instruction[7:0];  // Jump to the address specified by the instruction
        else
            pc <= pc + 1;
    end

    // Instantiate components
    InstructionMemory im(.pc(pc), .instruction(instruction));
    RegisterFile rf(.clk(clk), .readReg1(instruction[7:5]), .readReg2(instruction[4:2]), .writeReg(instruction[4:2]), .writeData(writeData), .regWrite(regWrite), .readData1(readData1), .readData2(readData2));
    ControlUnit cu(.opcode(instruction[15:12]), .regWrite(regWrite), .memRead(memRead), .memWrite(memWrite), .jump(jump), .ALUOp(ALUOp), .ALUSrc(ALUSrc));
    ALU alu(.A(readData1), .B(ALUSrc ? instruction[7:0] : readData2), .ALUOp(ALUOp), .ALUResult(ALUResult), .Zero(Zero));
    DataMemory dm(.clk(clk), .address(ALUResult), .writeData(readData2), .memWrite(memWrite), .memRead(memRead), .readData(readData));

    assign writeData = (memRead) ? readData : ALUResult;

endmodule
