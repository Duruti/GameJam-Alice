initGame


   ; Place la redefinition des caracterere en bank 3
   ldaa #%10000100 ; DOR 
   staa R0 
   ldaa #$13 
   staa R1+EXEC 
   jsr BUSY

   ; efface l'écran
   jsr $fbd4
   ldaa #-3
   staa colonneMap
   ldaa #8
   staa ligneMap
   clra 
   staa Xpos
   staa Ypos
   ldaa #1 
   staa isStart
   
   ; affiche le texte
   ; ldx #textGame
   ; ldd #$1010
   ; jsr drawText
   
   jsr initLevel



   ldaa #80 ; efface l'écran
   jsr $FBD6

   
  jsr drawMap
   
  
   jsr schearchPerso
   jsr drawMapSprite
   ldaa Xpos
   staa oldPosX 
   ldaa Ypos
   staa oldPosY

   ldx #textBonus
   ldd #$111D
   jsr drawText

   ldx #textLevel
   ldd #$021D
   jsr drawText

   clra 
   staa tempoGhost
   jsr drawGhosts
   
   jsr drawScoreBonus
   jsr drawCurrentLevel

   ldaa $74
   staa idSpritePerso
   rts 
updateGame

   ; jsr vbl
   jsr AnimSprite
   ldaa statusAutomaticMove
   bne jmpMovePlayerAutomatic
   jsr getKey
   jsr updateKey   
  
   ldaa isStart
   bne controlKey

escapeKey
suiteUpdateGame   
   
   jsr isAutomaticMove
   jsr isBonus
   jsr isTorche
   jsr isKey
   jsr updateGhost
endUpdateGame
   ldaa newKey
   staa oldKey
 
   jsr isGameover
   jsr isWin 


   rts 
jmpMovePlayerAutomatic
   jmp MovePlayerAutomatic
controlKey
   ldaa newKey
   cmpa oldKey ;#%11111111 
   beq suiteUpdateGame
   ldaa newKey
   cmpa #%11111111
   beq suiteUpdateGame
   clra 
   staa isStart
   jsr shadowTrap

   jmp suiteUpdateGame
drawTrap
   ldaa indexPiege
   beq endDrawTrap
   clrb 
   ldx #lstPiege

loopDT 
   ldaa 0,x 
   staa tamponX
   ldaa 1,x 
   staa tamponY
   inx 
   inx 

   ldaa #1 ;colorPiege+idPiege
   staa colorR3
   
   pshb
   ldaa #idPiege
   deca 
   ; * 4 
   lsla
   lsla
   adda #$30 
   ldab #$81
   jsr drawSprite3230 
   pulb
   incb
   cmpb indexPiege
   bne loopDT
endDrawTrap
   rts 

shadowTrap
   ; efface les pieges
   clrb 
   ldx #lstPiege

loopST 
   ldaa 0,x 
   staa tamponX
   ldaa 1,x 
   staa tamponY
   inx 
   inx 

   clra
   staa colorR3
   pshb
   ldab #$81
   jsr drawSprite3230 
   pulb
   incb
   cmpb indexPiege
   bne loopST
   rts


getPosition
   ; calcul la position a l'ecran par caractere
   ; a = position case en X
   ; b = position case en Y 
   ; stocke les valeurs dans tamponX et Y 
   
   ; calcul en X 
   pshb
   ldab #3 
   mul ; a*3 -> d 
   addb #2
   stab tamponX
   ; calcul Y
   pula
   ldab #3 
   mul ; a*3 -> d 
   addb #9
   stab tamponY
   rts


isUp 
   ; control que c'est possible de monter 
   ldaa Ypos
   beq exitIsUp ; si c'est a 0 alors pas possible
   ;jmp SuiteActionZ
   deca
   ; control s'il y a un cadenas
   ldab indexKey
   beq nextIsUp ; si pas d'index alors on poursuit le test
   jsr isPadlockY ; sinon on regarde
   cmpa #1
   beq exitIsUp

nextIsUp
   ldaa Ypos
   deca ; sinon descend d'une ligne 
   ldab #width
   mul
   tba 
   adda Xpos
   ldx adrCurrentLevel ;map+hearderLevel
   tab 
   abx 
   ldaa 0,x
   beq exitIsUp
   jmp SuiteActionZ
exitIsUp
   jmp Q
isDown 
   ; control que c'est possible de descendre 
   ldaa Ypos
   cmpa #height-1
   beq exitIsDown ; si c'est a 0 alors pas possible
   ;jmp SuiteActionZ

   inca
   ; control s'il y a un cadenas
   ldab indexKey
   beq nextIsDown ; si pas d'index alors on poursuit le test
   jsr isPadlockY ; sinon on regarde
   cmpa #1
   beq exitIsDown

nextIsDown
   ldaa Ypos
   inca ; sinon descend d'une ligne 
   ldab #width
   mul
   tba 
   adda Xpos
   ldx adrCurrentLevel; map+hearderLevel
   tab 
   abx 
   ldaa 0,x
   beq exitIsDown
   jmp SuiteActionS
exitIsDown
   jmp D
isLeft
   ; control que c'est possible de monter 
   ldaa Xpos
   beq exitIsLeft ; si c'est a 0 alors pas possible
   
   deca
   ldab indexKey
   beq nextIsLeft ; si pas d'index alors on poursuit le test
   jsr isPadlockX ; sinon on regarde
   cmpa #1
   beq exitIsLeft

nextIsLeft

   ldaa Xpos
   deca ; sinon descend d'une ligne 
   psha
   ldaa Ypos
   ldab #width
   mul
   ; dans b le resultat 
   ;tba 
   pula
   aba ; additionne a+b -> a 
   ldx adrCurrentLevel ;map+hearderLevel
   tab 
   abx 
   ldaa 0,x
   beq exitIsLeft
   jmp SuiteActionQ
exitIsLeft
   jmp S
isRight
      ; control que c'est possible de monter 
   ldaa Xpos
   cmpa #width-1
   beq exitIsRight ; si c'est a 0 alors pas possible
   

   inca
   ldab indexKey
   beq nextIsRight ; si pas d'index alors on poursuit le test
   jsr isPadlockX ; sinon on regarde
   cmpa #1
   beq exitIsRight

nextIsRight

   ldaa Xpos
   inca ; sinon descend d'une ligne 
   psha
   ldaa Ypos
   ldab #width
   mul
   ; dans b le resultat 
   ;tba 
   pula
   aba ; additionne a+b -> a 
   ldx adrCurrentLevel;map+hearderLevel
   tab 
   abx 
   ldaa 0,x
   beq exitIsRight
   jmp SuiteActionD
exitIsRight
   jmp Fire
getIdSprite
   ; retourne l'Id sous le player dans a 
   ldaa Ypos
   ldab #width
   mul
   tba 
   adda Xpos
   ldx #currentMapSprite; adrCurrentLevelSprite;#map+hearderLevel+(width*height)
   tab 
   abx 
   ldaa 0,x
   rts
isBonus
   jsr getIdSprite 
   cmpa #idBonus
   bne endIsBonus 
   inc scoreBonus
   jsr drawScoreBonus
   jsr eraseSprite
endIsBonus
   rts 
isTorche
   jsr getIdSprite 
   cmpa #idTorche
   bne endIsTorche 
   ldaa #1
   staa isStart
   clra 
   staa indexTorch
   jsr drawTrap
   jsr eraseSprite
endIsTorche
   rts 

isGameover
   jsr getIdSprite 
   cmpa #idPiege
   beq trueGameover
   
   jsr isGhost 
   cmpa #1 
   beq trueGameover 
   
   rts 
trueGameover
   ldab #sceneGameOver
   jsr changeScene
   rts

isWin 
   jsr getIdSprite 
   cmpa #2
   bne endIsWin 
   ldaa currentLevel
   inca 
   cmpa #MaxLevel-1
   ble  nextIsWin
   clra 
nextIsWin
   staa currentLevel
   ldab #sceneNextLevel
   jsr changeScene
endIsWin
   rts 

eraseSprite
   ; efface dans la map le sprite
   ; calcul de l'index = Ypos*12 + Xpos 
   ldaa Ypos 
   ldab #12
   mul  
   addb Xpos
   ; on a dans b l'index
   ldx #currentMapSprite
   abx 
   clra 
   staa 0,x 
   rts


exitGame
   ldab #sceneGameOver
   jsr changeScene
   rts
drawScoreBonus
   ldd #$1617
   std $3280
   ldab scoreBonus
   clra 

   jsr $F419
   rts
drawCurrentLevel
   ldd #$1608
   std $3280
   ldab currentLevel
   incb 
   clra 

   jsr $F419
   rts

; *******  ANIM SPRITE *******
AnimSprite
   ldaa isAnim
   beq endAnimSprite

   ldaa timerAnimation
   anda 7 
   bne endAnimSprite
  
   ldaa indexAnim
   inca
   anda #1
   staa indexAnim

   jsr animTorch
   jsr animAutomaticMove
   jsr animPerso

endAnimSprite   
   clra 
   staa isAnim
   rts 

animPerso
   ldx #tableAnimPerso
   ldab indexAnim
   abx 
   ldaa 0,x
   staa idSpritePerso
   jsr drawPlayer
   rts 

animTorch
   ldaa indexTorch
   beq endAnimTorch

   ldx #tableAnimTorch
   ldab indexAnim
   abx 
   ldaa 0,x
   staa idSpriteTorch
   clrb
loopAnimTorch   
   pshb 
   ; trouver la position
   ldx #lstTorch 
   abx 
   ldaa 0,x 
   staa tamponX
   ldaa 1,x 
   staa tamponY
   ; change la couleur
   ldaa #3 ;colorPiege+idPiege
   staa colorR3
   ; dessiner le sprite
   ldaa idSpriteTorch
   ldab #$81
   jsr drawSprite3230
   pulb 
   incb 
   cmpb indexTorch
   bne loopAnimTorch

endAnimTorch
   rts 

animAutomaticMove
   ldaa indexAutomaticMove
   beq endAnimAutomaticMove

   
   clrb
loopAnimAutomaticMove   
   pshb 
   ; trouver la position
   ldaa #3 
   mul 
   ldx #lstAutomaticMove 
   abx 

 ;  ldaa 1,x 
 ;  staa tamponX
 ;  ldaa 2,x 
 ;  staa tamponY
   jsr getIdAutomaticMove
   
   ; change la couleur


   ldx memoryTampon
   
   ldaa idSpriteAutomaticMove
   adda #11
 ;  ldaa #$19
   ldab #$c0 ; a=R4 et b = R5
   ;std memoryTampon
   std memoryTampon
   jsr loadDataSprite


   pulb 
   incb
   inx
   inx 
   inx  
   cmpb indexAutomaticMove
   bne loopAnimAutomaticMove

endAnimAutomaticMove
   rts 
getIdAutomaticMove 

   ldab 0,x ; recupere l'id 
  ; ldab #idMoveUp
   stab idSpriteAutomaticMove

   subb #idMoveUp ; décalle pour commencer a 0 
   lslb ; multiplie par 4 
   lslb 
 ;   clrb
   addb indexAnim
   addb indexAnim



   ldx #tableAnimMoveUp
   abx 
   ldd 0,x
   std memoryTampon



  ; staa idSpriteAutomaticMove
  ; clrb
   rts 


textGame byte "SCENE GAME",0
textBonus byte "BONUS",0
textLevel byte "LEVEL",0
