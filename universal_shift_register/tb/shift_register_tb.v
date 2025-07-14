module universal_tb;

reg clk,reset;
reg [1:0] mode;
reg [3:0] d;
wire [3:0] q;

universal inst(.d(d),.mode(mode),.clk(clk),.reset(reset),.q(q));
always #5 clk=~clk;
initial begin
$monitor("Time=%0t d=%04b  mode=%02b q=%04b",$time,d,mode,q);
clk = 0; reset = 1; mode = 2'b00; d = 4'b0000;
    #10 reset = 0;
    // Parallel Load
    #10 mode = 2'b11; d = 4'b1010;
    
    // Hold
    #10 mode = 2'b00;
    
    // Shift Right
    #10 mode = 2'b01;

    // Shift Left
    #10 mode = 2'b10;

    // Hold again
    #10 mode = 2'b00;
    #10;
$finish;
end
endmodule
