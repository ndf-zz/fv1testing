; FV-1 Testing
;
; Program: RMP LFO Xfade
;
; Test ramp crossfade between ADCs
;
	skp	run,main
	wldr	RMP0,0x80,4096		; setup ramp LFO
main:	ldax	ADCL			; read left input
	cho	sof,RMP0,NA|REG,0	; scale by xfade and reg lfo
	wrax	REG0,0.0		; save to temp reg
	ldax	ADCR			; read right input
	cho	sof,RMP0,NA|COMPC,0	; scale by 1-xfade
	rdax	REG0,1.0		; add to temp value
	wrax	DACL,0.0		; output 
	cho	rdal,RMP0		; load the ramp
	wrax	DACR,0.0		; and write the debug output
