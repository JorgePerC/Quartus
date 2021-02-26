module StepMaker2 (
    input clk,
    input S,
    input Z,
    output P,
    output T
);

// Finate States
parameter ResetTimer = 2'b00;
parameter Wait = 2'b01;
parameter Pace= 2'b10;

//State Control
reg [1:0] State, Nxt_State; 

// FSM COMBINATIONAL LOGIC
always @(*) begin
    case (State)
        ResetTimer:  Nxt_State = Wait;
        
        Pace:  Nxt_State = ResetTimer;
                                //No ponemos la S, pq #CondicionPasada
        Wait:  Nxt_State = (S)? ResetTimer: (Z) ? Pace;
    endcase
end

// State register 
always @(posedge clk ) begin
    // S nos dice si se reinicia
    if (S) State <= ResetTimer;
    else   State <= Nxt_St;
    ate;
end

//Outputs 
assign P = state[1];
assign T = ~state[1] & ~state[0];

endmodule 

