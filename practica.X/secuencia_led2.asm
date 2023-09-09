#include "p16f887.inc"

; CONFIG1
; __config 0x28D5
 __CONFIG _CONFIG1, _FOSC_INTRC_CLKOUT & _WDTE_OFF & _PWRTE_OFF & _MCLRE_OFF & _CP_OFF & _CPD_OFF & _BOREN_OFF & _IESO_OFF & _FCMEN_ON & _LVP_OFF
; CONFIG2
; __config 0x3FFF
 __CONFIG _CONFIG2, _BOR4V_BOR40V & _WRT_OFF

    
    LIST p=16F887
    
N EQU 0xD0
cont1 EQU 0x20
cont2 EQU 0x21
cont3 EQU 0x22
 

 
    ORG 0x00
    GOTO INICIO
    
INICIO
    ;los rp y el irp son la seccion del banco de memoria en el que estamos trabajando
    ;al estar en RP0=0 y RP1=0 estamos trabajando en el banco 0
    BCF STATUS, RP0 ;pone el bit de rp0 en 0
    BCF STATUS, RP1 ; rp1 en 0
    CLRF PORTA ;limpia el registro del puerto A para poder usarlo sin inconvenientes
    CLRF PORTB ;limpia el puerto B esto incluye todos los puertos de su letra correspondiente
    ;con esto terminamos de limpiar los puertos con los que vamos a trabajar
    ;ahora debemos cambiar de banco al banco 1 lo cual logrmamos con 
    ;RP1=0 y RP0=1 por lo cual solo tenemos que cambiar uno de ellos
    BSF STATUS, RP0 ;Con BSF ponemos el bit de RP0 en 1 y cambiamos al banco 1
    CLRF TRISA ;Debemos limpiar estos puertos debido a que afectan a los puertos 
    CLRF TRISB 
    BSF STATUS, RP1 ;Ahora cambiamos al banco 3 donde esta los siguiente puertos que 
    ;tambien afectan al los puertos A y B que son los que vamos a usar 
    CLRF ANSELH
    BCF STATUS, RP0
    BCF STATUS, RP1
    ;cambiamos al banco 0
    movlw 0x51
    movwf OSCCON
    ;osccon es el mando para controlar la frecuencia del reloj interno
    ;y el 0x51 y es la frecuencia que le estamos dando a el reloj interno 
    movlw 0x00
    movwf cont3
    ;creamos una nueva variable y le damos su respectivo almacenamiento
	GOTO SECUENCIA2
ENC_LED
    BSF PORTA,0	;RA0 = 1
    CALL RETARDO
    BCF PORTA,0
    CALL RETARDO
    GOTO ENC_LED
    

SECUENCIA2
    CALL RETARDO
    MOVF cont3,0
    CALL SEC_LOOKUP
    MOVWF PORTB
    INCF cont3,1
    GOTO SECUENCIA2
    
    
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

SEC_LOOKUP 
	ADDWF PCL,f
	RETLW 81h 
	RETLW 43h 
	RETLW 25h 
	RETLW 17h 
	RETLW 17h 
	RETLW 2Bh 
	RETLW 4Dh
	RETLW 8Fh 
	RETURN
    
    
    END


