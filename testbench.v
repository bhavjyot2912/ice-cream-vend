module testbench();
reg clk;
reg reset;
reg coin;
wire dispense;
wire [1:0] change;
icecream_dispenser(coin,dispense,change,clk,reset);

initial
begin
    clk = 0;
    reset = 0;
    coin = 0;
    $dumpfile("icecream_vendor.vcd");
    $dumpfile(0,testbench);
end

always #4 clk=~clk
always #10 reset=~reset
always #6 coin=~coin

endmodule