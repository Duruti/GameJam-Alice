initNextLevel
   ; efface l'ecran
  ; jsr $fbd4
   ; affiche le texte
   jsr drawTrap

   sei 

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
   ldd #$1112
   jsr drawText
   
   cli 
   
   rts 
updateNextLevel
   ; ldaa #15
   ; staa R6
   ; ldaa #10
   ; staa R7
   ; ldaa $09
   ; staa R1
   ; ldaa #%00100000
   ; staa R2
   ; ldaa #%01010000
   ; staa R3
   ; ldaa #0
   ; staa R0+EXEC
  
  ; jsr getKey
  ; jsr updateKeyNextLevel   
 ;  ldaa newKey
 ;  staa oldKey

   ;*****  PATCH CLAVIER *****
   
   jsr INPUTKEY
   cmpa #$20
   beq exitNextLevel
   bne testJoyNextLevel

   rts 

testJoyNextLevel
   clra 
   staa newKey
   jsr getJoystick
   neg newKey
   dec newKey 

   jsr updateKeyNextLevel
   
   ldaa newKey
   staa oldKey
   
   rts 


exitNextLevel
   ldaa #%1 ; force la barre espace 
   staa newKey
   neg newKey
   dec newKey 
 
   ldaa newKey
   staa oldKey 

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

textNextLevel byte "BRAVO !",0