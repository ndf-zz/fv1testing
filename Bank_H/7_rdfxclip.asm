; FV-1 Testing
;
; Program: RDFX Clipping
;
; Check where saturation is performed with RDFX
;
; ACC = REG + k(ACC - REG)
;
; POT0: Test Value
;

; Read test value
	ldax	POT0
	wrax	DACR,1.0	; write to debug output
	wrax	REG0,0.0	; save a copy and clear ACC

	or	-0.5		; load up an initial offset
	rdfx	REG0,0.75	; acc = REG + 0.75(-0.5 - REG)
	wrax	DACL,0.0	; output result to DACL
