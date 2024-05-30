;Bubble Sort Program for LC-3 Assembly
;Input : Sorts 8 user-input numbers ranging from 0-100
;Output: Display sorted values in ascending order in console

.ORIG x3000

;Constants and Memory Locations
;We can always move this to the bottom? Dont have everything we might need here
ARRAY		.BLKW 8					;Array to hold input numbers
PROMPT		.STRINGZ "Enter 8 numbers (0-100): "
OUTPUT_MSG	.STRINGZ "Sorted numbers: "

;Subroutine: Input numbers
INPUT_NUMBERS
		;Here we can load/display prompt message
		;Load number of inputs& address of array & initialize counter

INPUT_LOOP
		;Get the number from the user here & store in array
		;Use bottom subroutine GET_NUM to get the number from user
		;Move on to the next array element & increment counter?
		;Repeat loop until user inputed 8 elements

;Subroutine: Get a number from the user
GET_NUM
		;Read characters from keyboard & output to console
		;Convert to ASCII
		;Branch to check validity

CHECK_VALUE
		;Check if input is between 0 and 100
		;If negative get input again
		;Another subroutine in case number is not valid
		;check if within 100 limit

GET_NUM_AGAIN
		;Reads another character if it doesn't pass validity check

;Subroutine: Bubble Sort
BUBBLE_SORT
		;Load number of elements & number of passes

SORT_OUTER_LOOP
		;Check if number of passes is done
		;Load array address & number of elements
		;number of passes required is equal to number of elements
		;in the list minus one (n-1)

SORT_INNER_LOOP
		;Check if inner loop is done
		;do the sort here
		;this is where you load variables and compare them to each other
		;using another branch
		;if the first number is less than the second, no swap
		;Maybe BRzp ?

NO_SWAP
		;Decrement inner loop counter & Repeat inner loop 

INNER_DONE
		;This one can go in sort_inner_loop and can tell you if no 
		;swaps so its done.
		;decrement outer loop counter here & repeat it

SORT_DONE
		RET
		;This can go in sort_outer_loop to tell if no more passes 
		;are available so it finshes this subroutine

;Subroutine: Display Numbers
DISPLAY_NUMBERS
		;Load output message and display it
		;Load address of array and number of elements

DISPLAY_LOOP
		;print numbers from array using this branch & decrement counter to repeat
		;for all elements

;Subroutine: Print number
PRINT_NUM
		;Convert to ASCII & Output character to console

;Main Program
START
		;Input numbers from user 
		;Sort numbers
		;Display sorted number
		HALT		;halt the program

;Data (where we can put the info from the top instead).
		