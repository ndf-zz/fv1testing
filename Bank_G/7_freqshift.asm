; FV-1 Testing
;
; Program: Frequency Shift
;
;  POT0: Frequency Chg
;
; Test frequency shift (example from AN-0001)
;
mem	delay	4096
mem	temp	1

	skp	RUN,main
	wldr	RMP0,16384,4096		; initialise ramp
main:	ldax	ADCL			; read input
	wra	delay,0.0		; save into main delay line
	cho	rda,RMP0,REG|COMPC,delay	; first pointer scaled 1-k
	cho	rda,RMP0,0,delay+1	; add k scaled sample 
	wra	temp,0.0		; write a copy to temp
	cho	rda,RMP0,RPTR2|COMPC,delay	; second pointer scaled 1-k
	cho	rda,RMP0,RPTR2,delay+1	; add k scaled sample
	cho	sof,RMP0,NA|COMPC,0.0	; scale 2nd result scaled 1-xfade
	cho	rda,RMP0,NA,temp	; add 1st result scaled xfade
	wrax	DACL,0.0		; write out final result
	cho	rdal,RMP0		; re-read ramp value
	wrax	DACR,0.0		; output debug value

	ldax	POT0
	sof	1.0,-0.5		; offset pot to -0.5,0.5
	skp	GEZ,frqpos		; if positive, don't scale
	sof	0.5,0.0			; else reduce for -0.25 min
frqpos:	wrax	RMP0_RATE,0.0		; write rate into pot
