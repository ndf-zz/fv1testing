; FV-1 Testing
;
; Program: Output Max Val
	clr			; clear ACC
	or	0x7fffff	; load max value to ACC
	wrax	DACL,0.0	; Write to DACL
