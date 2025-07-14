module universal(
    input clk,reset,
    input [1:0] mode,
    input [3:0] d,
    output reg [3:0] q
);

always @(posedge clk or posedge reset)begin
if (reset) begin q<=4'b0000;end
else begin
    case(mode)
        2'b00 : q<=q;  // Hold
        2'b01 : q<={1'b0,q[3:1]}; // Shift Right
        2'b10 : q<={q[2:0],1'b0}; // Shift Left
        2'b11 : q<=d; // Parallel Load
        default : q<=4'b0000;
    endcase
    end
end
endmodule