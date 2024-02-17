
initLevel 
   jsr calcAdrCurrentLevel
   jsr loadCurrentMapSprite
   jsr getTrap
   jsr getGhost
   jsr getKeyAndPadlock

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

   ldd #$0Ec0 ; a=R4 et b = R5
   std memoryTampon
   ;std startLoop+1
   ldx #piege+2
   jsr loadDataSprite

   ldd #$0Fc0 ; a=R4 et b = R5
   std memoryTampon
   ;std startLoop+1
   ldx #decor1+2
   jsr loadDataSprite

   ldd #$10c0 ; a=R4 et b = R5
   std memoryTampon
   ldx #decor2+2
   jsr loadDataSprite

   ldd #$11c0 ; a=R4 et b = R5
   std memoryTampon
   ldx #bonus+2
   jsr loadDataSprite

   ldd #$12c0 ; a=R4 et b = R5
   std memoryTampon
   ldx #torche+2
   jsr loadDataSprite

   ldd #$13c0 ; a=R4 et b = R5
   std memoryTampon
   ldx #ghostleft+2
   jsr loadDataSprite

   ldd #$14c0 ; a=R4 et b = R5
   std memoryTampon
   ldx #ghostright+2
   jsr loadDataSprite

   ldd #$15c0 ; a=R4 et b = R5
   std memoryTampon
   ldx #ghostup+2
   jsr loadDataSprite

   ldd #$16c0 ; a=R4 et b = R5
   std memoryTampon
   ldx #ghostdown+2
   jsr loadDataSprite

   ldd #$17c0 ; a=R4 et b = R5
   std memoryTampon
   ldx #key+2
   jsr loadDataSprite

   ldd #$18c0 ; a=R4 et b = R5
   std memoryTampon
   ldx #padlock+2
   jsr loadDataSprite

   ldd #$19c0 ; a=R4 et b = R5
   std memoryTampon
   ldx #moveup+2
   jsr loadDataSprite

   ldd #$1Ac0 ; a=R4 et b = R5
   std memoryTampon
   ldx #moveright+2
   jsr loadDataSprite

   ldd #$1Bc0 ; a=R4 et b = R5
   std memoryTampon
   ldx #movedown+2
   jsr loadDataSprite

   ldd #$1Cc0 ; a=R4 et b = R5
   std memoryTampon
   ldx #moveleft+2
   jsr loadDataSprite


   ldd #$00c0 ; a=R4 et b = R5
   std memoryTampon
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
   ; a partir de b on calcul la colonne et la ligne dans le tableau
   tba 
   pshb
  ; inca ; on commence a l'index 1 pour faire la div/12
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
; recherche les pièges

getTrap

   ; parcours la map à la recherche de pièges 
   clra 
   staa indexPiege
   ldx #lstPiege
   stx adrTampon
   ldx #currentMapSprite
   clrb
loopGetTrap
   ldaa 0,x
   cmpa #idPiege
   beq addPiege
suiteLGT
   inx 
   incb
   cmpb #width*height
   bne loopGetTrap
   rts

addPiege
   pshx
   jsr calcPositionTrap
  
   ldx adrTampon
   ldaa tamponX
   staa 0,x 
   inx 
   ldaa tamponY
   staa 0,x 
   inx
   stx adrTampon

   inc indexPiege
   pulx
   jmp suiteLGT

calcPositionTrap
   pshb
   tba 
   pshb
   ;inca ; on commence a l'index 1 pour faire la div/12
   ldab #12
   jsr div 
   ldaa result 
   staa tamponY

   ldab #12
   mul 
   pula
   sba
   staa tamponX
   ; affiche sprite
   ldab tamponY
   jsr getPosition
   
   pulb
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

; Charge la map du jeu



loadCurrentMapSprite
   ;transfert les données du Level dans currentMapSprite
   ldd #width*height-1
   addd adrCurrentLevelSprite
   std memoryTampon 
   ldx memoryTampon

   sts saveSP ; sauve la pile 
   lds #currentMapSprite+(width*height)-1

   clrb
loopLoadCurrentMapSprite
   ldaa 0,x 
   dex 
   ;cmpa #1 ; test si perso
   ;bne suiteLoopLCMS
  ; clra 
suiteLoopLCMS
   psha
   incb 
   cmpb #width*height
   bne loopLoadCurrentMapSprite
   
   lds saveSP
   rts 

drawMapSprite
   clrb 
   ldx #currentMapSprite;adrCurrentLevelSprite
loopDrawMapSprite 
   ldaa 0,x 
   inx 
   cmpa #0
   bne drawSpriteMap

suiteLDMS
   incb
   cmpb #$48
   bne loopDrawMapSprite   
   rts

drawSpriteMap
   pshb
   psha
   
   tba 
   pshb
   ;inca ; on commence a l'index 1 pour faire la div/12
   ldab #12
   jsr div 
   ldaa result 
   staa tamponY

   ldab #12
   mul 
   pula
   sba
   staa tamponX
   ; affiche sprite
   ldab tamponY
   jsr getPosition


   pula
   ; recupere la couleur
   pshx
   tab 
   ldx #colorSprite
   abx
   ldab 0,x
   stab colorR3
   pulx


   deca 
   ; * 4 
   lsla
   lsla
   adda #$30

   ldab #$81 ; a=R1 b=R2
   jsr drawSprite3230
   
   
   pulb 
   jmp suiteLDMS
   


dataSprite 

spriteSheet incbin "sprites/spriteSheet.bin"
sprite incbin "sprites/perso.bin"
door incbin "sprites/door.bin"
piege incbin "sprites/piege.bin"
decor1 incbin "sprites/decor1.bin"
decor2 incbin "sprites/decor2.bin"
bonus incbin "sprites/bonus.bin"
torche incbin "sprites/torche.bin"
ghostleft incbin "sprites/ghostleft.bin"
ghostright incbin "sprites/ghostright.bin"
ghostup incbin "sprites/ghostup.bin"
ghostdown incbin "sprites/ghostdown.bin"
key incbin "sprites/key.bin"
padlock incbin "sprites/cadenas.bin"
moveup incbin "sprites/moveup.bin"
moveright incbin "sprites/moveright.bin"
movedown incbin "sprites/movedown.bin"
moveleft incbin "sprites/moveleft.bin"


cells incbin "levels/tiles.bin"
endDataSprite

; 20 Levels
map incbin "levels/level.bin"
memoryMap ds 148,0

idVide   equ 0
idPerso  equ 1
idDoor   equ 2
idPiege  equ 3
idDecor1 equ 4
idDecor2 equ 5
idBonus  equ 6
idTorche equ 7
idGhostleft equ 8
idGhostright equ 9
idGhostup equ 10
idGhostdown equ 11
idKey    equ 12
idPadlock equ 13
idMoveUp equ 14
idMoveRight equ 15
idMoveDown equ 16
idMoveLeft equ 17

colorSprite byte 0,2,%00000110,1,2,%00000111,5,3,1,1,1,1,3,5,7,7,7,7

