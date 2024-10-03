List p=18f4520 
    #include<p18f4520.inc>
    CONFIG OSC = INTIO67
    CONFIG WDT = OFF
    org 0x00
    ;basic
    
    CLRF 0x00		;save highest bit
    MOVLW b'00101101'    
    MOVWF TRISA
    RLNCF TRISA	;left shift -> b '10111110'
    MOVLW b'10000000'  
    ANDWF TRISA, W  
    MOVWF 0x00	;save highest bit -> b '10000000'
    RRNCF TRISA	;right shift -> b '01011111'
    MOVLW b'01111111'
    ANDWF TRISA, F
    MOVF 0x00, W
    IORWF TRISA, F
    NOP
    end                   ; ?????


