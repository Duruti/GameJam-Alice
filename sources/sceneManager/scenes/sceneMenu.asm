initMenu
   ; efface l'ecran
   ldaa #80 ; efface l'écran
   jsr $FBD6

   ;jsr $fbd4
   ; affiche le texte
   ldx #textMenu
   ldd #$1010
   jsr drawText
   rts 
updateMenu
   jsr INPUTKEY
   cmpa #$20
   beq exitMenu
   rts 
exitMenu
   ldab #sceneGame
   jsr changeScene
   rts

textMenu byte "SCENE MENU",0
