/*verilator coverage_off*/
module tbench();

    logic clk, rst;
    logic [15:0] a;
    logic [15:0] b;
    logic [31:0] c;

    dut d1 (clk, rst, a, b, c);

initial begin : ClocknSettings
    $dumpfile("waveform.vcd");
    $dumpvars;
    `TIMEOUT $display("END OF SIMULATION REACHED\n");
    $finish;
end

initial begin : clockGenerator
    clk =0;
    forever `CLOCK_HPERIOD  clk = ~clk;
end


initial begin
    rst = 1;
    `MAX_DELAY rst = 1;
    
    for(int i =0; i<5; i++) begin
        `MAX_DELAY a = $random;
        `MIN_DELAY b = $random;
        $write("%c[0;32m",27);
        $display("@%0t: a=%x b=%x c=%x\n\r", $time, a, b, c);
        $write("%c[0m",27);
    end
  
end


final begin
    $display("_Oh, simulation just finished");
end

endmodule

/*verilator coverage_on*/

