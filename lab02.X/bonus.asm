#INCLUDE <p18f4520.inc>
CONFIG OSC = INTIO67   
CONFIG WDT = OFF       
ORG 0x00
    
clr:
    CLRF 0x30;n
    CLRF 0x31;l
    CLRF 0x32;r
    CLRF 0x33;mid
    CLRF 0x34;tmp
    
init:
MOVLW 0x15 
MOVWF 0x00

MOVLW	0x35 
MOVWF 0x01

MOVLW	0x55 
MOVWF 0x02

MOVLW	0x75 
MOVWF 0x03

MOVLW	0x95 
MOVWF 0x04

MOVLW	0xB5	 
MOVWF 0x05

MOVLW	0xD5
MOVWF 0x06

MOVLW	0x33 ;req
MOVWF 0x07
    
init_bs:
    MOVLW 0x07 
    MOVWF 0x30;n=7
    MOVF 0x30, w
    DECF WREG
    MOVWF 0x32;r=n-1;l=0
    
bs:
    CLRF WREG 
    ADDWF 0x31, W 
    ADDWF 0x32, W 
    MOVWF 0x33
    RRNCF 0x33;mid/=2
    MOVLW b'01111111'
    ANDWF 0x33
  
    movff 0x33, FSR0L
    MOVF 0x07, w
    CPFSEQ INDF0
	GOTO case_gt
    MOVLW 0xFF	 
    MOVWF 0x11
	   
    case_gt:
	MOVF 0x07, w
	cpfslt INDF0 ; arr[mid] < wreg
	    GOTO case_lt
	MOVFF 0x33, 0x34
	INCF 0x34
	MOVFF 0x34, 0x31    ;l=mid+1
	GOTO check
	
    case_lt:
	MOVFF 0x33, 0x34
	DECF 0x34
	MOVFF 0x34, 0x32    ;r=mid-1

    check:
	movf 0x32, w
	cpfsgt 0x31
	    goto bs
done:
    NOP                    ; End of program
    END
