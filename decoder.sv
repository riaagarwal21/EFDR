module decoder(
    input bit_in, 
    input reset, 
    input clk,
    output reg s, 
    output reg r, 
    output reg out, 
    output reg v, 
    output reg en, 
    output reg q, 
    output reg outf, 
    output reg [5:0] count_in = 6'b000000, 
    output reg [5:0] inc = 6'b000000
);

reg [3:0] state;
parameter s0 = 4'b0000, s1 = 4'b0001, s2 = 4'b0010, s3 = 4'b0011, s4 = 4'b0100, s5 = 4'b0101, s6 = 4'b0110, s7 = 4'b0111, s8 = 4'b1000, s9 = 4'b1001;

always @(posedge clk) begin
    if (reset)
        state <= s0;
    else begin
        case (state)
            s0: begin
                state <= s1;
                v <= 1'b0;
                en <= 1'b1;
            end
            s1: begin
                if (bit_in) begin
                    state <= s2;
                    s <= 1'b1;
                    r <= 1'b0;
                    v <= 1'b0;
                    en <= 1'b1;
                end else begin
                    state <= s2;
                    s <= 1'b0;
                    r <= 1'b1;
                    v <= 1'b0;
                    en <= 1'b1;
                end
            end
            s2: begin
                if (bit_in) begin
                    state <= s3;
                    s <= 1'b0;
                    r <= 1'b0;
                    v <= 1'b0;
                    en <= 1'b1;
                    count_in[0] <= 1'b1;
                    inc <= 6'd1;
                end else begin
                    s <= 1'b0;
                    r <= 1'b0;
                    state <= s5;
                    out <= 1'b0;
                    v <= 1'b1;
                    en <= 1'b1;
                    count_in[0] <= 1'b0;
                    inc <= 6'd1;
                end
            end
            s3: begin
                count_in <= count_in << 1;
                if (bit_in) begin
                    state <= s3;
                    s <= 1'b0;
                    r <= 1'b0;
                    v <= 1'b0;
                    en <= 1'b1;
                    count_in[0] <= 1'b1;
                    inc <= inc + 6'd1;
                end else begin
                    state <= s4;
                    s <= 1'b0;
                    r <= 1'b0;
                    v <= 1'b0;
                    en <= 1'b0;
                    count_in[0] <= 1'b0;
                    inc <= inc + 6'd1;
                end
            end
            s4: begin
                if (count_in == 0) begin
                    state <= s5;
                    s <= 1'b0;
                    r <= 1'b0;
                    out <= 1'b0;
                    v <= 1'b1;
                    en <= 1'b1;
                    inc <= inc;
                end else begin
                    state <= s4;
                    s <= 1'b0;
                    r <= 1'b0;
                    out <= 1'b0;
                    v <= 1'b1;
                    en <= 1'b0;
                    count_in <= count_in - 6'd1;
                    inc <= inc;
                end
            end
            s5: begin
                if ((bit_in == 1) && (inc != 0)) begin
                    state <= s6;
                    s <= 1'b0;
                    r <= 1'b0;
                    v <= 1'b0;
                    count_in[0] <= 1'b1;
                    en <= 1'b1;
                    inc <= inc - 6'd1;
                end else begin
                    state <= s7;
                    s <= 1'b0;
                    r <= 1'b0;
                    v <= 1'b0;
                    en <= 1'b1;
                    count_in[0] <= 1'b0;
                    inc <= inc - 6'd1;
                end
            end
            s6: begin
                if (inc != 0) begin
                    count_in <= count_in << 1;
                    if ((bit_in == 1) && (inc != 0)) begin
                        state <= s6;
                        s <= 1'b0;
                        r <= 1'b0;
                        v <= 1'b0;
                        count_in[0] <= 1'b1;
                        en <= 1'b1;
                        inc <= inc - 6'd1;
                    end else if ((bit_in == 0) && (inc != 0)) begin
                        state <= s7;
                        s <= 1'b0;
                        r <= 1'b0;
                        v <= 1'b0;
                        en <= 1'b1;
                        count_in[0] <= 1'b0;
                        inc <= inc - 1'b1;
                    end else if (inc == 0) begin
                        state <= s8;
                        s <= 1'b0;
                        r <= 1'b0;
                        v <= 1'b0;
                        en <= 1'b0;
                        inc <= 6'd0;
                    end
                end
            end
            s7: begin
                if (inc != 0) begin
                    count_in <= count_in << 1;
                    if ((bit_in == 0) && (inc != 0)) begin
                        state <= s7;
                        s <= 1'b0;
                        r <= 1'b0;
                        v <= 1'b0;
                        en <= 1'b1;
                        count_in[0] <= 1'b0;
                        inc <= inc - 6'd1;
                    end else if ((bit_in == 1) && (inc != 0)) begin
                        state <= s6;
                        s <= 1'b0;
                        r <= 1'b0;
                        v <= 1'b0;
                        en <= 1'b1;
                        count_in[0] <= 1'b1;
                        inc <= inc - 6'd1;
                    end else begin
                        state <= s8;
                        s <= 1'b0;
                        r <= 1'b0;
                        v <= 1'b0;
                        en <= 1'b0;
                        inc <= 6'd0;
                    end
                end
            end
            s8: begin
                if (count_in != 0) begin
                    state <= s9;
                    s <= 1'b0;
                    r <= 1'b0;
                    out <= 1'b0;
                    v <= 1'b1;
                    en <= 1'b0;
                    inc <= 6'd0;
                end else begin
                    state <= s1;
                    s <= 1'b0;
                    r <= 1'b0;
                    out <= 1'b1;
                    v <= 1'b1;
                    en <= 1'b0;
                    inc <= 6'd0;
                end
            end
            s9: begin
                if (count_in != 0) begin
                    state <= s9;
                    s <= 1'b0;
                    r <= 1'b0;
                    out <= 1'b0;
                    v <= 1'b1;
                    en <= 1'b0;
                    count_in <= count_in - 6'd1;
                end else begin
                    state <= s1;
                    s <= 1'b0;
                    r <= 1'b0;
                    out <= 1'b1;
                    v <= 1'b1;
                    en <= 1'b0;
                    inc <= 6'd0;
                end
            end
        endcase
    end
end

always @(s, r) begin
    if (s == 1 && r == 0)
        q <= 1'b1;
    else if (s == 0 && r == 1)
        q <= 1'b0;
    else if ((s == 0 && r == 0) || (s == 1 && r == 1))
        q <= q;
end

always @(negedge clk) begin
    if (v == 1)
        outf <= q ^ out;
end

endmodule
