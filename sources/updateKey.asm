updateKey
 if DEBUG==1

O
   ldaa oldKey 
   anda #%10000000
   bne actionDownLevel
P
   ldaa oldKey 
   anda #%1000000
   bne actionUpLevel
 endif
Break
   ;Break
   ldaa oldKey 
   anda #%100000
   bne actionBreak

Z  
   ;haut :  Z
   ldaa oldKey 
   anda #%10000
   bne actionZ

Q
   ;gauche : Q
   ldaa oldKey 
   anda #%1000
   bne actionQ1
 
S   ;bas : S 
   ldaa oldKey 
   anda #%100
   bne actionS1
 
D   ;droite : D
   ldaa oldKey 
   anda #%10
   bne actionD1
Fire 
   ;Fire : Espace
   ldaa oldKey 
   anda #%1
   bne actionFire1
endActionKey 
   rts
;**  Redirection
actionD1 jmp actionD
actionS1 jmp actionS
actionQ1 jmp actionQ

;*************** Action *****************
 if DEBUG==1

actionDownLevel
   ldaa newKey 
   anda #%10000000
   bne P
   ; ...
   ldaa currentLevel
   cmpa #0
   beq endActionDownLevel
   deca 
   staa currentLevel
   ldaa newKey
   staa oldKey
   jsr initGame
endActionDownLevel
   jmp endAction
actionUpLevel
   ldaa newKey 
   anda #%1000000
   bne Break
   ; ...
   ldaa currentLevel
   cmpa #MaxLevel
   beq endActionUpLevel
   inca 
   staa currentLevel
   ldaa newKey
   staa oldKey
   jsr initGame
endActionUpLevel
   jmp endAction
 endif 
actionBreak
   ldaa newKey 
   anda #%100000
   bne Z
   ldab #sceneMenu ; retour au menu
   jsr changeScene
   jmp endAction

actionZ 
   ldaa newKey 
   anda #%10000
   bne Q

   jmp isUp

SuiteActionZ

   jsr restoreBackground
   ldaa Ypos
   staa oldPosY

   dec Ypos
   
   jsr drawPlayer
   jmp endAction
actionFire1 jmp actionFire
Fire1 jmp Fire
D1 jmp D 
S1 jmp S
actionQ 
   ldaa newKey 
   anda #%1000
   bne S1
   jmp isLeft
SuiteActionQ 
 
   jsr restoreBackground
   ldaa Xpos
   staa oldPosX
   
   dec Xpos
   jsr drawPlayer
   jmp endAction

actionS 
   ldaa newKey 
   anda #%100
   bne D1 
 
   jmp isDown
SuiteActionS 
 
   jsr restoreBackground
   
   ldaa Ypos
   staa oldPosY
   
   inc Ypos
 
   jsr drawPlayer
   jmp endAction

actionD 
   ldaa newKey 
   anda #%10
   bne Fire1
   jmp isRight
SuiteActionD 

   jsr restoreBackground
   
   ldaa Xpos
   staa oldPosX
   
   inc Xpos


   jsr drawPlayer
   jmp endAction

actionFire 
   ldaa newKey 
   anda #%1
   bne endAction

endAction
   rts
