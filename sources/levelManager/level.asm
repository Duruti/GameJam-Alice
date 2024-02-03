
initLevel 
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

schearchPerso 
   ldab #$48
   ldx #map+hearderLevel+$48
loopSchearch 
   ldaa 0,x
   cmpa #1
   beq foundPerso 
   decb 
   beq endSchearchPerso
   inx 
   jmp loopSchearch
foundPerso

endSchearchPerso 
   rts
   ; DESSINE LA MAP 
drawMap

   ldx #map-1+hearderLevel 
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





spriteSheet
 .INCBIN	"sprites/spriteSheet.bin"
sprite incbin "sprites/perso.bin"
door incbin "sprites/door.bin"
cells incbin "levels/tiles.bin"
map incbin "levels/level.bin"

