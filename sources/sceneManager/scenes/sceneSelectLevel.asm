initSelectLevel
   ; efface l'ecran
  ; jsr $fbd4
   ; affiche le texte
   jsr drawTrap
   ldx #textSelectLevel
   ldd #$1010
   jsr drawText
   rts 
updateSelectLevel

   jsr getKey
   jsr updateKeySelectLevel   
   ldaa newKey
   staa oldKey
   rts 
  
exitSelectLevel
   ldab #sceneGame
   jsr changeScene
   rts
updateKeySelectLevel

   ;Fire : Espace
   ldaa oldKey 
   anda #%1
   bne actionFireSelectLevel
   rts

actionFireSelectLevel
   ldaa newKey 
   anda #%1
   bne endActionSelectLevel
   jsr exitSelectLevel

endActionSelectLevel
   rts

textSelectLevel byte "Select Level",0