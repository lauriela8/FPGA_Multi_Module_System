`timescale 1ns / 1ps


module baudrate (
    input  clk,
    input  rst,
    output baud_tick
);
    parameter BAUD = 9600;
    parameter BAUD_COUNT = 100_000_000 / (BAUD * 8);

    reg [$clog2(BAUD_COUNT) -1:0] count_reg, count_next;
    reg baud_tick_reg, baud_tick_next;

    assign baud_tick = baud_tick_reg;

    always @(posedge clk, posedge rst) begin
        if (rst) begin
            count_reg <= 0;
            baud_tick_reg <= 0;
        end else begin
            count_reg <= count_next;
            baud_tick_reg <= baud_tick_next;

        end
    end

    always @(*) begin
        count_next = count_reg;
        baud_tick_next = 0;
        if (count_reg == BAUD_COUNT - 1) begin
            count_next = 0;
            baud_tick_next = 1;
        end else begin
            count_next = count_reg + 1;
            baud_tick_next = 0;
        end
    end

endmodule
