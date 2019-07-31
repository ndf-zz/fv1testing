; FV-1 Testing
;
; Program: DBL Delay Fix
;
; Check the double delay error fix
;
	skp	run,main
	wlds	SIN0,0x100,0x7fff	; test signal in SIN0
main:	ldax	REG0			; load 24bit delayed value
	wrax	REG1,1.0		; keep a copy in a temp reg
	wrax	DACL,0.0		; and output to left channel

	cho	rdal,SIN0		; load test signal
	wrax	REG0,1.0		; store test value in delay register
	wra	0,1.0			; write to delay pos 0
	rda	0,-1.0			; and subtract the 14 bit value
	wra	2,0.0			; write error term to second delay

	rda	1,1.0			; load the delayed sample
	rda	3,1.0			; add on the error term
	rdax	REG1,-1.0		; compare with register delayed val
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
	sof	-2.0,0.0		; x2048
	sof	-2.0,0.0		; x4096
	sof	-2.0,0.0		; x8192
	sof	-2.0,0.0		; x16384
	sof	-2.0,0.0		; x32768
	sof	-2.0,0.0		; x65536
	sof	-2.0,0.0		; x131072
	sof	-2.0,0.0		; x262144
	sof	-2.0,0.0		; x524288
	sof	-2.0,0.0		; x1048576
	wrax	DACR,0.0		; write error term out
	skp	0,end
equal:	or	0x800000		; flag exact comparison
	wrax	DACR,0.0		; write out max value
end:
