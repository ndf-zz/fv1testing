; FV-1 Testing
;
; Program: Log powers
;
; Check general powers y = x**n using log:
;
;	log(x**n) = n*log(x)
;
; n is read from pot, and ranges over the values roughly -16->16.
;
; POT0: Power
; POT1: Level
;

; Prepare LFOs
	skp	RUN,main
	wlds	SIN0,100,32767

main:	rdax	POT0,-1.0	; load pot0 inverted
	sof	-2.0,-1.0	; flip and offset
	wrax	REG0,0.0	; save and clear acc
	cho	rdal,SIN0	; load test signal
	mulx	POT1		; scale test signal level
	wrax	DACL,1.0	; write to left output
	wrax	REG1,1.0	; save to reg for sign test
	log	1.0,0.0		; take log(abs(x)), acc is now s4_6
	mulx	REG0		; multiply by power -16 -> 16
	exp	1.0,0.0		; 2**(x*log(y)), acc is back to s_23
	wrax	REG2,0.0	; save intermediate value
	ldax	REG1		; fetch original value
	skp	NEG,negate
	ldax	REG2		; fetch positive value
	skp	0,output
negate:	ldax	REG2		; fetch positive value
	sof	-1.0,0.0	; invert
output:	wrax	DACR,0.0	; output to right channel
