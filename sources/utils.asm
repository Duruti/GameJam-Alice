; attend que l'EF9345 est finit le traitement des taches

busy
   tst R0
   bmi busy
   rts

; affiche une ligne de caractere
drawText
   ; x contient l'adresse du texte
   ; a = x , b = y 
   staa R7
   stab R6 
   clra 
   staa tempoText
drawText.loop
   ldaa 0,x
   beq .endloop
   std R1
   ldaa #%0000000
   std R2
   ldaa #$34			;	attribut du caractère
   staa R3	
   
   ldaa #$00			;	commande  KRF affichage en 40 carateres
   staa R0+EXEC
   jsr busy			;	saute à la routine BUSY
   inc R7
   inx
tempo
   jsr vbl
   ldaa tempoText
   inca
   staa tempoText

;    inc tempoText
   cmpa #50
   bne tempo 
   clra 
   staa tempoText

   jmp drawText.loop
.endloop
   rts
tempoText ds 0

drawTextTempo
   rts




vbl
   ldaa R0
   bita #%00000100
 	bne vbl
   
   ldaa #10
vbl.loop
   deca 
   ;cmpa #0
   bne vbl.loop
   rts

