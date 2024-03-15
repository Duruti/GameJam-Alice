initVictory
   ;efface l'ecran
   ldab #$80
   jsr $fbd6

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
   
   ldaa #72-1
   staa nbByte
   ldd #$2900 ; a=R4 et b = R5
   std memoryTampon
   ldx #theEnd+2
   jsr loadDataSpriteGeneric

   ldaa #16-1
   staa nbByte
   ldd #$3B00 ; a=R4 et b = R5
   std memoryTampon
   ldx #bandeauEnd+2
   jsr loadDataSpriteGeneric


   ldaa #%00000011
   staa colorR3Sprite

   ldaa #14
   staa tamponX 
   ldaa #17
   staa tamponY 
   ldaa #12
   staa colums
   ldaa #6
   staa lines 
   clra
   staa compteurLine
   ldd #$2481
   jsr drawSpriteGeneric

   ldaa #%00000011
   staa colorR3Sprite

   ldaa #16
   staa tamponX 
   ldaa #8
   staa tamponY 
   ldaa #8
   staa colums
   ldaa #2
   staa lines 
   clra
   staa compteurLine
   ldd #$6C81
   jsr drawSpriteGeneric

   ldaa #16
   staa tamponX 
   ldaa #30
   staa tamponY 
   ldaa #8
   staa colums
   ldaa #2
   staa lines 
   clra
   staa compteurLine
   ldd #$6C81
   jsr drawSpriteGeneric

   ; affiche le texte
 ;  jsr drawTrap
   ldx #textVictory
   ldd #$1010
;   jsr drawText
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