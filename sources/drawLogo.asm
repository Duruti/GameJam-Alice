
drawLogo
   inx
   inx 

   ldaa tamponY ; y
   staa R6
   ldaa tamponX ; X 
   staa R7
   
   clrb
   pshb
drawColum 
   ldaa 0,x
   jsr drawCaractereLogo
   incb
   inx
   inc R7 
   cmpb nbColumsLogo
   bne drawColum
   clrb
   inc R6
   ldaa tamponX
   staa R7
   
   pula
   inca
   psha 
   cmpa nbLineLogo
   bne drawColum
   pula
   rts 

drawCaractereLogo
   ;ldaa #64+7
   staa R1
   ldaa logoR2 ; #%00110000
   staa R2
   ldaa logoR3
   staa R3
   ldaa #0
   staa R0+EXEC
   rts 


