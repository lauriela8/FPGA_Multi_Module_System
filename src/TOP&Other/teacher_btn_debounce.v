`timescale 1ns / 1ps

module btn_debounce (
    input  clk,
    input  rst,
    input  i_btn,
    output o_btn
);
    parameter F_COUNT = 1000;
    // 100Khz
    reg [$clog2(F_COUNT)-1:0] r_counter;
    reg r_clk;
    reg [7:0] q_reg, q_next;
    wire w_debounce;

    // 100KHz r_clk 생성.
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            r_counter <= 0;
            r_clk <= 0;
        end else begin
            if (r_counter == (F_COUNT - 1)) begin
                r_counter <= 0;
                r_clk <= 1'b1;
            end else begin
                r_counter <= r_counter + 1;
                r_clk <= 1'b0;
            end
        end
    end

    // debounce
    always @(posedge r_clk, posedge rst) begin
        if (rst) begin
            q_reg <= 0;
        end else begin
            q_reg <= q_next;
        end
    end
    always @(i_btn,r_clk, q_reg) begin
        q_next = {i_btn, q_reg[7:1]};
    end

    // 8 input and gate
    assign w_debounce = &q_reg;

    reg r_edge_q;  // Q5

    // edge detector
    always @(posedge clk, posedge rst) begin
        if (rst) begin
            r_edge_q <= 0;
        end else begin
            r_edge_q <= w_debounce;
        end
    end

    // rising edge 
    assign o_btn = (~r_edge_q) & w_debounce;

endmodule
