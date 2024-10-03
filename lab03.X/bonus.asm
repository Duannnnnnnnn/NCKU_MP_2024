List p=18f4520 
#include <p18f4520.inc>
CONFIG OSC = INTIO67
CONFIG WDT = OFF
org 0x00

; ?????
TEMP        EQU 0x03  ; ????????????
RESULT      EQU 0x02  ; ????
NUM_L       EQU 0x01  ; ??
NUM_H       EQU 0x00  ; ??
LOOP_COUNTER EQU 0x10 ; ?????
ONE_CNT     EQU 0x04  ; ???? 1 ???

; ???
CLRF TEMP           ; ?? TEMP
CLRF ONE_CNT        ; ?? ONE_CNT

MOVLW 0x00    
MOVWF NUM_H         ; ???? 0
MOVLW 0x41   
MOVWF NUM_L         ; ???? 0x40 (64)
MOVLW 0x10   
MOVWF RESULT        ; ??? RESULT
    
MOVLW 0x08
MOVWF LOOP_COUNTER

; ????
CheckHigh:
    BTFSC NUM_H, 7    ; ?? NUM_H ????
    GOTO Found
    RLNCF NUM_H, F    ; ?? NUM_H
    INCF TEMP         ; TEMP ? 1
    DECFSZ LOOP_COUNTER, F
    GOTO CheckHigh

; ????
MOVLW 0x08
MOVWF LOOP_COUNTER

CheckLow:
    BTFSC NUM_L, 7    ; ?? NUM_L ????
    GOTO Found
    RLNCF NUM_L, F    ; ?? NUM_L
    INCF TEMP         ; TEMP ? 1
    DECFSZ LOOP_COUNTER, F
    GOTO CheckLow

GOTO Finish

; ?? 1 ???
Found:
    INCF TEMP         ; ??????
    MOVF TEMP, W
    SUBWF RESULT, F   ; ?? RESULT

    ; ?????? 1
    MOVLW 0x08
    MOVWF LOOP_COUNTER
    LOOP1:
        BTFSC NUM_H, 0
        INCF ONE_CNT
        RRNCF NUM_H, F
        DECFSZ LOOP_COUNTER, F
        GOTO LOOP1
    
    ; ?????? 1
    MOVLW 0x08
    MOVWF LOOP_COUNTER
    LOOP2:
        BTFSC NUM_L, 0
        INCF ONE_CNT
        RRNCF NUM_L, F
        DECFSZ LOOP_COUNTER, F
        GOTO LOOP2

    ; ?? ONE_CNT ?? 1????? 1
    INCF ONE_CNT
    MOVLW 0x01
    CPFSGT ONE_CNT
    INCF RESULT, F     ; ????? 1 ? 1???? 1

Finish:
    NOP
    END
