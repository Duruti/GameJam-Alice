CAT_X equ 19
CAT_Y equ 22
initNoBonus
   ;efface l'ecran

   ldab #$80 ; efface l'écran
   jsr $FBD6
   ;jsr $fbd4
 
   ldaa #%01100000
   staa colorText
   ; Charge le sprite LarcinLazer

   ; ; Place la redefinition des caracterere en bank 4
   ; ldaa #%10000100 ; DOR 
   ; staa R0 
   ; ldaa #$13 
   ; staa R1+EXEC 
   ; jsr BUSY
   
   ldd #$09c0 ; a=R4 et b = R5
   std memoryTampon
   ldx #catNoBonus1+2
   jsr loadDataSprite
  
   ldd #$0Ac0 ; a=R4 et b = R5
   std memoryTampon
   ldx #catNoBonus2+2
   jsr loadDataSprite

   ldd #$0Bc0 ; a=R4 et b = R5
   std memoryTampon
   ldx #catNoBonus3+2
   jsr loadDataSprite
  
   ldd #$0Cc0 ; a=R4 et b = R5
   std memoryTampon
   ldx #catNoBonus4+2
   jsr loadDataSprite
   
   ldaa #CAT_X
   staa tamponX 
   ldaa #CAT_Y
   staa tamponY 
   ldaa #%00000011 ; fond jaune
   staa colorR3
   ldd #$2481 ; a=R1 b=R2
   jsr drawSprite3230


   ldx #textNoBonus
   ldd #$0310
   jsr drawText


   ldx #animCat

   rts 
updateNoBonus



 ;  jsr getKey  
 ;  jsr updateKeyNoBonus    

 ;   ldaa newKey
 ;   staa oldKey

  ;*****  PATCH CLAVIER *****
   
   jsr INPUTKEY
   cmpa #$20
   beq exitNoBonus
   bne testJoyNoBonus

nextUpdateNoBonus
   ldaa isAnim
   beq endUpdateMenu

   ldaa timerAnimation
   anda #7 
   bne endUpdateMenu


   jsr playAnimCat
   ldaa #CAT_X
   staa tamponX 
   ldaa #CAT_Y
   staa tamponY 
   ldaa #%00000011 ; fond jaune
   staa colorR3
   ldaa 0,x
   ldab #$81 ; a=R1 b=R2
   jsr drawSprite3230

endUpdateMenu
   clra 
   staa isAnim
   rts 

testJoyNoBonus
   clra 
   staa newKey
   jsr getJoystick
   neg newKey
   dec newKey 

   jsr updateKeyNoBonus
   ldaa newKey
   staa oldKey
   
   jmp nextUpdateNoBonus 

playAnimCat
   cpx #animCat+3
   beq initAnimCat 
   inx 
   rts 
initAnimCat 
   ldx #animCat
   rts 


exitNoBonus

   ldaa #%1 ; force la barre espace 
   staa newKey
   neg newKey
   dec newKey 

   ldaa newKey
   staa oldKey 

   clra 
   staa currentLevel
   ldab #$0 ; efface l'écran
   jsr $FBD6
   sei 
   ldab #sceneMenu
   jsr changeScene
   cli
   rts


updateKeyNoBonus

   ;Fire : Espace
   ldaa oldKey 
   anda #%1
   bne actionFireNoBonus
   rts

actionFireNoBonus
   ldaa newKey 
   anda #%1
   bne endActionNoBonus
   jsr exitNoBonus

endActionNoBonus
   rts


animCat byte $24,$28,$2C,$30
textNoBonus byte "PAS ASSEZ DE BONUS POUR CONTINUER",0