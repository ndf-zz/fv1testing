; FV-1 Testing
;
; Program: RMP interpolation
;
; Direct output RMP0 XFADE on L channel and write C to R channel
;
; POT0 : RATE 0  -0.5 -> 1.0
; POT1 : AMP     -1.0 -> -1.0
;
; C - frequency coefficient ranges over -16384 to 32767 (-0.5 -> 0.99)
; A - amplitude coefficient ranges over 0,1,2,3 (? really?)

; Prepare LFOs
	skp	RUN,main
	wldr	RMP0,0,0
main:

; Read and set rate
	sof	1.0,-0.5	; set negative start point
	rdax	POT0,1.5	; load control, scale and add
	wrax	RMP0_RATE,1.0	; write rate into ramp
	wrax	DACR,0.0	; and output on DACR

; Read and set amplitude
	sof	1.0,0.5		; load a positive offset
	rdax	POT1,-1.0	; subtract POT1
	sof	-2.0,0.0	; invert and scale to full range
	wrax	RMP0_RANGE,0.0

; Output the lfo interpolation coefficients
	or	0x7fffff	; load max val into ACC
	cho	sof,RMP0,COMPC|REG,0.0	; scale ACC by 1-k
	wrax	DACL,0.0	; write to DACL
	or	0x7fffff	; load max val into ACC
	cho	sof,RMP0,0,0.0	; scale ACC by k 
	wrax	DACR,0.0	; write to DACR

end:
