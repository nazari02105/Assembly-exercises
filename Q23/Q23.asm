StSeg   Segment STACK 'STACK'
ns        DB 100H DUP (?)
StSeg   ENDS

DtSeg   Segment
        num DW 0      ; We read number here
        num_buffer DB DUP 7 (?)
        error_r_gt_n DB 'n must be less than or equal to r!$'
DtSeg   ENDS

CDSeg   Segment
        ASSUME CS:CDSeg,DS:DtSeg,SS:StSeg
Start:
        MOV AX,DtSeg    ; set DS to point to the data segment
        MOV DS,AX
        
        CALL READ_INPUT ; Read n
        MOV AX, num
        PUSH AX ; Save in stack
        CALL READ_INPUT ; Read r
        MOV BX, num
        POP AX ; Restore n in AL
        MOV AH, BL ; Save r in AH
        ; Check r > n
        CMP AH, AL
        JL CALCULATE_COMBINATION
        MOV DX, offset error_r_gt_n
		MOV AH, 9
		INT 21h      
		MOV AH,4CH  ; DOS: terminate program
        MOV AL,0    ; return code will be 0
        INT 21H     ; terminate the program
         
        
CALCULATE_COMBINATION:
        CALL COMBINATION
        MOV num, AX
        CALL WRITE_NUM ; Print result

        MOV AH,4CH  ; DOS: terminate program
        MOV AL,0    ; return code will be 0
        INT 21H     ; terminate the program
; This function will calcaulate the C(n,r) recursivly
; n must be in AL and r must be in AH
; The result will be returned in AX
COMBINATION PROC NEAR
    ; Check if r is zero or equal to n
    CMP AH, 0
    JE COMBINATION_RETURN_ONE
    CMP AH, AL
    JE COMBINATION_RETURN_ONE
    ; Recursivly call combination
    PUSH AX ; Make a backup
    DEC AH ; r-1
    DEC AL ; n-1
    CALL COMBINATION
    MOV BX, AX ; Make a backup in BX
    POP AX ; Restore n and r
    PUSH BX ; Save result of C(n-1,r-1)
    DEC AL ; n-1
    CALL COMBINATION
    POP BX ; Restore result of C(n-1,r-1)
    ADD AX, BX ; AX = C(n-1,r-1) + C(n-1,r)
    RET 
    
COMBINATION_RETURN_ONE:
    MOV AX, 1
    RET
READ_INPUT PROC NEAR
        MOV num, 0
READ_INPUT_LOOP:
        MOV AH, 01H
        INT 21H ; Read one char
        CMP AL, 0DH ; Check new line (the end); 0D in ascii = \r
        JE READ_INPUT_RETURN ; The end
        ; Add the char to number
        SUB AL, 48 ; Convert char to number
        MOV BL, AL ; Save the digit
        MOV AX, num ; Move num to register
        MOV DX, 10 ; Set DX to 10 for mult
        MUL DX ; AX *= 10
        MOV BH, 0 ; We can avoid sign extened because this number is positive and between [0-9]
        ADD AX, BX ; Add to number
        MOV num, AX ; Save the num
        JMP READ_INPUT_LOOP
READ_INPUT_RETURN:
        RET
READ_INPUT ENDP
WRITE_NUM PROC NEAR:
        MOV CX, 0 ; Count the characters of the number
        MOV AX, num
        ; At first check negative
        CMP AX, 0
        JGE WRITE_NUM_LOOP
        ; If we have reached here, we must write a (-)
        NEG AX ; So we only work with positive numbers
        PUSH AX ; Make copy
        MOV AH, 02H
        MOV DL, '-'
        INT 21H
        POP AX ; Get back the copy
WRITE_NUM_LOOP:
        MOV DX, 0 ; We are sure this is positive
        MOV BX, 10
        DIV BX
        ; Print the remainder
        ADD DL, '0' ; Convert to char
        LEA BX, num_buffer ; Load the address
        MOV SI, CX
        MOV BYTE PTR[BX+SI], DL ; Save the buffer
        INC CX ; Increase counter
        ; Check the end
        CMP AX, 0
        JNZ WRITE_NUM_LOOP ; We are not done!
WRITE_BUFFER_LOOP:
        DEC CX ; Point to last char
        LEA BX, num_buffer ; Load the address
        MOV SI, CX 
        MOV DL, [BX+SI] ; Move the char to DL
        MOV AH, 02H
        INT 21H ; Print that char
        CMP CX, 0
        JNZ WRITE_BUFFER_LOOP ; Loop to print more rest of chars
        ; Done
        RET
WRITE_NUM ENDP
CDSeg   ENDS
END Start