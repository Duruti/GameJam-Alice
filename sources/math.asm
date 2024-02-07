div
   ; division
   ; a/b -> result
   psha 
   clra 
   staa result
   pula
loopDiv
   sba 
   blo fin 
   inc result
   jmp loopDiv
fin
   rts 


   ldaa #$FF

; result byte 0