;CIS11
;STUDENT NAMES: VICTORIA AVILA, ELIZABETH GRAJEDA, JESSE MARTINEZ
;GROUP PROJECT: BUBBLE SORT
;DESCRIPTION: LC-3 PROGRAM THAT IMPLEMENTS BUBBLE SORTING ALGORITHM
;TEST PROGRAMS WITH: 11,8,2,17,6,4,3,21
;TEST OUTPUT SHOULD BE: 2,3,4,6,8,11,17,21

.ORIG x3000

LEA R0, PROMPT1			;load prompt1 string
PUTS				;output prompt1 string 2console
LEA R0, PROMPT2			;load prompt2 string
PUTS				;output prompt2 
LEA R3, ARRAY			;address array

LD R1, ASIOFF
LD R4, LPCOUNT			;load loop counter 2 r4

AND R5, R5, #0			;CLEAR R5
ADD R5, R5, R4			;INITIALIZE R5 TO 8


;load loop string&output to user
LOOP
LEA R0, NEWLINE					;\n for spacing
PUTS						;output \n
LEA R0, LOOPMSG					;LOAD STRING MSG THATLL LOOP x8
PUTS						;OUTPUT STRING TO CONSOLE

;clear registers for initialization and maintenance 
AND R0, R0, x0					;clear r0
AND R2, R2, x0					;clear r2

;user input
GETC						;GET FIRST CHARACTER
OUT						;ECHO FIRST CHRACTER
ADD R0, R0, R1					;sub for ascii to integer convrt (TENS PLACE)
ADD R2, R2, R0					;STORE IN R2 (R2 = TENS PLACE)

GETC						;GET SECOND CHARACTER
OUT						;ECHO SECOND CHARACTER
ADD R0, R0, R1					;CONVERT ASCII TO INTEGER (0NES PLACE)
ADD R2, R2, R0					;STORE IN R2 (R2 = COMBINED NUMBER

STR R2, R3, #0					;store combined # to array
ADD R3, R3, #1					;move to nxt array location

;loop decision to cont or not
ADD R5, R5, #-1					;subtact from loop count (total x8)
BRp LOOP					;if ++ is positive cont loop

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Bubble sort implementation
LD R6, LPCOUNT		;Outer loop counter, R6 = 8
OUTER_LOOP
AND R7, R7, #0		;CLEAR INNER LOOP COUNTER, R7 = 0
ADD R7, R7, R6		;INITIALIZE INNER LOOP COUNTER, R7 = R6

LD R3, ARRAY		;LOAD ARRAY BASE ADDRESS INTO R3

INNER_LOOP
LDR R0, R3, #0		;LOAD ELEMENT AT R3 INTO R0
LDR R1, R3, #1		;LOAD NEXT ELEMENT INTO R1

;COMPARE AND SWAP IF NECESSARY
NOT R2, R0		;R2 = -R0
ADD R2, R2, R1		;R2 = R1 - R0
BRzp SKIP_SWAP		;IF R1 >=R0, SKIP SWAP

;SWAP ELEMENTS
STR R1, R3, #0		;STORE R1 AT CURRENT POSITION
STR R0, R3, #1		;STORE R0 AT NEXT POSITION

SKIP_SWAP
ADD R3, R3, #1		;MOVE TO NEXT ELEMENT
ADD R7, R7, #-1		;DECREMENT INNER LOOP COUNTER
BRp INNER_LOOP		;IF R7 > 0, CONTINUE INNER LOOP

ADD R6, R6, #-1		;DECREMENT OUTER LOOP COUNTER
BRp OUTER_LOOP		;IF R6 > 0, CONTINUE OUTER LOOP

;DISPLAY SORTED ARRAY
LEA R0, NEWSORT		;LOAD SORTED MESSAGE
PUTS			;OUTPUT SORTED MESSAGE

LEA R3, ARRAY		;LOAD ARRAY BASE ADDRESS INTO R3
LD R6, LPCOUNT		;LOAD LOOP COUNT INTO R6

PRINT_LOOP
LDR R0, R3, #0		;LOAD ELEMENT INTO R0
JSR PRINT_NUM		;PRINT THE NUMBER
LEA R0, SPACE		;LOAD SPACE CHARACTER
PUTS			;PRINT SPACE

ADD R3, R3, #1		;MOVE TO NEXT ELEMENT
ADD R6, R6, #-1		;DECREMENT LOOP COUNTER
BRp PRINT_LOOP		;IF R6 > 0, CONTINUE LOOP

;halt program
HALT						

;SUBROUTINE TO PRINT NUMBER
PRINT_NUM
;SAVE REGISTERS THAT WILL BE USED
ST R7, SAVE_R7
ST R5, SAVE_R5
ST R6, SAVE_R6

AND R5, R5, #0		;CLEAR R5
ADD R5, R5, R0		;COPY NUMBER TO R5

LD R6, ASCII		;LOAD 48 (ASCII OFFSET FOR DIGITS

DIV_TEN
AND R1, R1, #0		;CLEAR R1
ADD R1, R1, #10		;R1=10
DIV_LOOP
NOT R2, R1		;R2=-10
ADD R2, R2, R5		;R2 = R5 - 10
BRn END_DIV		;IF R2 < 0, END DIVISION
ADD R5, R2, #0		;R5 = R2
ADD R3, R3, #1		;INCREMENT QUOTIENT (TENS PLACE)
BR DIV_LOOP

END_DIV
ADD R0, R3, R6		;CONVERT QUOTIENT TO ASCII
OUT			;OUTPUT QUOTIENT
ADD R0, R5, R6		;CONVERT REMAINDER TO ASCII
OUT			;OUTPUT REMAINDER
RET

;RESTORE REGISTERS
LD R7, SAVE_R7
LD R5, SAVE_R5
LD R6, SAVE_R6
;data for console output;
;;;;;;;;;;;;;;;;;;;;;;;;;
PROMPT1	.STRINGZ "Hello! Please enter 8 numbers between 0-100\n"
PROMPT2	.STRINGZ "For single digits, enter zero in front. (example: 01 instead of 1)\n"
LOOPMSG	.STRINGZ "Enter a number: "
NEWLINE	.STRINGZ "\n"
SPACE	.STRINGZ " " 
;display sorted inputs to user
NEWSORT	.STRINGZ "\nAscending order: "	;save4later-will be used to display bubble sorted user inputs

;data for fixed values;
;;;;;;;;;;;;;;;;;;;;;;;
ASCII 	.FILL #-48		;ascii conversion
ASIOFF	.FILL xFFD0		;offset needed for # conversion
LPCOUNT	.FILL #8		;loop initial value set to 8
ARRAY 	.BLKW #8		;array data set in memory
SAVE_R7        .BLKW #1       ; Storage for R7

SAVE_R5        .BLKW #1       ; Storage for R5

SAVE_R6        .BLKW #1       ; Storage for R6
.END