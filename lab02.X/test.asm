#INCLUDE <p18f4520.inc>
CONFIG OSC = INTIO67   
CONFIG WDT = OFF       

ORG 0x00             
clr:
	CLRF 0x100
	CLRF 0x106
	CLRF 0x110 ; i
	CLRF 0x111 ; j
	CLRF 0x112 ; n
	CLRF 0x113 ; n-1
	CLRF 0x114 ; loop cnt
init:
    MOVLB 0x01 ; bank
	
	MOVLW 0x08 
        MOVWF 0x00
	
	MOVLW	0x7C 
	MOVWF 0x01
	
	MOVLW	0x78 
	MOVWF 0x02
	
	MOVLW	0xFE 
	MOVWF 0x03
	
	MOVLW	0x34 
	MOVWF 0x04
	
	MOVLW	0x7A 
	MOVWF 0x05
	
	MOVLW	0x0D 
	MOVWF 0x06
init_oloop:
    LFSR 0, 0x100;j
    MOVLW d'7'
    MOVWF 0x12, 1;[0x12]=n
    MOVFF 0x112, 0x113 
    DECF 0x13, 1, 1 ; [0x13] = n-1
oloop:
    init_iloop:
	MOVFF 0x110, 0x111 ;j=i
	INCF 0x11, 1, 1 ;j=i+1
    movjp:
	init_jp:
	    LFSR 1, 0x100;ip   
	    MOVFF 0x111, 0x114
	mov:
	    MOVFF POSTINC1, WREG
	mov_cont:
	    DECFSZ 0x14, 1, 1
		GOTO mov
    iloop:
	MOVFF INDF1, WREG
	CPFSGT INDF0
	    GOTO iloop_cont
    swap_element:
	MOVFF INDF0, WREG ;
	MOVFF INDF1, INDF0;
	MOVFF WREG, INDF1 ; 
    iloop_cont:
	INCF 0x11, 1, 1;j++
	MOVFF POSTINC1, WREG ; pj->pj_next
	MOVFF 0x112, WREG ; WREG  = n
	CPFSEQ 0x11, 1 ; cmp j with n, skip if  '='
	    GOTO iloop
oloop_cont:
    INCF 0x10,1 , 1 ; i++ 
    MOVFF POSTINC0, WREG ; pi++
    MOVFF 0x113, WREG
    CPFSEQ 0x10, 1 ; cmp i with n-1
	GOTO oloop
done:
    NOP                    ; End of program
    END
