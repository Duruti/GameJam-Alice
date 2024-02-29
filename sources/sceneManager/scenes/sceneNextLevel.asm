initNextLevel
   ; efface l'ecran
  ; jsr $fbd4
   ; affiche le texte
   jsr drawTrap
   ldx #textNextLevel
   ldd #$1010
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