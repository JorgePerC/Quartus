module CtrlUnitFSM (
    // Inputs Diagram Leonel 
    input logic [2:0] op_i,
    input logic [2:0] func_i, 
    
    output logic op2_o,
    output logic [3:0] ALUOP_o,
    output logic RegWrt_o,
    output logic [1:0] RegMux_o,
    output logic [3:0] PCoper_o,
    output logic pop_o,
    output logic int_o,
    output logic [1:0] ????,

    output logic weport_o,
    output logic wedata_o

    //Input Diagram book
    input logic inst_ack_i,
    input logic interruption,
    input logic branch,
    input logic jump, 
    input logic misc, 
    input logic wait, 
    input logic stby,         // Standby
    input logic mem,
    input logic stm,          //
    input logic data_ack_i,
    input logic port_ack_i,
    input logic ldm,
    input logic inp,



);


logic act_state;
logic nxt_state;

//States
parameter fetch_state = 3'b000;
parameter decode_state = 3'b001;
parameter int_state = 3'b010;        // Interruption 
parameter execute_state = 3'b011;
parameter mem_state = 3'b100;
parameter write_back_state = 3'b101;

// Seguir diagrama de la página 709

always_comb begin
    case(act_state)
        fetch_state:
            nxt_state = (inst_ack_i) ? decode_state : fetch_state; 
        
        decode_state:
            if (branch & interruption | jump & interruption | misc & interruption):
                nxt_state = int_state;
            else if (misc & (wait | stby) & ~interruption)
                nxt_state = decode_state;
            else if ((branch & ~interruption) | (jump & ~interruption) | (misc & ( wait | stby) & ~interruption))
                nxt_state = fetch_state;
            else
                nxt_state = execute_state;
            end
        
        int_state:

        
        execute_state:
        mem_state:
        write_back_state:
        default:
            nxt_state = 3'bx;
    endcase
    
end





endmodule 

