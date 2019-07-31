; FV-1 Testing
;
; Program: REG Init Val
;
; Expected output: 0.0

	skp	RUN,output
	ldax	REG0
	wrax	REG1,0.0	; copy REG0 to REG1
output:	ldax	REG1
	wrax	DACL,0.0	; output stored value

; Make sure acc and pacc have content
	or	0x7fffff	; load 
	not			; invert
