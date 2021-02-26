module Counter
# (parameter ticks = 30)
(
    input clk,
    input rst,  // reset
    input en,   // enable
    output reg [7:0] count
);
    wire [7:0] nxt_count;

    assign nxt_count = count - 1;

        always @ (posedge clk) begin
            if(rst)
                count <= ticks -1;
            else if(en)
                count <= nxt_count;
        end

endmodule 
