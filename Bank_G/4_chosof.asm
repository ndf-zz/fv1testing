; FV-1 Testing
;
; Program: cho sof,... test
;
;  POT0: Frequency
;
; Check the Sin/Cos CHO outputs on SIN LFO
;
	skp	run,main
	wlds	SIN0,0x0,0x7fff		; LFO preparation
main:	or	0x7fffff		; load maxval
	cho	sof,SIN0,SIN|REG,0.0	; fetch sin component and reg
	wrax	DACL,0.0		; output to DACL
	or	0x7fffff		; load maxval
	cho	sof,SIN0,COS,0.0	; fetch cos component
	wrax	DACR,0.0		; output to DACR

	ldax	POT0			; fetch freq control
	wrax	SIN0_RATE,0.0		; save to LFO rate
