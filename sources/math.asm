div
   ; division
   ; a/b -> result
   psha 
   clra 
   staa result
   pula
loopDiv
   sba 
   blo finLoopDiv 
   inc result
   jmp loopDiv
finLoopDiv
   rts 



; result byte 0