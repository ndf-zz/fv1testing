; FV-1 Testing
;
; Program: Log Division
;
; General division using log:
;
;	log(x/y) = log(x) - log(y)
;
; Note: y is input on POT0 and ranges over -1.0 to 1.0
;
; POT0: Divisor
;

; Prepare LFOs
	skp	RUN,main
	wlds	SIN0,100,32767//128

main:	rdax	POT0,1.0	; load pot0 not inverted
	sof	-2.0,-1.0	; flip and offset
	wrax	REG2,1.0	; save divisor for sign test
	log	-1.0,0.0	; compute -log(y)
	wrax	REG3,0.0	; save intermediate result
	cho	rdal,SIN0	; load test signal, dividend
	wrax	DACL,1.0	; write to left output
	wrax	REG1,1.0	; save to reg for sign test
	log	1.0,0.0		; take log(x), acc is now S4_6
	rdax	REG3,1.0	; add divisor
	exp	1.0,0.0		; 2**(log(x)-log(y))
	wrax	REG4,0.0	; save magnitude 
	ldax	REG1		; re-load dividend
	ldax	REG2		; re-load divisor
	skp	ZRO,negate	; if sign differs, negate output
	ldax	REG4		; fetch positive result
	skp	0,output
negate:	ldax	REG4		; fetch positive result
	sof	-1.0,0.0	; negate result
output:	wrax	DACR,0.0	; output to right channel
