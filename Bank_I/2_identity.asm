; FV-1 Testing
;
; Program: Cancellation
;
; Run a sin LFO and test exp/log cancellation:
;
;	x = 2**log(x)
;
; POT0: Offset
; POT1: Level
;

; Prepare LFOs
	skp	RUN,main
	wlds	SIN0,100,32767

main:	rdax	POT0,-1.0	; load POT0 inverted
	sof	-2.0,-1.0	; flip and invert
	wrax	REG0,0.0	; save DC offset and clear acc
	cho	rdal,SIN0	; read from sin LFO
	mulx	POT1		; scale test signal level
	rdax	REG0,1.0	; add the offset amount
	wrax	REG0,1.0	; save value for sign test
	wrax	DACL,1.0	; output x to left channel
	log	1.0,0.0		; take log(x)
	exp	1.0,0.0		; compute 2**(log(x))
	wrax	REG1,0.0	; save result
	ldax	REG0		; load the original value
	skp	NEG,negate
	ldax	REG1		; fetch positive result
	skp	0,output
negate:	ldax	REG1		; fetch positive result
	sof	-1.0,0.0	; invert
output:	wrax	DACR,0.0	; output to right channel
