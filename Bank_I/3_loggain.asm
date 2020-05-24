; FV-1 Testing
;
; Program: Log Gain
;
; Test variable gain using log:
;
;	log(xy) = log(x) + gain
;
; gain is replaced with an offset read from POT0 which
; represents a real S4_6 value from -16 to +15.999, for
; a gain range of roughly 0.00001 to 65535.
;
; POT0: Gain
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
	rdax	REG0,1.0	; add scale as log(y), acc:-16->16
	exp	1.0,0.0		; 2**(log(x)+log(y)), acc is back to s_23
	wrax	REG2,0.0	; save intermediate value
	ldax	REG1		; fetch original value
	skp	NEG,negate
	ldax	REG2		; fetch positive value
	skp	0,output
negate:	ldax	REG2		; fetch positive value
	sof	-1.0,0.0	; invert
output:	wrax	DACR,0.0	; output to right channel
