module test;

//Input Declaration
reg bit_in;
reg reset;
reg clk;

//Output Declaration
wire s;
wire r;
wire q;
wire outf;
wire out;
wire v;
wire en;
wire [5:0] count_in;
wire [5:0] inc;

//Instantiate the Unit Under Test (UUT)
decoder uut (
    .bit_in(bit_in),
    .reset(reset),
    .clk(clk),
    .s(s),
    .r(r),
    .q(q),
    .outf(outf),
    .out(out),
    .v(v),
    .en(en),
    .count_in(count_in),
    .inc(inc)
);

initial begin
    $dumpfile("waveform.vcd");
    $dumpvars(0, test);
    // Initialize Inputs
    reset = 1'b0;
    clk = 1'b0;
    #2 reset = 1'b1;
    #2 reset = 1'b0;
    #4 if (en == 1) bit_in = 1'b1;
    #4 if (en == 1) bit_in = 1'b1;
    #4 if (en == 1) bit_in = 1'b1;
    #4 if (en == 1) bit_in = 1'b0;
    #4 wait(en == 1); // Changed from wait(en==1);
    #4 if (en == 1) bit_in = 1'b1;
    #4 if (en == 1) bit_in = 1'b1;
    #4 if (en == 1) bit_in = 1'b0;
    #44 $finish;
end

always #2 clk = ~clk;

endmodule
