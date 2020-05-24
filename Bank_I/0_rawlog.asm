; FV-1 Testing
;
; Program: Raw log
;
; Run a sin LFO and output the LOG value to DACR
;
;	y ~= 1/16 * log(abs(x))
;
; POT0: DC offset
;

; Prepare LFOs
	skp	RUN,main
	wlds	SIN0,100,32767

main:	ldax	POT0		; add a DC offset in ACC
	cho	rdal,SIN0	; read from sin LFO
	wrax	DACL,1.0	; output x to left channel
	log	1.0,0.0		; take log, ACC is S4_6
	wrax	DACR,0.0	; output y=log(x)/16 to right channel
