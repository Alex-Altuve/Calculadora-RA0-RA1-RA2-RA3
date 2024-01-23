
#include p16f84a.inc                ; Include register definition file
   __CONFIG _XT_OSC & _PWRTE_ON & _CP_OFF & _WDT_OFF
;====================================================================
; VARIABLES
;====================================================================
PUERTOA 				EQU 05H
PUERTOB 				EQU 06H ; Declaración del puerto B en la dirección 06 H
STATUS 					EQU 03H ; Declaración del registro de estado
NUMB					EQU 0x0D
NUMA 					EQU 0x0C
;====================================================================
; RESET and INTERRUPT VECTORS
;====================================================================
; Reset Vector
	ORG 	0
      	goto  Start
	ORG 	5
;====================================================================
; CODE SEGMENT
;====================================================================

Start	 
  
    BSF STATUS,5 ; Cambio del banco de memoria. Banco 1 activado.
    CLRF TRISB ; Configuración de la puerta B como puerto de salida.
    movlw b'000001111' 
    movwf TRISA
    BCF STATUS,5 ; Cambio del banco de memoria. Banco 0 activado   

LOOP
      MOVF PUERTOA,0 
      MOVWF NUMB  ;copio el valor de puertoa en numB y numA
      MOVWF NUMA   
      RRF NUMB,1   ;roto dos veces a la derecha para quedarme con ra2 y ra3 00000011 asi
      RRF NUMB,1
      MOVLW b'00000011' ; muevo este num a w
      ANDWF NUMB,1 ; aplico and para quedarme con los bits que quiero
      ANDWF NUMA,1 ; 
      ;aqui aplico la suma
      MOVF NUMA,0
      ADDWF NUMB,0  
     
         
	    
  
    ; Escribir el resultado de la suma en el puerto B
    MOVWF PUERTOB
    goto LOOP ; Volver al inicio del loop
	 END