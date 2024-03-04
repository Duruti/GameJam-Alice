
initLevel 
   jsr calcAdrCurrentLevel
   jsr loadCurrentMapSprite
   jsr getTrap
   jsr getGhost
   jsr getTorch
   jsr getAutomaticMove
   jsr getKeyAndPadlock

   ; Charge les graphismes dans l'EF9345

   ; choisi le bloc 3

   ; ldaa #%10000011 ; PAT
   ; staa R0 
   ; ldaa #$67
   ; staa R1+EXEC 
   ; jsr BUSY

   ; ldaa #%10000100 ; DOR 
   ; staa R0 
   ; ldaa #$13 
   ; staa R1+EXEC 
   ; jsr BUSY

   ldd #$09c0 ; a=R4 et b = R5
   ;std startLoop+1
   std memoryTampon
   ldx #spriteSheet+2
   jsr loadDataSprite
   
   ldd #$0Ac0 ; a=R4 et b = R5
   std memoryTampon
   ldx #spriteSheet+2+40 
   jsr loadDataSprite
   
   ldd #$0Bc0 ; a=R4 et b = R5
   std memoryTampon
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

   ldd #$1Dc0 ; a=R4 et b = R5
   std memoryTampon
   ;std startLoop+1
   ldx #sprite2+2
   jsr loadDataSprite

   ldd #$1Ec0 ; a=R4 et b = R5
   std memoryTampon
   ;std startLoop+1
   ldx #torche2+2
   jsr loadDataSprite

   ldd #$1Fc0 ; a=R4 et b = R5
   std memoryTampon
   ;std startLoop+1
   ldx #moveup2+2
   jsr loadDataSprite

   ldd #$00c0 ; a=R4 et b = R5
   std memoryTampon
   ldx #vide
   jsr loadDataSprite

   ; ecrit dans la bank 

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
; **** RECHERCHE TAPIS ROULANT ****
getAutomaticMove
   ; parcours la map à la recherche de pièges 
   clra 
   staa indexAutomaticMove
   ldx #lstAutomaticMove
   stx adrTampon
   ldx #currentMapSprite
   clrb
loopGetAutomaticMove
   ldaa 0,x

   cmpa #idMoveDown
   beq addAutomaticMove
   cmpa #idMoveLeft
   beq addAutomaticMove
   cmpa #idMoveRight
   beq addAutomaticMove
   cmpa #idMoveUp
   beq addAutomaticMove


suiteGetAutomaticMove
   inx 
   incb
   cmpb #width*height
   bne loopGetAutomaticMove
   rts

addAutomaticMove
   pshx
   staa idSpriteAutomaticMove ; sauve le type 

   jsr calcPositionTrap
  
   ; 3 octet
   ; 1 = id 
   ; 2 = X 
   ; 3 = Y 

   ldx adrTampon
   ldaa idSpriteAutomaticMove
   staa 0,x 
   inx 
   ldaa tamponX
   staa 0,x 
   inx 
   ldaa tamponY
   staa 0,x 
   inx
   stx adrTampon

   inc indexAutomaticMove
   pulx
   jmp suiteGetAutomaticMove


; **** RECHERCHE TORCHE ****
getTorch

   ; parcours la map à la recherche de pièges 
   clra 
   staa indexTorch
   ldx #lstTorch
   stx adrTampon
   ldx #currentMapSprite
   clrb
loopGetTorch
   ldaa 0,x
   cmpa #idTorche
   beq addTorch
suiteLGTorch
   inx 
   incb
   cmpb #width*height
   bne loopGetTorch
   rts

addTorch
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

   inc indexTorch
   pulx
   jmp suiteLGTorch

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


