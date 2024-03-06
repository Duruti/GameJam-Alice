 
 ; Projet de jeu pour la gamejam de Retro Programmers United for Obscure Systems
 ; Pour l'Alice 32 & 90

; gfx https://piiixl.itch.io/1-bit-in-motion
 
 processor 6803

LevelStart equ 10
MaxLevel equ 26
DEBUG equ 1
sceneStart = sceneGame
std equ 1
cart equ 2
mode equ std   ; ici on choisi le type d'export

 if mode=std
  echo "std"
  org $3346
; header basic
start
 BYTE $33, $52, $00, $0a, $9f, $20, $31, $33, $31, $34, $32, $00, $00, $00, $00, $00
 else 
  echo "cart"
  org $1000 
start
 ; code pour transferer le code qui transfera le code 

   ldd #endCopyCode-startCopyCode + codeTransfert ; fin de la zone a copié
   std adressFinCopy
   ldx #codeTransfert ; source 
   ldd #$3400 ; destination 
   std adressTamponCopy ; tampon 
loopCopy
  ldaa 0,x    ; recupere l'octet
  pshx        ; sauve X 
  ldx adressTamponCopy ; recupere la destination dans x 
  staa 0,x    ; copy l'octet
  inx         ; incremente x 
  stx adressTamponCopy ; resauvegarde dans l'adressTampon
  pulx        ; restaure X 
  inx         ; increment x
  cpx adressFinCopy ; regarde si on arrive à la fin de la data a copier
  bne loopCopy
  
  jmp $3400

codeTransfert   
 rorg $3400
startCopyCode

 ; code pour transferer 1 ere Bank en RAM
  ldd #$2FFF+1 ; fin de la zone a copié
  std adressFinCopy
  ldx #startCodeCart ; source 
  ldd #$3500 ; destination 
  std adressTamponCopy ; tampon 
  jsr copyData


 ; code pour transferer la 2 eme Bank en RAM
  ldaa #1 ; choix bank 2
  staa $1000
 
  ldd #$2FFF+1 ; fin de la zone a copié
  std adressFinCopy
  ldx #$1000 ; source 
 ;  ldd #$3400 ; destination 
 ;  std adressTamponCopy ; tampon 
  jsr copyData

  jmp $3500


copyData

  ldaa 0,x    ; recupere l'octet
  pshx        ; sauve X 
  ldx adressTamponCopy ; recupere la destination dans x 
  staa 0,x    ; copy l'octet
  inx         ; incremente x 
  stx adressTamponCopy ; resauvegarde dans l'adressTampon
  pulx        ; restaure X 
  inx         ; increment x
  cpx adressFinCopy ; regarde si on arrive à la fin de la data a copier
  bne copyData
  rts
endCopyCode 
 rend

startCodeCart

 rorg $3500

 endif

  


   include "sources/constante.asm"
 
   
   ldaa #$01
   staa TECRA 
   clra
   jsr INASS


  ldaa #80 ; efface l'écran
  jsr $FBD6

    ; charge la longueur de la musique
  ldx #music
  ldaa 0,x 
  staa lenghtMusic

  ; charge la premier note 
  ldaa #4
  staa duree
  ldx #music+1 
  ldd 0,x
  std note 

  ldaa #0
  staa stateMusic

  jsr initInterruption ; initialise les interruptions


  ; CONFIGURE LA Vsync
  ;  ldaa #%10000001 ; veux ecrire dans le TGS via R1 
  ;  staa R0
  ;  ldaa #%10000 ; passe TGS4 à 1 
  ;  staa R1+EXEC 
  ;  jsr busy 

  ;  ldaa #%10010101 ; passe en VRM pour se synchroniser sur 
  ;  staa R0+EXEC 
  ;  jsr busy


   ; copie variable
  ldaa #-3
  staa colonneMap
  ldaa #2
  staa currentScene ; place en dehors de game et Menu pour pouvoir la changer
  staa nbLine
  ldaa #4-1
  staa nbByte 
  ldaa #8
  staa ligne
  staa ligneMap
  ldaa #$ff 
  staa oldKey 
  ldaa #LevelStart-1 
  staa currentLevel
  ldaa #7
  staa colorR3
  ldaa colorSprite+1
  staa colorPlayer
  clra
  staa scoreBonus


 

   if mode=cart 
    ; copie dans la ram la gameloop pour automodification
    ldx #$3350
    ldaa #$bd ; jsr update
    staa 0,x 
    staa 1,x 
    staa 2,x 
    
    ldaa #$7e ;jmp loop
    staa 3,x 
    ldaa #$33
    staa 4,x 
    ldaa #$50
    staa 5,x 

    ldaa #$bd ; jsr init
    staa 6,x 
    staa 7,x 
    staa 8,x 
    ldaa #$39 ; rts
    staa 9,x 
   endif
   ldab #sceneStart
   jsr changeScene
   ; jsr initGame
 if mode=std
   
updateCurrentScene 
   jsr updateGame ; automodifié
   jmp updateCurrentScene
 else 

   jmp $3350  
 endif



; ****  DATA SPRITE *****
dataSprite 
 include "sources/dataGFX.asm"
endDataSprite


   include "sources/interrup.asm"
   include "sources/sceneManager/sceneManager.asm"
   include "sources/sceneManager/scenes/sceneGame.asm"
   include "sources/sceneManager/scenes/sceneGameOver.asm"
   include "sources/sceneManager/scenes/sceneMenu.asm"
   include "sources/sceneManager/scenes/sceneNextLevel.asm"
   include "sources/sceneManager/scenes/sceneSelectLevel.asm"
   include "sources/utils.asm"
   include "sources/sprite.asm"
   include "sources/math.asm"
   include "sources/keyManager.asm"
   include "sources/updateKey.asm"
   include "sources/ghost.asm"
   include "sources/key.asm"
   include "sources/automaticMove.asm"
   include "sources/levelManager/level.asm"



endCode

; **** DATA VARIABLES ****

startVariable 

; music

duree byte $80
compteur byte 0
impuls byte 0
note word do
oldNote word 0
isPlayingSilence byte 0
isOff byte 0
indexMusic byte 0 
lenghtMusic byte 0
stateMusic byte 0

timerAnimation byte 0
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
XPadlock byte 0
YPadlock byte 0
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
statusAutomaticMove byte 0
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
indexKey byte 0
tempoGhost byte 0
tempoAutomaticMove byte 0 
speedAutomaticMove equ 30
lstGhost ds 50,0
lstPiege ds width*height*2,0
lstKey ds 5*2 ,0


tableAnimPerso byte $30,$74
tableAnimTorch byte $48,$78

 align 16
tableAnimMoveUp word moveup+2,moveup2+2;   $64,$7C ; ordre IMPORTANT
tableAnimMoveRight word moveright+2,moveright2+2; $68,$28
tableAnimMoveDown word movedown+2,movedown2+2;  $6c,$2c
tableAnimMoveLeft word moveleft+2,moveleft2+2;  byte $70,$70

isAnim byte 0
indexAnim byte 0
idSpritePerso byte 0
idSpriteTorch byte 0
idSpriteAutomaticMove byte 0


indexTorch byte 0
lstTorch ds 10,0
indexAutomaticMove byte 0
lstAutomaticMove ds 60,0


endVariable 

; **** DATA LEVELS  *****
dataLevel
 include "sources/dataLevels.asm"
endDataLevel

; ***** DATA MUSIC ******
dataMusic
 align 256 
music  incbin "sources/music.bin"
endDataMusic

 rorg $3346
adressTamponCopy word 0 
adressFinCopy word 0
 rend 
end 
 if mode=cart 
 rorg $3350 ;+(endCode-start)+$100
updateCurrentScene 
   jsr updateGame ; automodifié
   jmp updateCurrentScene

initCurrentScene jsr initGame ; automodifié
   rts 
 endif
 rend

 echo "start: ",start
 echo "end: ",end

sizeCode = endCode-start 
sizeSprite = endDataSprite-dataSprite
sizeLevel = endDataLevel-dataLevel
sizeVariable = endVariable-startVariable

 echo "size Code ",sizeCode
 echo "size datasprite ",sizeSprite
 echo "size dataLevel ",sizeLevel
 echo "size Variable ",sizeVariable
 echo "size DATA ",sizeLevel + sizeSprite + sizeVariable
 echo "Total Size ",sizeCode + sizeLevel + sizeSprite + sizeVariable
 echo "***** DEBUG INFO  ***** "
  echo "rorg : ",indexAutomaticMove
;  echo "Y ",Ypos 
;  echo "currentmap ",currentMapSprite 
;  echo "StatusMove ",statusAutomaticMove