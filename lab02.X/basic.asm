#INCLUDE <p18f4520.inc>
 CONFIG OSC = INTIO67
 CONFIG WDT = OFF 
 org 0x00 ;PC = 0x00 

;tc1
    MOVLW 0x00
    MOVLB 0x01
    MOVWF 0x00, 1

    MOVLW 0x01
    MOVWF 0x16, 1
setup:
    LFSR 1, 0x100 ; FSR1 point to 0x100
    LFSR 2, 0x116 ; FSR2 point to 0x116
start:
    MOVLW d'6'
    MOVWF 0x00
loop:
    CLRF WREG 
    ADDWF POSTINC1, W 
    ADDWF INDF2, W 
    MOVWF INDF1
    
    CLRF WREG 
    ADDWF INDF1, W 
    ADDWF POSTDEC2, W 
    MOVWF INDF2
    
    DECFSZ 0x00
	GOTO loop
finish:
NOP
end


