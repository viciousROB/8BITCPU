`timescale 1ns / 1ps

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
