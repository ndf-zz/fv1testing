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
; POT1:	Level
; POT2: Offset
;

; Prepare LFOs
	skp	RUN,main
	wlds	SIN0,100,32767

; Load divisor, save sign and compute log(y)
main:	rdax	POT0,-1.0	; load pot0 inverted
	sof	-2.0,-1.0	; flip and offset
	wrax	REG0,1.0	; save divisor sign
	log	-1.0,0.0	; compute -log(y)
	wrax	REG1,0.0	; save log divisor

; Load dividend, save sign and compute log(x)
	rdax	POT2,-1.0	; load pot2 inverted
	sof	-2.0,-1.0	; flip and offset
	wrax	REG2,0.0	; save input offset
	cho	rdal,SIN0	; load sin LFO
	mulx	POT1		; scale test signal
	rdax	REG2,1.0	; add offset
	wrax	REG2,1.0	; save dividend sign
	wrax	DACL,1.0	; write to left output
	log	1.0,0.0		; compute log(x)

; Add logs, extract magnitude of x/y and then restore sign
	rdax	REG1,1.0	; add the divisor
	exp	1.0,0.0		; 2**(log(x)-log(y))
	wrax	REG3,0.0	; save magnitude 
	ldax	REG2		; re-load dividend
	ldax	REG1		; re-load divisor
	skp	ZRC,negate	; if sign differs, negate output
	ldax	REG3		; fetch positive result
	skp	0,output
negate:	ldax	REG3		; fetch positive result
	sof	-1.0,0.0	; negate result
output:	wrax	DACR,0.0	; output to right channel
