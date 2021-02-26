# Quartus
Repo para la clase de Diseño de chips con Lógica programable. 

ld -> load
en -> enable
lsb -> least significant bit
msb -> most significant bit


# Finate State Machines (FSM)

https://brilliant.org/wiki/finite-state-machines/
https://isaaccomputerscience.org/concepts/dsa_toc_fsm


System where particular inputs produce determined changes on the state of a system. 

Is a sequential logic model that can be implemented in Hardware o Software.

## State transition Table

Useful to model the transitions between states ant eventually represent the system into a logical expression. 

| *Current State | Input | Next State |
| -------------- | ----- | ---------- |
| S0             | ON    | S1         |
| S0             | OFF   | S0         |
| S1             | ON    | S0         |
| S1             | OFF   | S1         |

    FSM To model a push button. Imagine S0 is a turned off LED, and S1 one that's on. Only when the button is pressed, the system will change it's state, otherwise, it will remain. 

## Moore
Sólo se puede 
## Mealy
Produces an output based on:
    * It's current State 
    * A given input
    * Se puede tener una salida drante una transición de estado

## Deterministicas vs No deterministicas



*A language is regular when it its interpretable y a FSM


Recomendations:
    Don't use "" since it's a global statement, instead use parameter

    El cambio lo inicia un Go

*Codificación Grey:*
    Consiste en 


## In Verilog

    Se crean tres bloques para 
