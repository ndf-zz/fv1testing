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
; POT1: Level
;

; Prepare LFOs
	skp	RUN,main
	wlds	SIN0,100,32767

main:	rdax	POT0,-1.0	; load pot0 inverted
	sof	-2.0,-1.0	; flip and offset
	wrax	REG0,0.0	; save DC offset
	cho	rdal,SIN0	; load SIN LFO
	mulx	POT1		; scale test signal
	rdax	REG0,1.0	; add the offset
	wrax	DACL,1.0	; write to left output
	wrax	REG0,1.0	; save input signal
	log	0.5,0.0		; take 0.5*log(abs(x)), acc is now s4_6
	exp	1.0,0.0		; 2**..., acc is back to s_23
	wrax	REG1,0.0	; save intermediate value
	ldax	REG0		; fetch original value
	skp	NEG,negate
	ldax	REG1		; fetch positive value
	skp	0,output
negate:	ldax	REG1		; fetch positive value
	sof	-1.0,0.0	; invert
output:	wrax	DACR,0.0	; output to right channel
