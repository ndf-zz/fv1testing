; FV-1 Testing
;
; Program: ACC Init Val
;
;	note: also writes into delay for use with program 7
;
; Expected output: 0.0

	skp	RUN,output
	wrax	REG1,0.0	; store ACC init value

output:	ldax	REG1
	wrax	DACL,0.0

; Copy ADCL into delay memory for program 7
	or	0x800000	; load -1.0
	wra	0,1.0		; save to delay start
	not			; invert
	wra	0x3fff,1.0	; save to delay middle, and keep ACC
