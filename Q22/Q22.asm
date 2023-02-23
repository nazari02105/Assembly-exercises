;in one word and just one time
StSeg   Segment STACK 'STACK'
ns        DB 100H DUP (?)
StSeg   ENDS

DtSeg   Segment
        all DB 26 DUP (0)
        zero DW 0
        zero8 DB 0
        two DB 2
DtSeg   ENDS

CDSeg   Segment
        ASSUME CS:CDSeg,DS:DtSeg,SS:StSeg
Start:
        MOV AX,DtSeg    ; set DS to point to the data segment
        MOV DS,AX
  
MOV CX, zero;counter:
LEA SI, all
getCharLoop:
MOV AH, 01H;for syscall
INT 21H;for syscall
CMP AL, 0DH;like question 1 we should check for user enter which is equal to \r and \r ascii code is 13 and 13 in hex is 0D
JE allArrayLoop;if user input is equal to \r, we should finish getting char
JMP addToArray
allArrayLoop: 
MOV AL, [SI];move index of all array to AL
INC SI;increment to move in all array
CMP AL,1;check if we saw this character once or more
JZ print;if it is not 1 then we should not  print it
INC CX
CMP CX, 28;because size of "all" array is 28 and we should not go farther
JNE allArrayLoop;if CX is greater than 28 then we3 should finish loop
JMP end
print:
MOV DL, CL;for syscall
ADD DL, 97;convert int to char
MOV AL, zero8;for syscall
MOV AH, two;for syscall
INT 21H;for syscall
INC CX
CMP CX, 28;because size of "all" array is 28 and we should not go farther
JNE allArrayLoop;if CX is greater than 28 then we3 should finish loop                      
end:
MOV AH,4CH  ; DOS: terminate program
MOV AL,zero8    ; return code will be 0
INT 21H     ; terminate the program
addToArray:
OR AL, 32;difference between lowercase and uppercase alphabet is 32 which is 20 in hex so we convert all to lowercase
SUB AL, 97;to convert it to "all" array index which was declared in data segment
MOV BL, AL
MOV BH, zero8;because we know it is positive
MOV AL, [BX][SI];find answer of that character I mean counter of that character
INC AL
MOV [BX][SI], AL;put it in main array
JMP getCharLoop         
CDSeg   ENDS
END Start