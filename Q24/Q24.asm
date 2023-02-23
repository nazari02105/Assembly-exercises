;working with files in 8086 assembly language
StSeg   Segment STACK 'STACK'
ns        DB 100H DUP (?)
StSeg   ENDS

DtSeg   Segment
        input DB '1.txt', 0
        inStuffs DW 0
        output DB '2.txt', 0
        outStuffs DW 0
        buffer DB ?
        one DW 1
DtSeg   ENDS

CDSeg   Segment
        ASSUME CS:CDSeg,DS:DtSeg,SS:StSeg
Start:
        MOV AX,DtSeg    ; set DS to point to the data segment
        MOV DS,AX        
JMP readFile1	    
charRead:
MOV BX, inStuffs;put input file stuffs in BX for syscall
MOV CX, one
MOV AH, 3FH;for syscall
INT 21H;for syscall
CMP AX, 0;check end of file
JZ finish;if AX is zero, it means input file is finished and we reached EOF
MOV BL, buffer;put buffer in AL        
CMP BL, '/';if this character is '/' we shoud replace it with space otherwise we should put it in output file
JNE write;JNE is jump not equal so if buffer is not '/', we should wrete that character exactly in output file
MOV buffer, ' ';if buffer is '/', then we should replace it with space
write:
MOV BX, outStuffs
LEA DX, buffer
MOV CX, one
MOV AH, 40H;for syscall
INT 21H;for syscall
JMP charRead;next step        
readFile2:
;then we should open output file
MOV AL, 1;for syscall
LEA DX, output;file name
MOV AH, 3dH;for syscall
INT 21H;for syscall
MOV outStuffs, AX;put file stuffs in memory
JMP charRead
readFile1:
;first we should open file
MOV AL, 0;for syscall
LEA DX, input;file name
MOV AH, 3DH;for syscall
INT 21H;for syscall
MOV inStuffs, AX;put file stuffs in memeory
JMP readFile2
finish:
MOV AH,4CH  ; DOS: terminate program
MOV AL,0    ; return code will be 0
INT 21H     ; terminate the program
CDSeg   ENDS
END Start