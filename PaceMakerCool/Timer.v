module Timer (
    input clk,
    input rst,  // reset
    input en,   // enable
    output reg concludedCycle
);
reg [7:0] count;
wire [7:0] nxt_count;

always @(posedge clk ) begin

    // Si me dan reset, o todos son 1 
    if (rst | &nxt_count) count <= 7'h0
    // Save in fliplop
    nxt_count = en ? count + 1 : count

    count <= nxt_count
end

endmodule;
