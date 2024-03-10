
color equ %01100000

loadDataSpriteGeneric   
startLoopGeneric
   ; memoryTampon contient le tampon et le caractere de départ
   
   ldaa memoryTampon+1; on incremente le numero de caractere soit que les bit 0 et 1  
   ldab index 
   andb #3
   aba 
   staa R5 

   ldaa  memoryTampon ; On incremente le numero de tampon + 1 tout les 4 caracteres
   ldab index  ; on recupere l'index
   lsrb  ; on decalle de 2 bits pour et on l'ajoute
   lsrb 
   aba 
   staa R4
   
   
   ldab #$0A ; 10 tranches 
   ; x contient l'adresse sources

   
   ; r4=09 -> 0000 1001
   ; r5=c0 -> 1100 0000
BI010Generic
   ldaa $0,x 
   staa R1
   ldaa #$34 ; %00110100 ecriture octet 
   staa R0+EXEC
   jsr BUSY 
   inc R5
   inc R5
   inc R5
   inc R5
   inx 
   decb
   bne BI010Generic
   ldaa nbByte
   cmpa index
   beq endLoadDataSpriteGeneric
   inc index
   
   jmp startLoopGeneric
endLoadDataSpriteGeneric 
   clra 
   staa index
   rts



loadDataSprite   
   
startLoop
   ldd  memoryTampon;#$09c0 ; a=R4 et b = R5
   
   ; r4=09 -> 0000 1001
   ; r5=c0 -> 1100 0000
   addb index
   std R4
   ldab #$0A ; 10 tranches 
BI010
   ldaa $0,x 
   staa R1
   ldaa #$34 ; %00110100 ecriture octet 
   staa R0+EXEC
   jsr BUSY 
   inc R5
   inc R5
   inc R5
   inc R5
   inx 
   decb
   bne BI010
   ldaa nbByte
   cmpa index
   beq endLoadDataSprite
   inc index
   jmp startLoop
endLoadDataSprite 
   clra 
   staa index
   rts
;********  Routine de sprite Generique **********
; Affiche un sprite en bichrome de taille variable
;
; couleur du sprite : colorR3Sprite
; X : tamponX 
; Y : TamponY 
; nb ligne = lines 
; nb colonnes = colums 
; tampon et caractere du premier dessin : D 


drawSpriteGeneric
   ; D contient R1 et R2
   std R1
   clrb 
   ldaa tamponY
   staa R6
   ldaa tamponX
   staa R7

loopLines 
   ldaa tamponX
   staa R7
loopColum
   ldaa colorR3Sprite
   staa R3
   ldaa #$01
   staa R0+EXEC
   jsr BUSY
   inc R1
   incb 
   cmpb colums
   bne loopColum 

   clrb
   ldaa R6
   inca 
   staa R6
   ldaa compteurLine
   inca 
   staa compteurLine

   cmpa lines 
   bne loopLines

   rts

;**************************

drawSprite3230
   std R1
   ldaa tamponY
   staa R6
   ldaa tamponX
   staa R7
 ; 4 Affichage du caractere
   
   ;ldd #$2481 ; jeu G'0
   ; r1, a = $26 -> 0010 0100 ; tampon 9 caractere 0 ( c1 = 00 | c2=01 | c3=10 | c4=11) 
   ; r2, b = $81 -> 1000 0001
   
   ;ldaa #%000000001 ; #$70
   ldaa colorR3
   ;oraa #%000000000
   staa R3
   ldaa #$01
   staa R0+EXEC
   jsr BUSY

   
   ;ldd #$2581 ; jeu G'0
   ; r1, a = $26 -> 0010 0100 ; tampon 9 caractere 0 ( c1 = 00 | c2=01 | c3=10 | c4=11) 
   ; r2, b = $81 -> 1000 0001
   inc R1
   ;std R1
 ;  ldaa #%000000111 ; #$70
   ldaa colorR3
   staa R3
   ;inc R7
   ldaa #$01
   staa R0+EXEC
   jsr BUSY

   ldaa tamponY
   inca
   staa R6
   ldaa tamponX
   staa R7
   ;ldd #$2681 ; jeu G'0
   ; r1, a = $26 -> 0010 0100 ; tampon 9 caractere 0 ( c1 = 00 | c2=01 | c3=10 | c4=11) 
   ; r2, b = $81 -> 1000 0001
   inc R1
   ;std R1
   ldaa colorR3
  ; ldaa #%000000111 ; #$70
   staa R3
   ldaa #$01
   staa R0+EXEC
   jsr BUSY

   
   ;ldd #$2781 ; jeu G'0
   ; r1, a = $26 -> 0010 0100 ; tampon 9 caractere 0 ( c1 = 00 | c2=01 | c3=10 | c4=11) 
   ; r2, b = $81 -> 1000 0001
   inc R1
   ;std R1
   ldaa colorR3
 ;   ldaa #%000000111 ; #$70
   staa R3
   ;inc R7
   ldaa #$01
   staa R0+EXEC
   jsr BUSY
   rts
; busy

; Draw Caractere

drawCarac 
   ; A numero sprite
   ; R6 y 
   ; R7 X 
   ldab #$81 ; jeu G'0
   ; r1, a = $26 -> 0010 0110 ; tampon 9 caractere 3 ( c1 = 00 | c2=01 | c3=10 | c4=11) 
   ; r2, b = $81 -> 1000 0001
   std R1
   ldaa #%000000111 ; #$70
   staa R3
   ldaa #$01
   staa R0+EXEC
   bsr BUSY
   rts

drawCell 
   ; 4 * 4 caractere
   ; ldx adresse 
   ; a numero c 
   deca
   ldab #16 
   mul ; a*b -> d 
   ldx #cells-1+2 
   stx adrTampon
   addd adrTampon
   pshb 
   psha 
   pulx 
   clra 
   staa ligne 
   staa colonne 
loopDrawCell   

   ldaa ligne
   adda ligneMap
   staa R6 
   ldaa colonne
   inca 
   staa colonne
   adda colonneMap  
   staa R7
   ldaa colonne
   cmpa #4+1
   beq UpLineDrawCell

   inx 
   ldaa 0,x
   ;cmpa 0 
   beq loopDrawCell
   ; recupere la couleur
      ; pshx
      ; tab 
      ; ldx #colorSprite
      ; abx
      ; ldab 0,x
      ; stab colorR3
      ; pulx
      
   adda #$23 ; numero de tampon
   jsr drawCarac
   jmp loopDrawCell
UpLineDrawCell
   clra 
   staa colonne
   ldaa ligne
   inca
   staa ligne 
   cmpa #4
   
   beq endDrawCell  
   jmp loopDrawCell
endDrawCell
   rts

BUSY
   tst R0
   bmi BUSY
   rts 
restoreBackground
   ; efface l'ancienne position
   ldaa Xpos
   ldab Ypos
   jsr getPosition

   jsr getIdSprite
   cmpa #1
   ble drawVide
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
drawVide
   ldaa #%110000 ; fond jaune
   staa colorR3
   ldd #$0081 ; a=R1 b=R2
   jsr drawSprite3230
   rts
drawPlayer   

   ldaa Xpos
   ldab Ypos
   jsr getPosition
   ldaa colorPlayer 
   staa colorR3
   ldaa idSpritePerso
   ldab #$81 ; a=R1 b=R2
   jsr drawSprite3230
   rts