initGameOver
   ; efface l'ecran
   jsr $fbd4
   ; affiche le texte
   ldx #textGameOver
   ldd #$1010
   jsr drawText
   rts 
updateGameOver
   jsr INPUTKEY
   cmpa #$20
   beq exitGameOver
   rts 
  
exitGameOver
   ldab #sceneMenu
   jsr changeScene
   rts

textGameOver byte "SCENE GAMEOVER",0