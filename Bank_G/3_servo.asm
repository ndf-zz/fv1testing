; FV-1 Testing
;
; Program: RMP servo ADC
;
; Check RMP servo following input
;

	skp	RUN,main
	wldr	RMP0,0,4096		; setup RMP0
main:	rdax	ADCL,0.25		; read from left input
	sof	1.0,0.25		; offset input to ramp range
	wrax	REG0,1.0		; save a copy
	sof	1.0,-0.25		; offset
	sof	-2.0,0.0		; scale up
	sof	-2.0,0.0		; scale up
	wrax	DACL,0.0		; output target to DACL

	cho	rdal,RMP0		; load RMP0
	wrax	REG1,1.0		; save a copy
	rdax	REG0,-1.0		; subtract target
	wrax	RMP0_RATE,0.0		; update ramp rate toward target
	ldax	REG1
	sof	1.0,-0.25		; offset
	sof	-2.0,0.0		; scale up
	sof	-2.0,0.0		; scale up
	wrax	DACR,0.0		; output ramp value to DACR
