.global HASH_CALCULATION
.p2align 2
.type hash_calculation, %function
	
	
	;r0 --> str[0] DIEYTHINSH --> 1 byte each character
	;r1 --> hash_values[0] DIEYTHINSH --> 4 bytes each integer value
	;r2 --> temporary address of hash_values that changes according to my character
	;r3 --> 
	;r4 --> timi tou str[0]
	;r5 --> timi tou hash_values[0]
	;r6 --> hash

	HASH_CALCULATION:
		.fnstart					;function starts here	
		PUSH	{r4-r6, lr}
		MOVS	r6, #0				;int hash = 0    r6 --> hash


	START:
		LDRB	r4, [r0]			;r4 --> str[0] load byte at address r0 into r4		
	
		CMP		r4, #0				
		BEQ		EXIT				; str[i] == '\0'	end of string
		BGT		CHECK_KEF			;branch & start the comparisons
	
	
	CHECK_KEF:		;KEFALAIO [65-90]
		CMP		r4, #65				;'A'
		BLT		CHECK_PSIFIO
		CMP		r4, #90				;'Z'
		BGT		CHECK_MIKRO
		
		SUB		r4, r4, #65			; find the i-th integer of the hash_values array
		MOVS	r2, r1				; copy the contents (dld. address of hash_values[0])
		MUL		r2, r4, #4			; integers --> every 4 bytes
		ADD		r2, r2, r1
		LDR		r5, [r2]			; load MY element of hash_values    !!! LDRB
		
		ADD		r6, r6, r5			;hash
		
		ADD		r0, r0, #1			;go to the next character	
		B		START

	CHECK_MIKRO:	;MIKRO [97-122]
	;already checked that r2>90
		CMP		r4, #97				;'a'
		BLT		NEXT
		CMP 	r4, #122			;'z'
		BGT		NEXT
				
		SUB		r4, r4, #97			; find the i-th integer of the hash_values array
		MOVS	r2, r1				; copy the contents (dld. address of hash_values[0])
		MUL		r2, r4, #4			; integers --> every 4 bytes
		ADD		r2, r2, r1
		LDR		r5, [r2]			; load MY element of hash_values 
		
		SUB		r6, r6, r5			;hash
		
		ADD		r0, r0, #1			;go to the next character	
		B		START
		

	CHECK_PSIFIO:	
	;already checked that r2<65
		CMP		r4, #48				;'0'
		BLT		NEXT
		CMP		r4, #57				;'9'
		BGE		NEXT 
		
		SUB		r4, r4, #48
		ADD		r6, r6, r4			;hash
		
		ADD		r0, r0, #1			;go to the next character	
		B		START
	
	NEXT:
		ADD		r0, r0, #1			;go to the next value of str array
		B		START
	
	EXIT:	
		;......pos epistrefo timi stin main??
		MOVS	r0, r6
		;STR		r6, ....
		
		POP		{r4-r6, pc}			;free the registers
		.fnend						;function ends here