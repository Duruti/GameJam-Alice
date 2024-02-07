initGame
   ; efface l'écran
   jsr $fbd4
   ldaa #-3
   staa colonneMap
   ldaa #8
   staa ligneMap
   clra 
   staa Xpos
   staa Ypos
   
   ; affiche le texte
   ; ldx #textGame
   ; ldd #$1010
   ; jsr drawText
   
   jsr initLevel

   ldaa #80 ; efface l'écran
   jsr $FBD6

   
  jsr drawMap
   
      
   ; ldx adrCurrentLevel; #map+hearderLevel-4
   ; ;-4
   ; dex
   ; dex
   ; dex 
   ; dex 

   ; ldaa 0,x
   ; deca
   ; staa Xpos
   ; ldab 1,x
   ; decb
   ; stab Ypos 
   jsr schearchPerso
   
   ldaa Xpos
   ldab Ypos
   jsr getPosition
   
   ldd #$3081 ; a=R1 b=R2
   jsr drawSprite3230

   ; affiche la porte
   ldx adrCurrentLevel
   ;-2
   dex
   dex
   ;ldx #map+hearderLevel-2
   ldaa 0,x
   deca
   ldab 1,x
   decb
   jsr getPosition

   ldd #$3481 ; a=R1 b=R2
   jsr drawSprite3230
   rts 
updateGame

  ; jsr vbl
   jsr getKey
   jsr updateKey   
   
   ldaa newKey
   staa oldKey

   jsr isWin 

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
   ; control que c'est possible de monter 
   ldaa Ypos
   cmpa #height-1
   beq exitIsDown ; si c'est a 0 alors pas possible
   ;jmp SuiteActionZ
   
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
   
   ;jmp SuiteActionZ
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
   
   ;jmp SuiteActionZ
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
   ldx  adrCurrentLevelSprite;#map+hearderLevel+(width*height)
   tab 
   abx 
   ldaa 0,x
   rts
isWin 
   jsr getIdSprite 
   cmpa #2
   bne endIsWin 
   
   ldaa currentLevel
   inca 
   anda #%11
   staa currentLevel

   ldab #sceneGameOver
   jsr changeScene
endIsWin
   rts 




exitGame
   ldab #sceneGameOver
   jsr changeScene
   rts

textGame byte "SCENE GAME",0
vide 
   byte $FF,$FF,$FF,$FF
   byte $FF,$FF,$FF,$FF
   byte $FF,$FF,$FF,$FF
   byte $FF,$FF,$FF,$FF
   byte $FF,$FF,$FF,$FF
   byte $FF,$FF,$FF,$FF
   byte $FF,$FF,$FF,$FF
   byte $FF,$FF,$FF,$FF
   byte $FF,$FF,$FF,$FF
   byte $FF,$FF,$FF,$FF
   byte $FF,$FF,$FF,$FF
   byte $FF,$FF,$FF,$FF
   byte $FF,$FF,$FF,$FF
   byte $FF,$FF,$FF,$FF
   byte $FF,$FF,$FF,$FF
   byte $FF,$FF,$FF,$FF
