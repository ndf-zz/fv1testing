; FV-1 Testing
;
; Program: Read ADDR_PTR
;
;  POT0: Testval
;

	ldax	POT0		; read test value
	wrax	ADDR_PTR,1.0	; write test value to ADDR_PTR
	wrax	DACL,0.0	; write to DACL
	or	0xaaaaaa	; load a bit pattern
	not			; flip the bits
	clr			; and clear
	rdax	ADDR_PTR,1.0	; read back from ADDR_PTR
	wrax	DACR,0.0	; output read value to DACR
