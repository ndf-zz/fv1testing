; FV-1 Testing
;
; Program: RDAX Clipping
;
; Check where saturation is performed with RDAX (multiply and accumulate)
;
; ACC = k*REG + ACC
;
; POT0: Test Value
;

; Read test value
	ldax	POT0
	wrax	DACR,1.0	; write to debug output
	wrax	REG0,0.0	; save a copy and clear ACC
	or	0.5		; load up an initial offset
	rdax	REG0,-2.0	; subtract test value
	wrax	DACL,0.0	; output result to DACL

