; FV-1 Testing
;
; Program: Delay Line Error
;
; Check the 14bit error
;
	skp	run,main
	wlds	SIN0,0x100,0x7fff	; test signal in SIN0
main:	cho	rdal,SIN0		; load test signal
	wrax	DACL,1.0		; output to DACL
	wra	0,1.0			; write to delay 
	rda	0,-1.0			; and subtract the 14 bit value
	skp	ZRO,equal		; if same value, flag error
	absa				; fetch absolute value
	sof	-2.0,0.0		; x2
	sof	-2.0,0.0		; x4
	sof	-2.0,0.0		; x8
	sof	-2.0,0.0		; x16
	sof	-2.0,0.0		; x32
	sof	-2.0,0.0		; x64
	sof	-2.0,0.0		; x128
	sof	-2.0,0.0		; x256
	sof	-2.0,0.0		; x512
	sof	-2.0,0.0		; x1024
	wrax	DACR,0.0		; write error term out
	skp	0,end
equal:	or	0x800000		; flag exact comparisons
	wrax	DACR,0.0		; write out max value
end:
