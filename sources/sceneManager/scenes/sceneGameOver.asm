initGameOver
   ; efface l'ecran
  ; jsr $fbd4
   ; affiche le texte
   ldx #textGameOver
   ldd #$1010
   jsr drawText
   rts 
updateGameOver

   jsr getKey
   jsr updateKeyGameOver   

   ; jsr INPUTKEY
   ; cmpa #$20
   ; beq exitGameOver
   ldaa newKey
   staa oldKey

   rts 
  
exitGameOver
   ldab #sceneGame
   jsr changeScene
   rts
updateKeyGameOver

   ;Fire : Espace
   ldaa oldKey 
   anda #%1
   bne actionFireGameOver

endUpdateKeyGameOver 
   rts
actionFireGameOver
   ldaa newKey 
   anda #%1
   bne endActionKeyGameOver
   jsr exitGameOver

endActionKeyGameOver
   rts
textGameOver byte "GAMEOVER",0