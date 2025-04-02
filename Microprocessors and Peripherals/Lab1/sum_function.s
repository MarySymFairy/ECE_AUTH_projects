.global START
.p2align 2
.type sum_function,%function


START: 
		.fnstart
		PUSH {r4-r6, lr}   		 ;Preserve registers r4, r5, r6, and lr

SUM_FUNCTION:

		MOV r4, r0               ; Move the argument 'hash' to r4
		MOV r5, #0               ; Initialize 'digit' to 0
		MOV r6, #0               ; Initialize 'd' to 0

HASH_LOOP:

        CMP r4, #0           ; Check if hash > 0
        BLE END_HASH_LOOP    ; If hash <= 0, exit the loop

        MOV r3, r4          ; Copy hash to r3 for division and modulo operations
        MOV r1, #10         ; Load divisor (10) into r7
        SDIV r2, r3, r1     ; Calculate hash % 10 (remainder) and store in r2
        ADD r5, r5, r2      ; Add remainder to 'digit'

        SDIV r4, r4, r1     ; Calculate hash / 10 (integer division) and store in r4
        B HASH_LOOP         ; Repeat loop

END_HASH_LOOP:
		B END_RECURSION 	;????

DIGIT_LOOP:

        CMP r5, #0          ; Check if digit > 0
        BLE end_digit_loop  ; If digit <= 0, exit the loop

        MOV r3, r5          ; Copy digit to r3 for division and modulo operations
		; ensure that the dividend (r3) contains the correct value
        MOV r1, #10         ; Load divisor (10) into r7
        SDIV r2, r3, r1     ; Calculate digit % 10 (remainder) and store in r2
        ADD r6, r6, r2      ; Add remainder to 'd'

        SDIV r5, r5, r1     ; Calculate digit / 10 (integer division) and store in r5
        B DIGIT_LOOP        ; Repeat loop

END_DIGIT_LOOP:
								;n --> r0
		CMP r0, #0               ; Check if input 'n' is greater than 0
		BLE END_RECURSION        ; If n <= 0, end recursion
		;mov r6, #0 				;r6-->result
		SUB r0, r0, #1           ; Decrement 'n' by 1
		BL SUM_FUNCTION			 ; Recursive call
		;The bl instruction is used to call the subroutine
		ADD r6, r6, r0           ; Add the result of recursive call
	
END_RECURSION:	

		MOV r0, r6               ; Move the final result to r0
		
		POP {r4-r6, pc}    		 ; Restore
		.fnend