initMenu
   ; efface l'ecran
   ldaa #80 ; efface l'écran
   jsr $FBD6

   ldaa #1
   staa stateMusic


   ; Charge le sprite LarcinLazer

   ; Place la redefinition des caracterere en bank 4
   ldaa #%10000100 ; DOR 
   staa R0 
   ldaa #$14 
   staa R1+EXEC 
   jsr BUSY

   clra 
   staa index
   ldaa #30-1
   staa nbByte
   ldd #$2900 ; a=R4 et b = R5
   std memoryTampon
   ldx #larcinLazer+2
   jsr loadDataSpriteGeneric



   ; Larcin
   ldaa #%00000011
   staa colorR3Sprite

   ldaa #10
   staa tamponX 
   ldaa #19
   staa tamponY 
   ldaa #6
   staa colums
   ldaa #5
   staa lines 
   clra
   staa compteurLine
   ldd #$2481
   jsr drawSpriteGeneric

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
