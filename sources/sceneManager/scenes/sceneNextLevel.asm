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
   jsr INPUTKEY
   cmpa #$20
   beq exitNextLevel
   rts 
  
exitNextLevel
   ldab #sceneGame
   jsr changeScene
   rts

textNextLevel byte "YOU WIN",0