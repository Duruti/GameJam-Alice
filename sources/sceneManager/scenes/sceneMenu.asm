colorEyes equ %00000111

initMenu
   clra 
   staa indexMusic

   ; efface l'ecran
   ldab #0 ; efface l'écran
   jsr $FBD6

   ldaa #1
   staa stateMusic


   ldaa #$6
   staa colorText
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

   ldaa #21-1
   staa nbByte
   ldd #$3100 ; a=R4 et b = R5
   std memoryTampon
   ldx #eyesLeft+2
   jsr loadDataSpriteGeneric

   ldaa #21-1
   staa nbByte
   ldd #$3700 ; a=R4 et b = R5
   std memoryTampon
   ldx #eyesRight+2
   jsr loadDataSpriteGeneric



   ; affiche le texte
   ldx #textMenu
   ldd #$0E10
   jsr drawText



   ; eyesLeft


   ldaa #colorEyes
   staa colorR3Sprite

   ldaa #11
   staa tamponX 
   ldaa #10
   staa tamponY 
   ldaa #7
   staa colums
   ldaa #3
   staa lines 
   clra
   staa compteurLine
   ldd #$4481
   jsr drawSpriteGeneric

   ; eyesRight
   ldaa #colorEyes
   staa colorR3Sprite

   ldaa #21
   staa tamponX 
   ldaa #10
   staa tamponY 
   ldaa #7
   staa colums
   ldaa #3
   staa lines 
   clra
   staa compteurLine
   ldd #$5C81
   jsr drawSpriteGeneric


   ; Larcin
   ldaa #%00000011
   staa colorR3Sprite

   ldaa #17
   staa tamponX 
   ldaa #22
   staa tamponY 
   ldaa #6
   staa colums
   ldaa #5
   staa lines 
   clra
   staa compteurLine
   ldd #$2481
   jsr drawSpriteGeneric

   ; text Larcin
   ldx #textMenuLarcin
   ldd #$071C
   jsr drawText

   ldx #textMenuLienLarcin
   ldd #$061D
   jsr drawText

   ; reactive l'interruption OCF
   ldaa $08
   oraa #%00001101 
   staa $08

   rts

updateMenu
   jsr getKeyMenu
    jsr updateKeyMenu   
    ldaa newKey
    staa oldKey
   rts 
getKeyMenu 
   ldaa tempoGhost
   anda #1 
   bne endGetKeyMenu

   clra 
   staa newKey
   
   ;testEspace
   ; pour Espace = Fire
   sei
   ldaa #$7F ; précise quelle colonne on veut, ici la 1 en mettant a 0 le bit 1
   staa PORT1
   ldaa IO ; on récupere les infos dans IO
   cli  ; ldaa IO ; on récupere les infos dans IO
   anda #%00001000 ; on test le bit 3 , si il vaut 0 alors 
   bne endTestMenu
   ; mets le bit 3 de newKey a 1  
   ldaa #%1
   oraa newKey
   staa newKey

   ; inverse newKey pour faciliter les tests ensuite
endTestMenu 
   
   neg newKey
   dec newKey 
endGetKeyMenu
   rts

exitMenu
   ; coupe la musique
   ldaa #0
   staa stateMusic

   sei 
   ldaa $08
   anda #%11110111 ; stop l'interruption OCF 
   staa $08
   ldab #sceneGame
   jsr changeScene
   cli 
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



textMenu byte "IN THE DARK",0
textMenuLarcin byte     "DEMAKE DU JEU LARCIN LAZER",0
textMenuLienLarcin byte "https://tambouillestudio.com/",0
