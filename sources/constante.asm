;déclarations :
R0 .EQU	$BF20
R1 .EQU	$BF21
R2 .EQU	$BF22
R3	.EQU	$BF23
R4	.EQU	$BF24
R5	.EQU	$BF25
R6	.EQU	$BF26
R7	.EQU	$BF27
EXEC .EQU	$08
INPUTKEY .EQU $F883
KEYZ .equ $5a
KEYQ .equ $51
KEYS .equ $53
KEYD .equ $44 
PORT1 equ $02
PORT2 equ $03
IO equ $BFFF
joytick1 equ $BF30
joytick2 equ $BF34
TECRA .EQU $301A
INASS .EQU $D42C 

 macro Break
loopBreak jmp loopBreak
 endm