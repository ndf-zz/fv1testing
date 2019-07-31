; FV-1 Testing
;
; Program: Read from DAC
;
;  POT0: Testval
;

	ldax	POT0		; read test value
	wrax	DACL,0.0	; write to DACL
	or	0xaaaaaa	; load a bit pattern
	not			; flip the bits
	clr			; and clear
	rdax	DACL,1.0	; read back from DACL
	wrax	DACR,0.0	; output read value to DACR
