initVictory
   ; efface l'ecran
  ; jsr $fbd4
   ; affiche le texte
   jsr drawTrap
   ldx #textVictory
   ldd #$1010
   jsr drawText
   rts 
updateVictory

   jsr getKey  
   jsr updateKeyVictory    
   ldaa newKey
   staa oldKey
   rts 
  
exitVictory
   ldab #sceneMenu
   jsr changeScene
   rts
updateKeyVictory

   ;Fire : Espace
   ldaa oldKey 
   anda #%1
   bne actionFireVictory
   rts

actionFireVictory
   ldaa newKey 
   anda #%1
   bne endActionVictory
   jsr exitVictory

endActionVictory
   rts

textVictory byte "THE END",0