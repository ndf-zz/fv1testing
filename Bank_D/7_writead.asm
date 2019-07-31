; FV-1 Testing
;
; Program: Write to ADCL
;
;  POT0: Testval
;
	ldax	ADCL		; load ADCL
	wrax	DACL,0.0	; write actual AD to DA
	ldax	POT0		; read test value
	wrax	ADCL,0.0	; write to ADCL
	or	0xaaaaaa	; load a bit pattern
	not			; flip the bits
	clr			; and clear
	rdax	ADCL,1.0	; read back from ADCL
	wrax	DACR,0.0	; output read value to DACR
