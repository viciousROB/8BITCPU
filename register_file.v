`timescale 1ns / 1ps

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
