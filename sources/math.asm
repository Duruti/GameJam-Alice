div
   ; division
   ; a/b -> result

   clra 
   staa result
loopDiv
   sba 
   blo fin 
   inc result
   jmp loopDiv
fin
   rts 


   ldaa #$FF

; result byte 0