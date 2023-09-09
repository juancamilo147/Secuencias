
; PIC16F887 Configuration Bit Settings

; Assembly source line config statements

#include "p16f887.inc"

; CONFIG1
; __config 0x3CF4
 __CONFIG _CONFIG1, _FOSC_INTRC_CLKOUT & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _CP_OFF & _CPD_OFF & _BOREN_OFF & _IESO_OFF & _FCMEN_OFF & _LVP_OFF
; CONFIG2
; __config 0x3FFF
 __CONFIG _CONFIG2, _BOR4V_BOR40V & _WRT_OFF

    
CHING equ 127
CLOW equ 64 
    
N EQU 0xB7; cambiamos el 87 por el B7
cont1 EQU 0x20
cont2 EQU 0x21
 
 
    ORG	0x00
    GOTO INIT

INIT
    ;BANK
    BSF STATUS, RP0 ; BSF sirve para poner el bit en 1
    BCF STATUS, RP1 ; BCF sirve para poner el bit en 0
    ;bank1
    movlw 0x61;Se cambio el 71 por el 61 
    movwf OSCCON ;con esta configuracion el reloj queda a 8MHz
    ;BCF STATUS, RP0
    
    movlw 0x0E
    movwf TRISE 
    
    ;movlw 0x00
    ;movwf ANSEL
    ;BSF ANSEL, 0 esta instruccion tambien es valida
    BSF STATUS , RP1 ; Esto nos mueve al banco 3
    clrf ANSEL ;esta instruccion tambien es valida ya que pone todo en 0
    ;BSF TRISE,0
    BCF STATUS, RP0
    BCF STATUS, RP1
    ;cambiamos al banco 0
    ;BSF PORTE, 0 ; con esta instruccion se prende el led
    BCF PORTE, 0 ; con esta instruccion se apaga el led
ENC_LED
    BSF PORTE,0	;RA0 = 1
    CALL RETARDO
    BCF PORTE,0
    CALL RETARDO
    GOTO ENC_LED
    

    
RETARDO
    MOVLW N
    MOVWF cont1
    
REP_1
    MOVLW N
    MOVWF cont2
    
REP_2
    DECFSZ cont2,1
    GOTO REP_2
    DECFSZ cont1,1
    GOTO REP_1
    RETURN

    END


