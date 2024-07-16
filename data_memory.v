`timescale 1ns / 1ps

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
