; FV-1 Testing
;
; Program: 1/x
;
; Compute the special case 1/x using log:
;
;	log(1/y) =  -log(y)
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
	log	-1.0,0.0	; take -log(abs(x)), acc is now s4_6
	exp	1.0,0.0		; 2**..., acc is back to s_23
	wrax	REG1,0.0	; save intermediate value
	ldax	REG0		; fetch original value
	skp	NEG,invrt	; restore original sign
	rdax	REG1,1.0	; fetch positive value
	skp	0,output
invrt:	rdax	REG1,-1.0	; fetch negative value
output:	wrax	DACR,0.0	; output to right channel
