module FSMPaceMaker (
    input clk,
    input rst,
    
    input SA,
    input ZA,
    input SB,
    input ZB,

    output PA,
    output TA_ld,
    output TA_en,
    output PV,
    output TB_ld,
    output TB_en
);

parameter RstTimerA = 3'b000;
parameter RstTimerB = 3'b001;
parameter WaitA = 3'b010;
parameter WaitB = 3'b011;
parameter PaceA = 3'b100;
parameter PaceB = 3'b111;
// Ojo, no existe la combinación 3'b101; 

// Variables para el FF, (guardar cosas)
reg [7:0] actState;
reg [7:0] nxtState;

// Logic Gates:
always @(*) begin
    nxtState = 'bx; // Leave with X
    case (actState)
        RstTimerA  : 
            nxtState = WaitA;
        RstTimerB  : 
            nxtState = WaitB;
        WaitA  : 
            nxtState =  SA ? RstTimerB : ZA ? PaceA : WaitA ;
        WaitB  : 
            nxtState =  SB ? RstTimerA : ZB ? PaceB : WaitB ;
        PaceA  : 
            nxtState = RstTimerB;
        PaceB  : 
            nxtState = RstTimerA;
        default: 
            nxtState = RstTimerA;
    endcase
end


// Save State
always @(posedge clk or negedge rst ) begin // !!! - Ojo con el rst
    // Si no hay reset, entonces el next State se guarda
    actState <= !rst? RstTimerA : nxtState;
end

// #I_MISS_RETURN (Outputs)

assign PA = (actState == PaceA) ;
assign TA_ld = (actState == RstTimerA) ;
assign TA_en = (actState == WaitA) ;
assign PV = (actState == PaceB);
assign TB_ld = (actState == RstTimerB) ;
assign TB_en = (actState == WaitA) ;



endmodule

