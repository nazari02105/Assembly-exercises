StSeg   Segment STACK 'STACK'
ns        DB 100H DUP (?)
StSeg   ENDS

DtSeg   Segment
        sign DB 0;for kiping sign flag
        buffer DB DUP 7 (?)
        number DW 0;this is main number
        temp DW 0;temp word
DtSeg   ENDS

CDSeg   Segment
        ASSUME CS:CDSeg,DS:DtSeg,SS:StSeg
Start:
        MOV AX,DtSeg    ; set DS to point to the data segment
        MOV DS,AX
        
        CALL getInt
        CALL printInt
        

        MOV AH,4CH  ; DOS: terminate program
        MOV AL,0    ; return code will be 0
        INT 21H     ; terminate the program
        
printInt PROC NEAR:
MOV CX, 0;counter
MOV AX, number
CMP AX, 0;if number is grater than or equal to 0, it means we should not print '-' before number
JGE printCharLoop
JMP printDash
printCharLoop:
MOV DX, 0
MOV BX, 10;for div
DIV BX;fiv
;now we should print remainder
ADD DL, '0';we converted from char to int by subtracting '0' and now for converting int to char for printing, we should add '0'
;I used teacher PDF for this section and using buffer
LEA BX, buffer
MOV SI, CX
MOV BYTE PTR[BX+SI], DL
INC CX
;we are divinding AX by 10 so when AX is equal to zero, it means we should break loop
CMP AX, 0
JNZ printCharLoop
bufferLoop:
DEC CX;everytime we should move backward on string
;I user teachre PDF here too
LEA BX, buffer
MOV SI, CX 
MOV DL, [BX+SI]
MOV AH, 02H;for syscall
INT 21H;for syscall
CMP CX, 0;we should check if CX is equal to zero we should break loop
JNZ bufferLoop
RET
printDash:
NEG AX;NEG number because we put '-' seperately
MOV temp, AX
MOV AH, 02H;for syscall
MOV DL, '-';for syscall and it is character which we want to print
INT 21H;for syscall
MOV AX, temp
JMP printCharLoop
printInt ENDP
        
getInt PROC NEAR
getCharLoop:
MOV DX, 10;we use this for mul
MOV AH, 01H;for syscall
INT 21H;for syscall
CMP AL, '-';compare input with '-' to check if nubmer is negative or not
JE itIsNegative
CMP AL, 0DH;if user hit enter it will convert to \r and its ascii code is 13 so we compare it with 0D which is 13 in hexadecimal
JE finish
JMP addToNumber
itIsNegative:
MOV sign, 1;we should update sign flag
JMP getCharLoop
finish:        
;if number is negative we should NEG main number
CMP sign, 0;sign will be 0 or 1
JZ functionEnds;if sign flag is zero, we dont need to NEG main number           
NEG number
functionEnds:
RET
addToNumber:
SUB AL, '0';we can not use char form of numbers so we convert them to int by subtracting them with '0'
MOV BL, AL;put nubmer in another register because mul will change AX value
MOV AX, number
MUL DX;mul
ADD AX, BX;add user input to main number
MOV number, AX;save number in memory
JMP getCharLoop
getInt ENDP

CDSeg   ENDS
END Start
