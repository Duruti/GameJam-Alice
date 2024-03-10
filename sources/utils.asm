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
drawTextloop
   ldaa 0,x
   beq endloop
   staa R1
   ldaa #%0000000
   staa R2
   ldaa colorText			;	attribut du caractère
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
   cmpa #1
   bne tempo 
   clra 
   staa tempoText

   jmp drawTextloop
endloop
   rts
;tempoText ds 0

drawTextTempo
   rts




vbl

vbl0 ; attend que Vsync soit a 0
   ldaa R0
   anda #%00000100
 	bne vbl0
vbl1 ; attend que Vsync soit a 1
   ldaa R0
   anda #%00000100
 	beq vbl1
   
   rts 




;    ldaa #%10010101
;    staa R0+EXEC     

; vbl2   
;    ldaa R0;+EXEC
;    bita #%00000100
;  	;anda #%00000100
;    bne vbl2

   
;    ldaa #20
; vblloop
;    deca 
;    ;cmpa #0
;    bne vblloop
;    rts

CopyData

