;Bubble Sort Program for LC-3 Assembly
;Input : Sorts 8 user-input numbers ranging from 0-100
;Output: Display sorted values in ascending order in console

.ORIG x3000

;Constants and Memory Locations
;We can always move this to the bottom? Dont have everything we might need here
ARRAY		.BLKW 8					;Array to hold input numbers
PROMPT		.STRINGZ "Enter 8 numbers (0-100): "
OUTPUT_MSG	.STRINGZ "Sorted numbers: "

; Main Program
START
        LEA R0, PROMPT             ; Load address of PROMPT
        PUTS                       ; Display the prompt message
        JSR INPUT_NUMBERS          ; Input numbers from user
        JSR BUBBLE_SORT            ; Sort numbers
        LEA R0, OUTPUT_MSG         ; Load address of OUTPUT_MSG
        PUTS                       ; Display the output message
        JSR DISPLAY_NUMBERS        ; Display sorted numbers
        HALT                       ; Halt the program

;Subroutine: Input numbers
INPUT_NUMBERS
	LEA R1, ARRAY              ; Load base address of ARRAY
        LD R2, NUM_EIGHT           ; Load the number 8
        AND R3, R3, #0             ; Clear R3 (counter)

INPUT_LOOP
	JSR GET_NUM                ; Get a number from the user
        STR R0, R1, #0             ; Store the number in the array
        ADD R1, R1, #1             ; Move to the next array element
        ADD R3, R3, #1             ; Increment the counter
        NOT R4, R2
        ADD R4, R4, R3
        BRnp INPUT_LOOP            ; Repeat until 8 numbers are input
        RET

;Subroutine: Get a number from the user
GET_NUM
	AND R0, R0, #0			;CLEAR R0
	AND R1, R1, #0			;CLEAR R1
	AND R2, R2, #0			;CLEAR R2 (COUNTER)

READ_DIGIT
	GETC                       ; Get a character from keyboard
        OUT                        ; Echo the character
        LD R1, ASCII_OFFSET        ; Load ASCII offset
        ADD R0, R0, R1             ; Convert ASCII to integer
	BRz DONE_READING	   ;IF INPUT IS ENTER, END INPUT
	ADD R2, R2, #1		   ;INCREMENT DIGIT COUNTER
        BRnzp READ_DIGIT	   ;READ NEXT DIGIT

DONE_READING
	JSR CHECK_VALUE            ; Validate the number
	RET

;Subroutine: Check value (validate input)
CHECK_VALUE
	BRn GET_NUM_AGAIN          ; If input is negative, get input again
        LD R1, MAX_VALUE	;CHECK IF NUMBER IS LESS THAN OR EQUAL TO 100
        NOT R1, R1
        ADD R1, R1, R0
        BRzp GET_NUM_AGAIN         ; If input is greater than 100, get input again
        RET

GET_NUM_AGAIN
        JSR GET_NUM               ; READS ANOTHER NUMBER IF INVALID
        RET

;Subroutine: Bubble Sort
BUBBLE_SORT
        LEA R1, ARRAY              ; Load base address of ARRAY
        LD R2, NUM_EIGHT           ; Load the number 8 (number of elements)
        ADD R2, R2, #-1            ; Number of passes = n-1
        AND R3, R3, #0             ; Clear R3 (outer loop counter)


SORT_OUTER_LOOP
        NOT R4, R2
        ADD R4, R4, R3
        BRzp SORT_DONE             ; Check if outer loop is done
        LEA R1, ARRAY              ; Reload base address of ARRAY
        LD R5, NUM_EIGHT           ; Load the number 8 (inner loop counter)
        ADD R5, R5, #-1            ; Inner loop = n-1

SORT_INNER_LOOP
        ADD R6, R5, #0             ; Load inner loop counter
        BRz INNER_DONE             ; Check if inner loop is done
        LDR R7, R1, #0             ; Load current element
        LDR R0, R1, #1             ; Load next element
        NOT R7, R7
        ADD R7, R7, R0
        BRzp NO_SWAP               ; If current <= next, no swap
        LDR R0, R1, #0             ; Reload current element
        STR R0, R1, #1             ; Swap elements
        STR R7, R1, #0
NO_SWAP
	ADD R1, R1, #1             ; Move to next element
        ADD R5, R5, #-1            ; Decrement inner loop counter
        BRnzp SORT_INNER_LOOP      ; Repeat inner loop

INNER_DONE
        ADD R3, R3, #1             ; Increment outer loop counter
        BRnzp SORT_OUTER_LOOP      ; Repeat outer loop
SORT_DONE
		RET
		;This can go in sort_outer_loop to tell if no more passes 
		;are available so it finshes this subroutine

;Subroutine: Display Numbers
DISPLAY_NUMBERS
	LEA R1, ARRAY              ; Load base address of ARRAY
        LD R2, NUM_EIGHT           ; Load the number 8
        AND R3, R3, #0             ; Clear R3 (counter)

DISPLAY_LOOP
        LDR R0, R1, #0             ; Load number from array
        JSR PRINT_NUM              ; Print the number
        ADD R1, R1, #1             ; Move to the next array element
        ADD R3, R3, #1             ; Increment the counter
        NOT R4, R2
        ADD R4, R4, R3
        BRnp DISPLAY_LOOP          ; Repeat until all numbers are printed
        RET

;Subroutine: Print number
PRINT_NUM
        LD R1, ASCII_OFFSET        ; Load ASCII offset
        ADD R0, R0, R1             ; Convert to ASCII
        OUT                        ; Output character to console
        RET


;Data
NUM_EIGHT    .FILL 8               ; Constant value 8
ASCII_OFFSET .FILL xFFD0             ; ASCII to Integer conversion offset (-48)
ZERO_ASCII   .FILL x0030	   ;ASCII for '0'
MAX_VALUE    .FILL 100             ; Maximum value 100

.END
