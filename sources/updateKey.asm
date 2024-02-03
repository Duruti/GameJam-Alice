updateKey

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
   bne actionQ
 
S   ;bas : S 
   ldaa oldKey 
   anda #%100
   bne actionS
 
D   ;droite : D
   ldaa oldKey 
   anda #%10
   bne actionD
Fire 
   ;Fire : Espace
   ldaa oldKey 
   anda #%1
   bne actionFire1
 
   rts

;*************** Action *****************
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

   dec Ypos
   
   jsr drawPlayer
   jmp endAction
actionFire1 jmp actionFire

actionQ 
   ldaa newKey 
   anda #%1000
   bne S
   jmp isLeft
SuiteActionQ 
 
   jsr restoreBackground
   
   dec Xpos
   jsr drawPlayer
   jmp endAction

actionS 
   ldaa newKey 
   anda #%100
   bne D 
 
   jmp isDown
SuiteActionS 
 
   jsr restoreBackground
   inc Ypos
 
   jsr drawPlayer
   jmp endAction

actionD 
   ldaa newKey 
   anda #%10
   bne Fire
   jmp isRight
SuiteActionD 

   jsr restoreBackground
   inc Xpos


   jsr drawPlayer
   jmp endAction

actionFire 
   ldaa newKey 
   anda #%1
   bne endAction

endAction
   rts
