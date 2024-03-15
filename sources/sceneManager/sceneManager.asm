

sceneMenu equ 0 
sceneGame equ 1
sceneGameOver equ 2
sceneNextLevel equ 3
sceneSelectLevel equ 4
sceneVictory  equ 5
sceneNoBonus equ 6

adrUpdateScene word updateMenu,updateGame,updateGameOver,updateNextLevel,updateSelectLevel,updateVictory,updateNoBonus
adrInitScene word initMenu,initGame,initGameOver,initNextLevel,initSelectLevel,initVictory,initNoBonus


changeScene 
   ; b contient la nouvelle scene
   ; verifie s'il faut changer
   cmpb currentScene
   beq endChangeScene

   ; on actualise le currentscene
   stab currentScene

   ; on change l'update via l'automodification
   ldx #adrUpdateScene
   lslb
   abx ; x pointe sur le nouveau update
   ldaa 0,x 
   staa updateCurrentScene+1
   ldaa 1,x 
   staa updateCurrentScene+2

   ; on lance l'initialisation de la nouvelle scene

   ldx #adrInitScene
   abx ; x pointe sur le nouveau init
   ldaa 0,x 
   staa initCurrentScene+1
   ldaa 1,x 
   staa initCurrentScene+2
 if mode=std 
initCurrentScene jsr initGame ; automodifié
 else
   jmp initCurrentScene
 endif 

endChangeScene   
   rts