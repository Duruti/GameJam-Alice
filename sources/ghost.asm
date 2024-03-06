
; parcours la map à la recherche de pièges 

getGhost

   clra 
   staa indexGhost
   ldx #lstGhost
   stx adrTampon
   ldx #currentMapSprite
   clrb
loopGetGhost
   ldaa 0,x
   cmpa #idGhostleft
   beq addGhost
   cmpa #idGhostright
   beq addGhost
   cmpa #idGhostup
   beq addGhost
   cmpa #idGhostdown
   beq addGhost
suiteLGG
   inx 
   incb
   cmpb #(width*height)
   bne loopGetGhost
   rts
;l jmp l 
addGhost
   pshx ; save currentMapSprite
   pshb
   
   psha
   jsr getPositionSprite
   
   ldx adrTampon
   pula 
   staa 0,x
   inx   
   ldaa tamponX
   staa 0,x 
   inx 
   ldaa tamponY
   staa 0,x 
   inx
   stx adrTampon

   inc indexGhost
   
   pulb
   pulx
   clra 
   staa 0,x
   jmp suiteLGG

calcPositionGhost
   ; retourne dans tamponX et Y la position à l'ecran
   
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


; Gere la liste des ghosts

updateGhost
   
   ldaa isStart
   bne endUpdateGhost1
   
   ; controle si il y a une liste de ghost
   ldaa indexGhost
   beq endUpdateGhost1
   ; gere la temporisation 
   
   
   ldaa tempoGhost
   anda 15 
   bne endUpdateGhost1
   inc tempoGhost
   jmp moveGhost
  
endUpdateGhost1
   rts 
moveGhost
   ; init tempo

;   clra 
;   staa tempoGhost
   clrb ; compteur liste
   ldx #lstGhost

loopMoveGhost
   pshb
   ldaa 0,x ; recupere la direction
   cmpa #idGhostleft
   beq moveLeft1
   cmpa #idGhostright
   beq moveRight
   cmpa #idGhostup
   beq moveUp
   cmpa #idGhostdown
   beq moveDown

endMoveGhost
   inx
   pulb 
   incb 
   cmpb indexGhost
   beq endUpdateGhost1
   jmp loopMoveGhost
; redirection 
moveLeft1
   jmp moveLeft
dirUp 
   pula 
   ldaa #idGhostup 
   staa 0,x 
moveUp
   psha ; sauve l'index du sprite
   
   ldaa 1,x 
   staa tamponX
   ldaa 2,x 
   deca 
   staa tamponY

   jsr getId
   cmpa #0
   beq dirDown
   
   pshx
   ldaa 1,x 
   ldab 2,x
   jsr restoreBackgroundGhost
   pulx 


   inx 
   ldaa 0,x ; recupere la position x 


   inx 
   ldab 0,x  ;recupere y
   decb 
   stab 0,x 
   jsr getPosition
   jmp drawGhost

dirDown 
   pula 
   ldaa #idGhostdown 
   staa 0,x 
moveDown
   psha ; sauve l'index du sprite
   
   ldaa 1,x 
   staa tamponX
   ldaa 2,x 
   inca 
   staa tamponY

   jsr getId
   cmpa #0
   beq dirUp
   
   pshx
   ldaa 1,x 
   ldab 2,x
   jsr restoreBackgroundGhost
   pulx 


   inx 
   ldaa 0,x ; recupere la position x 

   inx 
   ldab 0,x  ;recupere y
   incb 
   stab 0,x 
   jsr getPosition
   jmp drawGhost




dirRight 
   pula 
   ldaa #idGhostright 
   staa 0,x 
moveRight
   psha ; sauve l'index du sprite
   
   ldaa 1,x 
   inca 
   staa tamponX
   ldaa 2,x 
   staa tamponY

   jsr getId
   cmpa #0
   beq dirLeft
   
   pshx
   ldaa 1,x 
   ldab 2,x
   jsr restoreBackgroundGhost
   pulx 


   inx 
   ldaa 0,x ; recupere la position x 

   inca 

   staa 0,x 
   inx 
   ldab 0,x  ;recupere y
   jsr getPosition
   jmp drawGhost


dirLeft 
   pula 
   ldaa #idGhostleft 
   staa 0,x 

moveLeft
   psha ; sauve l'index du sprite

   ldaa 1,x 
   deca 
   staa tamponX
   ldaa 2,x 
   staa tamponY

   jsr getId
   cmpa #0
   beq dirRight

   pshx
   ldaa 1,x 
   ldab 2,x
   jsr restoreBackgroundGhost
   pulx 

   inx 
   ldaa 0,x ; recupere la position x 

   deca 
   staa 0,x 
   inx 
   ldab 0,x  ;recupere y
   jsr getPosition
   jmp drawGhost


drawGhost
   ldaa #1 
   staa colorR3
   pula
   deca

   lsla
   lsla
   adda #$30

 ;  ldd #$0081 ; a=R1 b=R2
   ldab #$81
   jsr drawSprite3230
   jmp endMoveGhost


endUpdateGhost
   rts

getPositionSprite 
   ; a partir de b on calcul la colonne et la ligne dans le tableau
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
   
   rts 

getId
   ; retourne l'Id sous à tamponX et Y  dans a 
   ; TODO Faire un check hors map 
   pshx
   ; test en x
   ldaa tamponX
   cmpa #0
   blt SetZeroId
   cmpa #width-1
   bgt SetZeroId

   ; test en y
   ldaa tamponY
   cmpa #0
   blt SetZeroId
   cmpa #height-1
   bgt SetZeroId

   ldaa tamponY
   ldab #width
   mul
   tba 
   adda tamponX
   ldx adrCurrentLevel;#map+hearderLevel+(width*height)
   tab 
   abx 
   ldaa 0,x
endGetId
   pulx
   rts
SetZeroId 
   clra 
   pulx
   rts
getIdSpriteGhost
   ; retourne l'Id sous le sprite dans a 
   ldaa 2,x
   ldab #width
   mul
   tba 
   adda 1,x
   ldx #currentMapSprite; adrCurrentLevelSprite;#map+hearderLevel+(width*height)
   tab 
   abx 
   ldaa 0,x
   rts

restoreBackgroundGhost
   ; efface l'ancienne position
 ;  ldaa Xpos
 ;  ldab Ypos
   jsr getPosition

   jsr getIdSpriteGhost
   cmpa #1
   ble drawVideGhost
   psha
      ; recupere la couleur
   pshx
   tab 
   ldx #colorSprite
   abx
   ldab 0,x
   stab colorR3
   pulx

   
   pula   
   deca


   lsla
   lsla
   adda #$30

 ;  ldd #$0081 ; a=R1 b=R2
   ldab #$81
   jsr drawSprite3230
   rts
drawVideGhost
   ldaa #%0000 
   staa colorR3
   ldd #$0081 ; a=R1 b=R2
   jsr drawSprite3230
   rts
drawGhosts
   ; affiche la liste des ghosts 
   ldaa indexGhost
   beq endDrawGhosts
   clrb ; compteur liste
   ldx #lstGhost
loopDrawGhosts
   pshb   

   ldaa 1,x 
   ldab 2,x
   jsr getPosition

   ldaa #1 
   staa colorR3
   ldaa #8; 0,x 
   deca

   lsla
   lsla
   adda #$30

 ;  ldd #$0081 ; a=R1 b=R2
   ldab #$81
   jsr drawSprite3230

   pulb
   inx 
   inx 
   inx 
   incb 
   cmpb indexGhost
   bne loopDrawGhosts
endDrawGhosts
   rts 

isGhost
   ; regarde si on collisionne avec les ghosts 
   ldaa indexGhost
   beq endIsGhost
   clrb ; compteur liste
   ldx #lstGhost
loopIsGhost
   ldaa 1,x ; X 
   cmpa Xpos
   bne nextGhost
   ldaa 2,x 
   cmpa Ypos
   beq collideGhost
nextGhost   
   inx 
   inx 
   inx 
   incb 
   cmpb indexGhost
   bne loopIsGhost
endIsGhost   
   clra 
   rts
collideGhost
   ldaa #1
   rts 