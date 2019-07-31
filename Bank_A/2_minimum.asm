; FV-1 Testing
;
; Program: Output Min Val
	clr			; clear ACC
	or	0x800000	; load min value to ACC
	wrax	DACL,0.0	; Write to DACL
