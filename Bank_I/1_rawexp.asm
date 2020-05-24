; FV-1 Testing
;
; Program: Raw exp
;
; Run a sin LFO and output the EXP value to DACR
;
;	y = 2**(16 * x)
;
; POT0: Offset
; POT1: Level
;

; Prepare LFOs
	skp	RUN,main
	wlds	SIN0,100,32767

main:	rdax	POT0,-1.0	; load POT0 inverted
	sof	-2.0,-1.0	; flip and offset
	wrax	REG0,0.0	; save DC offset and clear acc
	cho	rdal,SIN0	; read from sin LFO
	mulx	POT1		; scale test signal level
	rdax	REG0,1.0	; add the offset amount
	wrax	DACL,1.0	; output x to left channel
	exp	1.0,0.0		; take exponent as S4_6
	wrax	DACR,0.0	; output y=2**(16 * x) to right channel
