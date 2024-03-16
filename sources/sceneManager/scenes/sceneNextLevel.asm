initNextLevel
   ; efface l'ecran
  ; jsr $fbd4
   ; affiche le texte
   jsr drawTrap

   ldaa #%01100000
   staa colorText

   ldaa #16
   staa tamponY 
   ldaa #11
   staa tamponX 
   ldaa #%00110001
   staa logoR2
   ldaa #%00110000
   staa logoR3

   ldx #cadre 
   ldaa 0,x 
   staa nbLineLogo 
   ldaa 1,x 
   staa nbColumsLogo 
   
   jsr drawLogo


   ldx #textNextLevel
   ldd #$1012
   jsr drawText
   rts 
updateNextLevel

   jsr getKey
   jsr updateKeyNextLevel   
   ldaa newKey
   staa oldKey
   rts 
  
exitNextLevel
   ldab #sceneGame
   jsr changeScene
   rts
updateKeyNextLevel

   ;Fire : Espace
   ldaa oldKey 
   anda #%1
   bne actionFireNextLevel
   rts

actionFireNextLevel
   ldaa newKey 
   anda #%1
   bne endActionNextLevel
   jsr exitNextLevel

endActionNextLevel
   rts

textNextLevel byte "YOU WIN",0