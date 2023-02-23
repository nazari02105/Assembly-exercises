;Ali Nazari 99102401

StSeg   Segment STACK 'STACK'
ns        DB 100H DUP (?)
StSeg   ENDS

DtSeg   Segment
        number DW 0;this is function result
        buffer DB DUP 3 (?);this is for printing function result and is number buffer
        GiveA DB ' Please Give a! $'
        GiveB DB ' Please Give b! $'
        ErrorA DB ' a out of range! $'
        ErrorB DB ' b out of range! $'
        Result DB ' Result is: $'
DtSeg   ENDS

CDSeg   Segment
        ASSUME CS:CDSeg,DS:DtSeg,SS:StSeg
Start:
        MOV AX,DtSeg    ; set DS to point to the data segment
        MOV DS,AX       
        
GetA:
        MOV DX, OFFSET GiveA;to print the sentenct to get a from user
		MOV AH, 9;for syscall
		INT 21h;for syscall        
        MOV AH, 01H
        INT 21H;for syscall
        SUB AL, 48;ascii code of '0' is 48 so to convert character to number, we do this
        MOV AH, 0;user input is in AL so we can easylly put zero to AH
        CMP AL, 0;user input ascii code should not be under 48
        JGE NextA;if it is not under 48 so we can go on
        MOV DX, OFFSET ErrorA;otherwise his/her input is out of range
		MOV AH, 9;for syscall
		INT 21h;for syscall
		JMP GetA;go back to get another input from user
NextA:
        CMP AL, 10;user input ascii code should not be greater than 58
        JB GetB;if it is not greater than 58, we can go on
        MOV DX, OFFSET ErrorA;otherwise his/her input is out of range
		MOV AH, 9;for syscall
		INT 21h;for syscall
		JMP GetA;go back to get another input from user
GetB:
        PUSH AX;push previous user input to stack (a)
        MOV DX, OFFSET GiveB;for sycall
		MOV AH, 9;for syscall
		INT 21h;for syscall
        MOV AH, 01H;for syscall
        INT 21h;read one char
        SUB AL, 48;ascii code of '0' is 48 so to convert character to number, we do this
        MOV AH, 0;user input is in AL so we can easylly put zero to AH
        CMP AL, 0;user input ascii code should not be under 48
        JGE NextB;if it is not under 48 so we can go on
        MOV DX, OFFSET ErrorB;otherwise his/her input is out of range
		MOV AH, 9;for syscall
		INT 21h;for syscall
		JMP GetB;go back to get another input from user
NextB:
        CMP AL, 10;user input ascii code should not be greater than 58
        JB NextStep;if it is not greater than 58, we can go on
        MOV DX, OFFSET ErrorB;otherwise his/her input is out of range
		MOV AH, 9;for syscall
		INT 21h;for syscall
		JMP GetB;go back to get another input from user
NextStep:        
        
        MOV BX, AX;put b in BX
        POP AX;put a in AX
        MUL BX;with mul we put their multiply to
        ;VERY IMPORTANT: Because they are at most 9 so their multiply will be 81 at most so it will be in AX and we dont use DX in this case
        CALL Function
        MOV number, AX;result is in AX and we put it in num to print it
        PUSH AX;save it
        MOV DX, OFFSET Result;print result sentence
		MOV AH, 9;for syscall
		INT 21h;for syscall
        POP AX;back Ax to AX
        CALL PrintInt;Print result
        MOV AH,4CH  ; DOS: terminate program
        MOV AL,0    ; return code will be 0
        INT 21H     ; terminate the program       
        
;n must be in AX
;result in AX
Function PROC NEAR
    CMP AX, 0;if AX is zero we should return 1
    JE One;we should return 1
    CMP AX, 1;if AX is one we should return 2
    JE Two;we should return 2
    PUSH AX;we save main AX
    DEC AX;for calculating f(n-1)
    CALL Function;for calculating f(n-1)
    MOV BX, AX;we have f<n-1) result in AX, so we should save it
    POP AX;restore main number
    PUSH BX;save result of f<n-1) in stack
    DEC AX;calculating f<n-2)
    DEC AX;calculating f<n-2>
    CALL Function;calculating f<n-2>
    POP BX;now we have result of f<n-2> in AX and result of f<n-1> in BX     
    MOV CX, BX;we have result of f<n-1> in CX eather
    PUSH AX;put f<n-2> in stack
    PUSH BX;put f<n-1> in stack
    POP AX;pur f<n-1> in AX
    POP BX;pur f<n-2> in BX
    DIV BL;DIV which put quotient in AL
    MOV AH, 0;it will be absoloutly positive
    ADD AX, CX;quotient(f(n-1),f(n-2)) + f(n-1)
    RET;return from function 
One:;if n is one
    MOV AX, 1;we should return 1
    RET
Two:;if n is two
    MOV AX, 2;we should return 2
    RET    

PrintInt PROC NEAR:
        MOV SI, 0;for printint
        MOV AX, number;put numer to print in AX
MainLoop:
        JMP DivProcess
AfterDiv:
        LEA BX, buffer;buffer to print
        MOV BYTE PTR[BX+SI], DL;put remainder to buffer
        INC SI;increament
        CMP AX, 0;if AX equal to zero it means we should break loop
        JNZ MainLoop;again
PrintLoop:
        DEC SI;point to last character
        LEA BX, buffer;put buffer address in BX
        MOV DL, [BX+SI];move character to print to DL
        MOV AH, 02H;for syscall
        INT 21H;for syscall
        CMP SI, 0;if CX is greater than zero it means we should continue loop
        JNZ PrintLoop;print remaining characters
        RET;otherwise we should finish this function
DivProcess:
        MOV DX, 0;put zero to DX because in div we use DX,AX together but in this question we never use DX because user input is too small
        MOV BX, 10;put 10 for div in BX
        DIV BX;div
        ADD DL, 48;convert int to character
        JMP AfterDiv    
PrintInt ENDP

CDSeg   ENDS
END Start