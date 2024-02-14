 ; recherche les clefs et le cadenas
getKeyAndPadlock
   clra 
   staa indexKey

   ldx #lstKey
   stx adrTampon
   ldx #currentMapSprite
   clrb
loopGetKey
   ldaa 0,x
   cmpa #idKey
   beq addKey
   cmpa #idPadlock
   beq addPadlock

SuiteLoopGetKey   
   inx 
   incb
   cmpb #(width*height)
   bne loopGetKey
   rts

addKey
   pshx
   pshb
   jsr getPositionSprite
   ldx adrTampon ; recupere la liste des Key
   ldaa tamponX
   staa 0,x 
   inx 
   ldaa tamponY
   staa 0,x 
   inx 
   stx adrTampon
   inc indexKey

   pulb
   pulx
   jmp SuiteLoopGetKey

addPadlock
   pshx
   pshb

   jsr getPositionSprite
   ldaa tamponX 
   staa XPadlock
   ldaa tamponY 
   staa YPadlock

   pulb
   pulx
   jmp SuiteLoopGetKey
;
; recheche collision avec un padlock

isPadlockX
   ; Ypos dans a 
   cmpa XPadlock
   bne endFalseIsPadlock
   ldaa Ypos 
   cmpa YPadlock
   bne endFalseIsPadlock
   ldaa #1 
   rts 

isPadlockY
   ; Ypos dans a 
   cmpa YPadlock
   bne endFalseIsPadlock
   ldaa Xpos 
   cmpa XPadlock
   bne endFalseIsPadlock
   ldaa #1 
   rts 

endFalseIsPadlock   
   clra ; si pas de cadenas a = 0
   rts 

;
; recherche collision avec une clef 

isKey
   ; on parcours la liste des clefs et on control si y a collision
   jsr getIdSprite 
   cmpa #idKey
   bne endIsKey
   jsr eraseSprite ; efface la clef

   dec indexKey 
   ldaa indexKey
   cmpa #0
   bne endIsKey ;updateLstKey
   jsr erasePadlock 

endIsKey
   rts 
;
; efface le cadenas de l'ecran et de la map

erasePadlock
  ; efface dans la map le sprite
   ; calcul de l'index = Ypos*12 + Xpos 
   ldaa YPadlock 
   ldab #12
   mul  
   addb XPadlock
   ; on a dans b l'index
   ldx #currentMapSprite
   abx 
   clra 
   staa 0,x 

   ; efface le sprite a écran
   ldaa XPadlock
   ldab YPadlock
   jsr getPosition
   ldaa #%000000 
   staa colorR3
   ldd #$0081 ; a=R1 b=R2
   jsr drawSprite3230
   rts