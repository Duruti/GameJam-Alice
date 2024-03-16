initGameOver
   ; efface l'ecran
  ; jsr $fbd4
   ; affiche le texte
   ldaa #%00010000
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

   ldx #textGameOver
   ldd #$1012
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