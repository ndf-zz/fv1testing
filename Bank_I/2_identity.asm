; FV-1 Testing
;
; Program: Cancellation
;
; Run a sin LFO and test exp/log cancellation:
;
;	x = 2**log(x)
;
; POT0: DC offset
;

; Prepare LFOs
	skp	RUN,main
	wlds	SIN0,100,32767

main:	rdax	POT0,-1.0	; put a negative DC offset in ACC
	cho	rdal,SIN0	; read from sin LFO
	wrax	DACL,1.0	; output x to left channel
	wrax	REG1,1.0	; save value for sign test
	log	1.0,0.0		; take log(x)
	exp	1.0,0.0		; compute 2**(log(x))
	;; restore sign
	wrax	DACR,0.0	; output to right channel
