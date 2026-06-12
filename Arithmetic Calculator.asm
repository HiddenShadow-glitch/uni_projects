.MODEL SMALL
.STACK 100H
.DATA
MENU    DB 0DH,0AH,"=== MULTI NUMBER SYSTEM CALCULATOR (8086) ===",0DH,0AH
        DB "1. ARITHMETIC OPERATIONS",0DH,0AH
        DB "2. BITWISE OPERATIONS",0DH,0AH
        DB "3. EXIT",0DH,0AH
        DB "SELECT: $"
ARITH   DB 0DH,0AH,"1.ADD 2.SUB 3.MUL 4.DIV 5.BACK",0DH,0AH,"$"
BITWISE DB 0DH,0AH,"1.AND 2.OR 3.XOR 4.SHL 5.SHR 6.BACK",0DH,0AH,"$"
MSG1    DB 0DH,0AH,"ENTER FIRST NUMBER: $"
MSG2    DB 0DH,0AH,"ENTER SECOND NUMBER: $"
RESMSG  DB 0DH,0AH,"RESULT: $"
NL      DB 0DH,0AH,"$"
NUM1    DW ?
NUM2    DW ?
RESULT  DW ?
INBUF   DB 6,?,6 DUP(0)

.CODE


; PRINT_NUM: PRINTS AX AS UNSIGNED DECIMAL

PRINT_NUM PROC
    MOV BX,10
    MOV CX,0

DIVIDE_LOOP:
    MOV DX,0
    DIV BX
    PUSH DX
    INC CX
    CMP AX,0
    JNE DIVIDE_LOOP

PRINT_LOOP:
    POP DX
    ADD DL,'0'
    MOV AH,2
    INT 21H
    LOOP PRINT_LOOP

    RET
PRINT_NUM ENDP


; READ_NUM: READS DECIMAL NUMBER, RETURNS IN AX   IF IT IS REMOVED IT WILL ONLY TAKE DIGIT

READ_NUM PROC
    LEA DX,INBUF
    MOV AH,0AH
    INT 21H

    LEA SI,INBUF+2
    MOV AX,0
    MOV BX,10

READ_LOOP:
    MOV CL,[SI]
    CMP CL,0DH
    JE READ_DONE
    CMP CL,'0'
    JB READ_DONE
    CMP CL,'9'
    JA READ_DONE
    SUB CL,'0'
    MUL BX
    MOV CH,0
    ADD AX,CX
    INC SI
    JMP READ_LOOP

READ_DONE:
    RET
READ_NUM ENDP

; =====================================================
MAIN:
    MOV AX,@DATA
    MOV DS,AX

START:
    LEA DX,MENU
    MOV AH,9
    INT 21H
    MOV AH,1
    INT 21H
    CMP AL,'1'
    JE ARITHMETIC_MENU
    CMP AL,'2'
    JE BITWISE_MENU
    CMP AL,'3'
    JE EXIT
    JMP START

; ---------------- ARITHMETIC MENU ----------------
ARITHMETIC_MENU:
    LEA DX,ARITH
    MOV AH,9
    INT 21H
    MOV AH,1
    INT 21H
    CMP AL,'1'
    JE ADD_OP
    CMP AL,'2'
    JE SUB_OP
    CMP AL,'3'
    JE MUL_OP
    CMP AL,'4'
    JE DIV_OP
    CMP AL,'5'
    JE START
    JMP ARITHMETIC_MENU

; ---------------- BITWISE MENU ----------------
BITWISE_MENU:
    LEA DX,BITWISE
    MOV AH,9
    INT 21H
    MOV AH,1
    INT 21H
    CMP AL,'1'
    JE AND_OP
    CMP AL,'2'
    JE OR_OP
    CMP AL,'3'
    JE XOR_OP
    CMP AL,'4'
    JE SHL_OP
    CMP AL,'5'
    JE SHR_OP
    CMP AL,'6'
    JE START
    JMP BITWISE_MENU

; ---------------- INPUT HANDLER ----------------
INPUT_NUMS PROC
    LEA DX,MSG1
    MOV AH,9
    INT 21H
    CALL READ_NUM
    MOV NUM1,AX

    LEA DX,MSG2
    MOV AH,9
    INT 21H
    CALL READ_NUM
    MOV NUM2,AX
    RET
INPUT_NUMS ENDP

; ---------------- ARITHMETIC OPS ----------------
ADD_OP:
    CALL INPUT_NUMS
    MOV AX,NUM1
    ADD AX,NUM2
    MOV RESULT,AX
    JMP SHOW

SUB_OP:
    CALL INPUT_NUMS
    MOV AX,NUM1
    SUB AX,NUM2
    MOV RESULT,AX
    JMP SHOW

MUL_OP:
    CALL INPUT_NUMS
    MOV AX,NUM1
    MOV BX,NUM2
    MUL BX
    MOV RESULT,AX
    JMP SHOW

DIV_OP:
    CALL INPUT_NUMS
    MOV AX,NUM1
    MOV DX,0
    MOV BX,NUM2
    DIV BX
    MOV RESULT,AX
    JMP SHOW

; ---------------- BITWISE OPS ----------------
AND_OP:
    CALL INPUT_NUMS
    MOV AX,NUM1
    AND AX,NUM2
    MOV RESULT,AX
    JMP SHOW

OR_OP:
    CALL INPUT_NUMS
    MOV AX,NUM1
    OR AX,NUM2
    MOV RESULT,AX
    JMP SHOW

XOR_OP:
    CALL INPUT_NUMS
    MOV AX,NUM1
    XOR AX,NUM2
    MOV RESULT,AX
    JMP SHOW

SHL_OP:
    CALL INPUT_NUMS
    MOV AX,NUM1
    SHL AX,1
    MOV RESULT,AX
    JMP SHOW

SHR_OP:
    CALL INPUT_NUMS
    MOV AX,NUM1
    SHR AX,1
    MOV RESULT,AX
    JMP SHOW

; ---------------- DISPLAY RESULT ----------------
SHOW:
    LEA DX,RESMSG
    MOV AH,9
    INT 21H

    MOV AX,RESULT

    CMP AX,0
    JGE POSITIVE        ; JUMP IF POSITIVE OR ZERO

    ; NEGATIVE: PRINT '-' THEN NEGATE
    PUSH AX
    MOV DL,'-'
    MOV AH,2
    INT 21H
    POP AX
    NEG AX              ; FLIP TO POSITIVE

POSITIVE:
    CALL PRINT_NUM

    LEA DX,NL
    MOV AH,9
    INT 21H
    JMP START

EXIT:
    MOV AH,4CH
    INT 21H
END MAIN
