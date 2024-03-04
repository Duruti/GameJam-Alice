initMenu
   ; efface l'ecran
   ldaa #80 ; efface l'écran
   jsr $FBD6

   ldaa #1
   staa stateMusic

   ; affiche le texte
   ldx #textMenu
   ldd #$1010
   jsr drawText

   rts

updateMenu
    jsr getKey
    jsr updateKeyMenu   
    ldaa newKey
    staa oldKey
   rts 

exitMenu
   ; coupe la musique
   ldaa #0
   staa stateMusic

   ldab #sceneGame
   jsr changeScene
   rts

updateKeyMenu

   ;Fire : Espace
   ldaa oldKey 
   anda #%1
   bne actionFireMenu
   rts

actionFireMenu
   ldaa newKey 
   anda #%1
   bne endActionMenu
   jsr exitMenu

endActionMenu
   rts



textMenu byte "SCENE MENU",0
