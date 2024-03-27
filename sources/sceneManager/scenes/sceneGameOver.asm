initGameOver
   ; efface l'ecran
  ; jsr $fbd4
   ; affiche le texte

   ldaa $08
   anda #%11110111 ; stop l'interruption OCF 
   staa $08

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
   ldd #$0E12
   jsr drawText
   rts 
updateGameOver
   ; ldaa #15
   ; staa R6
   ; ldaa #10
   ; staa R7
   ; ldaa $09
   ; staa R1
   ; ldaa #%00100000
   ; staa R2
   ; ldaa #%00110000
   ; staa R3
   ; ldaa #0
   ; staa R0+EXEC

   ;jsr getKey
   ;jsr updateKeyGameOver   
  ; ldaa newKey
  ; staa oldKey

 ; **** PATCH CLAVIER *****

   jsr INPUTKEY
   cmpa #$20
   beq exitGameOver
   bne testJoyGameOver   


   rts 
testJoyGameOver
   clra 
   staa newKey
   jsr getJoystick
   neg newKey
   dec newKey 

   jsr updateKeyGameOver
   ldaa newKey
   staa oldKey
   
   rts 
  
exitGameOver
   ldaa #%1
   staa newKey
   neg newKey
   dec newKey 
  
   ldaa newKey
   staa oldKey 

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
textGameOver byte "OH! PERDU...",0