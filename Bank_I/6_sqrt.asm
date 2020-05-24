; FV-1 Testing
;
; Program: Square root
;
; Determine special case sqrt(x) using log:
;
;	log(sqrt(x)) = 0.5 * log(x)
;
; Note: Since log performs abs(x), the negative signal is
;       incorrect.
;
; POT0: Offset
;

; Prepare LFOs
	skp	RUN,main
	wlds	SIN0,100,32767//128

main:	rdax	POT0,-1.0	; load pot0 inverted
	sof	-2.0,-1.0	; flip and offset
	cho	rdal,SIN0	; load test signal and add to offset
	wrax	DACL,1.0	; write to left output
	log	0.5,0.0		; take 0.5*log(abs(x)), acc is now s4_6
	exp	1.0,0.0		; 2**..., acc is back to s_23
	wrax	REG1,0.0	; save intermediate value
	ldax	REG0		; fetch original value
	skp	NEG,invrt	; restore original sign
	rdax	REG1,1.0	; fetch positive value
	skp	0,output
invrt:	rdax	REG1,-1.0	; fetch negative value
output:	wrax	DACR,0.0	; output to right channel
