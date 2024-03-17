; test d'interruption via OCF

initInterruption
   ; redirige l'interruption de TOF
   sei ; coupe interruption
   
  ;jsr action

   clra 
   staa indexMusic
   staa impuls
 
  ;  redirige l'interruption TOF 
    ldaa #$7e
    staa $3203
    ldd #TOFInterrupt
    std $3204

   ;redirige l'interruption OCF 
    ldaa #$7e
    staa $3206
    ldd #OCFInterrupt
    std $3207




  ldaa $08
  ldd $09 ; lit le compteur
  addd note
  std $b

   ldaa $08
   oraa #%00001101 ; met a 1 le bit EOCI et le bit OLVL pour autoriser l'interruption OCF
   staa $08
   
   cli ; on active le bit i du drapeau
   rts

TOFInterrupt
   ; interruption déclenché toutes les 65.5 ms
   ; remet le compteur d'interruption a zero
   ; init TOF
   ldaa $08
   ldaa $09
   ;
   inc tempoAutomaticMove
   inc tempoGhost
   ; gere le timer Animation
   inc timerAnimation
   ldaa #1
   staa isAnim

   ldaa isSceneMenu
   cmpa #1
   beq testMenu 

   ; gere la durée de la note avec le compteur
nextTof
   inc compteur
   ldab compteur 
   cmpb duree 
   bne endTof
   jsr action
endTof
   rti 
testMenu 
   jsr getKeyMenu 
   jsr updateKeyMenu   
   ldaa newKey
   staa oldKey

   jmp nextTof 

OCFInterrupt
   ; interruption déclenché quand le compteur = compteur de sortie
   ldaa stateMusic
   bne nextOCFInterrupt
   rti 

nextOCFInterrupt
   ldaa isOff ; controle si on termine une note 
   bne offNote

   ldaa isPlayingSilence ; faut il jouer un silence
   bne playNothing

   ldaa impuls ; actualise l'onde 
   eora #$ff  
   staa $bfff 
   staa impuls

   ldaa $08 ; reset du Flag d'interruption
   std $b
  
   ldd $09 ; lit le compteur
   addd note ;  recalcule la sortie en fonction de la note
   std $b ; envoie le nouveau compteur de sortie
   
   rti

playNothing
   ; joue un signal bas pour faire un silence

   ldaa #0 
   staa $bfff 

   ldaa $08
   std $b
  
   ldd $09 ; lit le compteur
   addd note ;  recalcule la sortie en fonction de la note
   std $b ; envoie 
   rti

offNote 
   
   clra ; ne joue pas de note durant une durée
   staa $bfff 

   ldaa $08
   std $b
  
   ldd $09 ; lit le compteur
   addd oldNote ;  recalcule la sortie en fonction de la note
   std $b ; envoie 
   dec isOff
   rti

action
   clra  ; init le compteur TOF
   staa compteur
   staa isPlayingSilence ; remet a zero le silence

   ldab indexMusic   ; recupere l'index pour parcourir la musique
   incb
   stab indexMusic
   cmpb lenghtMusic ; regarde si l'on est a la fin du morceau
   bne suite 
   ; si ou on remet a zero l'index
   clrb 
   stab indexMusic

suite 
   ; ici on joue la nouvelle note
   ; sauvegarde l'ancienne note et fixe le compteur pour terminer une note
   ldd note 
   std oldNote
   ; avant on va faire un silence de l'ancienne note
   ldaa #2 ; on boucle 2 fois 
   staa isOff

   ; on récupere la nouvelle note en se déplacant dans les data de la musique
   ldx #music+1
   ldaa #4
   ldab indexMusic
   mul
   abx  

   ldd 0,x ; recupere la note, c'est la demi periode 
   cmpa #0 ; si ça vaut 0 alors c'est un silence
   bne nextNext
   cmpb #0
   beq playSilence
nextNext
   ; sinon on joue la note 
   std note ; la sauve dans la variable
   ldaa 3,x ; recupere la durée
   staa duree
   rts
playSilence

   ; joue un silence 
   ldaa #1
   staa isPlayingSilence

   ldd #1000 ; valeur au pif
   std note 
   ldaa 3,x
   staa duree
   rts




do equ      3846; +154        ;130

