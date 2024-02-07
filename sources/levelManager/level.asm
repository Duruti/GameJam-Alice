
initLevel 
   jsr calcAdrCurrentLevel
   jsr loadCurrentMapSprite

   ; Charge les graphismes dans l'EF9345

   ldd #$09c0 ; a=R4 et b = R5
   ;std startLoop+1
   std memoryTampon
   ldx #spriteSheet+2
   jsr loadDataSprite
   ldd #$0Ac0 ; a=R4 et b = R5
  ; std startLoop+1
   std memoryTampon
   ldx #spriteSheet+2+40 
   jsr loadDataSprite
   
   ldd #$0Bc0 ; a=R4 et b = R5
   std memoryTampon
   ;std startLoop+1
   ldx #spriteSheet+2+80
   jsr loadDataSprite
   
   ldd #$0Cc0 ; a=R4 et b = R5
   std memoryTampon
   ;std startLoop+1
   ldx #sprite+2
   jsr loadDataSprite

   ldd #$0Dc0 ; a=R4 et b = R5
   std memoryTampon
   ;std startLoop+1
   ldx #door+2
   jsr loadDataSprite

  
   ldd #$00c0 ; a=R4 et b = R5
   std memoryTampon
   ;std startLoop+1
   ldx #vide
   jsr loadDataSprite

   rts
calcAdrCurrentLevel
   ldx #(map+2) 
   ldab #4
   abx
   stx adrCurrentLevel
   

   ldaa #((width*height)*2+4)
   ldab currentLevel
   mul ; dans D on à l'offset du current level
   addd adrCurrentLevel
   std adrCurrentLevel

   ldd #width*height
   addd adrCurrentLevel
   std adrCurrentLevelSprite
   
   rts

schearchPerso 
   ldx adrCurrentLevelSprite
   ldab #0 
loopSchearch 
   ldaa 0,x
   cmpa #1
   beq foundPerso 
   incb
   cmpb #$48
   beq endSchearchPerso
   inx 
   jmp loopSchearch
foundPerso
   tba 
   pshb
   inca ; on commence a l'index 1 pour faire la div/12
   ldab #12
   jsr div 
   ldaa result 
   staa Ypos

   ldab #12
   mul 
   pula
   sba
   staa Xpos
endSchearchPerso 
   rts
   ; DESSINE LA MAP 
drawMap

   ldx  adrCurrentLevel;#map-1+hearderLevel 
   dex
loopColonne   

   ldaa colonneMap
   adda #3 
   staa colonneMap  
   cmpa #(width*3)
   beq UpLine

   inx 
   ldaa 0,x
   ;cmpa 0 
   beq loopColonne
   pshx
   jsr drawCell
   pulx
   bra loopColonne
UpLine
   clra 
   ldaa #-3
   staa colonneMap
   ldaa ligneMap
   adda #3
   staa ligneMap 
   cmpa #(8+height*3)
   
   beq endDrawMap 
   bra loopColonne
endDrawMap
   rts
loadCurrentMapSprite
   ;transfert les données du Level dans currentMapSprite
   
   rts 




spriteSheet incbin "sprites/spriteSheet.bin"
sprite incbin "sprites/perso.bin"
door incbin "sprites/door.bin"
cells incbin "levels/tiles.bin"
map incbin "levels/level.bin"

