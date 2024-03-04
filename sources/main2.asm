 processor 6803
 org $3346

  BYTE $33, $52, $00, $0a, $9f, $20, $31, $33, $31, $34, $32, $00, $00, $00, $00, $00

 include "sources/constante.asm"

; ***************************
   ; joue une melodie

  ; charge la longueur de la musique

   ldx #music
   ldaa 0,x 
   staa lenghtMusic

    ; charge la premier note 
   ldaa #4
   staa duree
   ldx #music+1 
   ldd 0,x
   std note 

   jsr initInterruption ; initialise les interruptions

   
loop 
   jmp loop 


duree byte $80
compteur byte 0
impuls byte 0
note word do
oldNote word 0
isPlayingSilence byte 0
isOff byte 0
indexMusic byte 0 
lenghtMusic byte 0


 align 256
music
 incbin "sources/music.bin"

 include "sources/interrup.asm"  
