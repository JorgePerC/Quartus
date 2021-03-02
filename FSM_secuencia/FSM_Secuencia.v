module FSM_Secuencia (
    input clk,
	 input X,
	 
    output Z
);

parameter Etapa_A = 3'b000;
parameter Etapa_B = 3'b001;
parameter Etapa_C = 3'b010;
parameter Etapa_D = 3'b011;
 

// Variables para el FF, (guardar cosas)
reg [7:0] actState;
reg [7:0] nxtState;

// Logic Gates:
always @(*) begin
    nxtState = 'bx; // Leave with X
    case (actState)
        Etapa_A  : 
            nxtState = (X == 1) ? Etapa_B: Etapa_A;
        Etapa_B  : 
            nxtState = (X == 0) ? Etapa_C: Etapa_A;
        Etapa_C  : 
            nxtState = (X == 1) ? Etapa_D: Etapa_A;
        Etapa_D  : 
            nxtState = (X == 1) ? Etapa_A: Etapa_C;
				
				
        default: 
            nxtState = Etapa_A;
    endcase
end


// Save State
always @(posedge clk) begin // !!! - Ojo con el rst
    // Si no hay reset, entonces el next State se guarda
    actState <= nxtState;
end

//Salida de  ESTADO EN EL CAMBIO DE ETAPA
assign Z = ( actState == Etapa_D & X == 1);

endmodule

