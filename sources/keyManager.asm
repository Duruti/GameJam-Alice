

; bit    7  6    5    4 3 2 1 0
;        O  P   Break  Z Q S D Espace


getKey

   clra 
   staa newKey

   ; O 
   ldaa #$7F ; précise quelle colonne on veut, ici la 1 en mettant a 0 le bit 1
   staa PORT1
   ldaa IO ; on récupere les infos dans IO
   anda #%10 ; %01000000 ; on test le bit 1 , si il vaut 0 alors 
   bne testP ; test suivant
   ldaa #%10000000
   oraa newKey
   staa newKey

testP
   ; P 
   ldaa #$FE ; précise quelle colonne on veut, ici la 1 en mettant a 0 le bit 1
   staa PORT1
   ldaa IO ; on récupere les infos dans IO
   anda #%100 ; %01000000 ; on test le bit 1 , si il vaut 0 alors 
   bne testBreak ; test suivant
   ldaa #%1000000
   oraa newKey
   staa newKey

testBreak
   ; Break 
   ldaa #$FB ; précise quelle colonne on veut, ici la 1 en mettant a 0 le bit 1
   staa PORT1
   ldaa PORT2 ; on récupere les infos dans Le port2
   anda #%10 ; %01000000 ; on test le bit 1 , si il vaut 0 alors 
   bne testZ ; test suivant
   ; mets le bit 3 de newKey a 1  
   ldaa #%100000
   oraa newKey
   staa newKey

testZ
   ; Z 
   ldaa #$7F ; précise quelle colonne on veut, ici la 1 en mettant a 0 le bit 1
   staa PORT1
   ldaa IO ; on récupere les infos dans IO
   anda #%00000100 ; on test le bit 2 , si il vaut 0 alors 
   bne testQ ; test suivant
   ; mets le bit 3 de newKey a 1  
   ldaa #%10000
   oraa newKey
   staa newKey

testQ
   ; pour Q = gauche
   ldaa #$FD ; précise quelle colonne on veut, ici la 1 en mettant a 0 le bit 1
   staa PORT1
   ldaa IO ; on récupere les infos dans IO
   anda #%00000001 ; on test le bit 1 , si il vaut 0 alors 
   bne testS
   ; mets le bit 3 de newKey a 1  
   ldaa #%1000
   oraa newKey
   staa newKey
testS
   ; pour S = bas
   ldaa #$F7 ; précise quelle colonne on veut, ici la 1 en mettant a 0 le bit 1
   staa PORT1
   ldaa IO ; on récupere les infos dans IO
   anda #%00000100 ; on test le bit 2 , si il vaut 0 alors 
   bne testD
   ; mets le bit 3 de newKey a 1  
   ldaa #%100
   oraa newKey
   staa newKey

testD
   ; pour D = droite
   ldaa #$EF ; précise quelle colonne on veut, ici la 1 en mettant a 0 le bit 1
   staa PORT1
   ldaa IO ; on récupere les infos dans IO
   anda #%00000001 ; on test le bit 3 , si il vaut 0 alors 
   bne testEspace
   ; mets le bit 3 de newKey a 1  
   ldaa #%10
   oraa newKey
   staa newKey

testEspace
   ; pour Espace = Fire
   ldaa #$7F ; précise quelle colonne on veut, ici la 1 en mettant a 0 le bit 1
   staa PORT1
   ldaa IO ; on récupere les infos dans IO
   anda #%00001000 ; on test le bit 3 , si il vaut 0 alors 
   bne endTest
   ; mets le bit 3 de newKey a 1  
   ldaa #%1
   oraa newKey
   staa newKey

   ; inverse newKey pour faciliter les tests ensuite
endTest 
  ;
   jsr getJoystick

   neg newKey
   dec newKey 

   rts

; ***********************
;        Joystick
; ***********************

getJoystick 
   ldaa joytick1
   anda #31
   staa statusJoy  
   ; up
   cmpa #30
   bne JoyLeft
   ldaa #%10000
   oraa newKey
   staa newKey

JoyLeft
   ; Left
   ldaa statusJoy
   cmpa #27
   bne JoyDown
   ldaa #%1000
   oraa newKey
   staa newKey

JoyDown
   ; Down
   ldaa statusJoy
   
   cmpa #29
   bne JoyRight
   ldaa #%100
   oraa newKey
   staa newKey

JoyRight
   ; Right
   ldaa statusJoy
   
   cmpa #23
   bne JoyFire
   ldaa #%10
   oraa newKey
   staa newKey

JoyFire
   ; Fire
   ldaa statusJoy
   
   cmpa #16 ; si inferieur a 16 alors Fire
   bgt endGetJoystick
   ldaa #%1
   oraa newKey
   staa newKey

endGetJoystick
   rts

; *****************************************************
; propre a la scene
; *****************************************************


