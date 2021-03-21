;JEF
PROCESSOR 16F877
INCLUDE <P16F877.inc> 
MIN EQU H'40' ; Donde se guardara el resultado
	
ORG 0
GOTO  INICIO
ORG 5

INICIO: 
	MOVLW H'20' ;Carga W con 0x20 W <-- 0x20
	MOVWF FSR 	;Carga FSR con el valor de W  FSR <-- (W)
	GOTO CAMBIO ;Salta a la etiqueta CAMBIO
LOOP:
	MOVF MIN, 0 ; W <-- MIN
	SUBWF INDF, 0 ; W <-- INDF - W
	;Se comprueba la bandera Z, si son iguales Z=1, si no Z=0
	BTFSC STATUS, Z ; ¿Z=0? 
	GOTO VERIFICAR ;SI son iguales, repite
	; Si no son igaules, se comprueba la bandera C
	BTFSC STATUS, C ; SI C=0 entonces ACTUAL es menor
	GOTO VERIFICAR; Si C=1 entonces SIG es el menor
	GOTO CAMBIO ;Salta a la etiqueta CAMBIO
CAMBIO:
	MOVF INDF,0 ; Mueve a W el valor ubicado por el apuntador FSR 
	MOVWF MIN ;Carga MIN con el valor de W  MIN <-- (W)
	GOTO VERIFICAR ;Salta a la etiqueta VERIFICAR
VERIFICAR:
	INCF FSR,1 ;Incrementa en el 1 el registro FSR
	BTFSS FSR, 6 ;Prueba el bit 6 del registro FSR si es 1 salta
	GOTO LOOP ;Salta a la etiqueta LOOP
	GOTO $ ;Se queda ejecutando siempre esa instrucción
	END; Termina el programa