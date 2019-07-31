; FV-1 Testing
;
; Program: LFO Interpol Delay
;
; Interpolate a delay line using a sin lfo
;

	skp	run,main
	wlds	SIN0,0x1c4,0x7fff	; test signal in SIN0
	wlds	SIN1,0x071,0x7fff	; modulation signal in SIN1

main:	cho	rdal,SIN0		; and load the test signal
	wra	0,0.0			; write into delay line
	cho	rda,SIN1,REG|COMPC,0x3fff	; read first half
	cho	rda,SIN1,SIN,0x3fff+1	; add second half
	wrax	DACL,0.0		; output the delayed signal
	cho	rdal,SIN1		; re-load the modulation
	wrax	DACR,0.0		; output to right channel
