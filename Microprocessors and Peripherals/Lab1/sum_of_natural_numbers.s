.global START
.p2align 2
.type sum_of_natural_numbers, %function
	
	START:
		.fnstart				;shows where the function starts
		
		;r0 --> n
		;r1 --> result
		
		MOVS	r1, #0			;int result = 0
		
		CMP		r0, #0			;if (n>0)
		BEQ		CONTINUE
		BGT		CALCULATE_SUM
		
	CALCULATE_SUM:
		;result = n + sum_of_natural_numbers(n-1)
		PUSH	{r0, }
		
		CMP		r0, #0
		BEQ		CONTINUE
		
		
		SUB		r0, r0, #1			; n-1
		B		SUM					;loop
		
	CONTINUE:
		;return result
		POP		{...
		
		ADD		r1, ....
		B 		CONTINUE
		
	LAST:
		;return result
		
		.fnend				;shows where the function ends
		
		;SDIV --> SDIV {destination}, {operand1}, {operand2}
