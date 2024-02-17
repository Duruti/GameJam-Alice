; gere les cases pour le déplacement automatique

isAutomaticMove
   ; regarde si l'on est sur une case de déplacement automatique
   jsr getIdSprite
   cmpa #idMoveUp
   beq MoveTrue 
   cmpa #idMoveRight
   beq MoveTrue 
   cmpa #idMoveDown
   beq MoveTrue 
   cmpa #idMoveLeft
   beq MoveTrue 

   clra
   staa statusAutomaticMove

   rts

MoveTrue

   ; stocke dans le status la direction avec l'Id de la tuile
   staa statusAutomaticMove
   rts 

MovePlayerAutomatic

   ldab tempoAutomaticMove
   cmpb #speedAutomaticMove
   bne EndMovePlayerAutomatic

   clrb  ; reset le tempo 
   staa tempoAutomaticMove

   ; gere le déplacement automatique du player
   ; a contient la direction 
   ldaa statusAutomaticMove
   cmpa #idMoveUp
   beq MovePlayerAutomaticUp 
   cmpa #idMoveRight
   beq MovePlayerAutomaticRight
   cmpa #idMoveDown
   beq MovePlayerAutomaticDown
   cmpa #idMoveLeft
   beq MovePlayerAutomaticLeft

EndMovePlayerAutomatic
   inc tempoAutomaticMove   
   jmp escapeKey ; pas necessaire 


MovePlayerAutomaticUp
   jsr restoreBackground
   ldaa Ypos
   staa oldPosY
   dec Ypos
   jsr drawPlayer
   jmp escapeKey

MovePlayerAutomaticRight

   jsr restoreBackground
   ldaa Xpos
   staa oldPosX
   inc Xpos
   jsr drawPlayer
   jmp escapeKey

MovePlayerAutomaticDown
   jsr restoreBackground
   ldaa Ypos
   staa oldPosY
   inc Ypos
   jsr drawPlayer
   jmp escapeKey

MovePlayerAutomaticLeft
   jsr restoreBackground
   ldaa Xpos
   staa oldPosX
   dec Xpos
   jsr drawPlayer
   jmp escapeKey

