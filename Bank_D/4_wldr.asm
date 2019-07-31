; FV-1 Testing
;
; Program: Invalid WLDR
;
; Check RMP with freq < -16384
;

	skp	RUN,main
	wldr	RMP1,-16384,3	; valid
	raw	0x50000072	; invalid:	wldr RMP0,-32768,3

main:	clr
	or	0x7fffff	; load max val
	cho	sof,RMP0,REG|NA,0.0	; multiply by RAMP
	wrax	DACL,0.0	; output to DACL
	or	0x7fffff	; load max val
	cho	sof,RMP1,REG|NA,0.0	; multiply by RAMP
	wrax	DACR,0.0	; output to DACR
