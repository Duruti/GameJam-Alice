 
 ; Projet de jeu pour la gamejam de Retro Programmers United for Obscure Systems
 ; Pour l'Alice 32 & 90

; gfx https://piiixl.itch.io/1-bit-in-motion
 
 processor 6803
std equ 1
cart equ 2
mode equ std
 if mode=std
  echo "std"
  org $3346
; header basic
 BYTE $33, $52, $00, $0a, $9f, $20, $31, $33, $31, $34, $32, $00, $00, $00, $00, $00

 else 
  echo "cart"
  org $1000 
 endif

start

 
   clr $00E8
   include "sources/constante.asm"
   ldaa #$01
   staa TECRA 
   clra
   jsr INASS

  ; CONFIGURE LA Vsync
   ldaa #%10000001 ; veux ecrire dans le TGS via R1 
   staa R0
   ldaa #%10000 ; passe TGS4 à 1 
   staa R1+EXEC 
   jsr busy 

   ldaa #%10010101 ; passe en VRM pour se synchroniser sur 
   staa R0+EXEC 
   jsr busy


   ; copie variable
  ldaa #-3
  staa colonneMap
  ldaa #2
  staa nbLine
  ldaa #4-1
  staa nbByte 
  ldaa #8
  staa ligne
  staa ligneMap
  ldaa #$ff 
  staa oldKey 
  ldaa #0 
  staa currentLevel
  ldaa #7
  staa colorR3
  ldaa colorSprite+1
  staa colorPlayer
  clra
  staa scoreBonus


   ldaa #80 ; efface l'écran
   jsr $FBD6

   if mode=cart 
    ; copie dans la ram la gameloop pour automodification
    ldx #$4000
    ldaa #$bd ; jsr update
    staa 0,x 
    staa 1,x 
    staa 2,x 
    
    ldaa #$7e ;jmp loop
    staa 3,x 
    ldaa #$40
    staa 4,x 
    ldaa #$00
    staa 5,x 

    ldaa #$bd ; jsr init
    staa 6,x 
    staa 7,x 
    staa 8,x 
    ldaa #$39 ; rts
    staa 9,x 
   endif
   ldab #sceneGame
   jsr changeScene
   ; jsr initGame
 if mode=std
   
updateCurrentScene 
   jsr updateGame ; automodifié
   jmp updateCurrentScene
 else 

   jmp $3700  
 endif




   include "sources/sceneManager/sceneManager.asm"
   include "sources/sceneManager/scenes/sceneGame.asm"
   include "sources/sceneManager/scenes/sceneGameOver.asm"
   include "sources/sceneManager/scenes/sceneMenu.asm"
   include "sources/sceneManager/scenes/sceneNextLevel.asm"
   include "sources/utils.asm"
   include "sources/sprite.asm"
   include "sources/math.asm"
   include "sources/keyManager.asm"
   include "sources/updateKey.asm"
   include "sources/ghost.asm"
   include "sources/levelManager/level.asm"

 if mode=cart 
 org $4000
updateCurrentScene 
   jsr updateGame ; automodifié
   jmp updateCurrentScene

initCurrentScene jsr initGame ; automodifié
   rts 
 endif

startVariable 

currentScene byte sceneMenu
nbLine byte 2
nbByte byte 4-1
index byte 0
tamponX byte 0;10
tamponY byte 0;20
Xpos byte 0 ; position par case
Ypos byte 0
oldPosX byte 0
oldPosY byte 0
ligne byte 8
colonne byte 0
ligneMap byte 8
colonneMap byte -3
adrTampon byte  0,0 
memoryTampon byte 0,0
oldKey byte $FF  ; etat des touches
newKey byte 0 
value byte 0
statusJoy byte 0
result byte 0 
tempoText byte 0
isStart byte 0
scoreBonus byte 0
colorR3 byte 0
colorPlayer byte 0
colorPiege byte 0

hearderLevel equ 2+4 ; 2(NbLevel + size) 4 (NbLevel + size + posPerso + posDoor)
width equ 12 ;12
height equ 6
saveSP word 0
currentLevel byte 0
adrCurrentLevel word 0
adrCurrentLevelSprite word 0
currentMapSprite ds width*height,0 
indexPiege byte 0
indexGhost byte 0
tempoGhost byte 0

lstGhost ds 50,0
lstPiege ds width*height*2,0

endVariable 



end 

prgSize=end-start
 echo "start: ",start
 echo "end: ",end

 echo "size :",prgSize 
 echo "X: ",Xpos
 echo "Y ",Ypos 
 echo "currentmap ",currentMapSprite 
 echo "lstGhost",lstGhost