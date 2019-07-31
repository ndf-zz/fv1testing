; FV-1 Testing
;
; Program: Raw LFOs
;
; Output SIN0 on L channel and COS0 on R channel
;
; POT0: RATE    0.5 - 20Hz
; POT2: AMP     0.0 - 1.0
;
; Kf - frequency coefficient ranges over 0-511 (0.0 -> 0.99)
; Ka - amplitude coefficient ranges over 0-32767 (0.0 -> 0.99)

; Prepare LFOs
	skp	RUN,main
	wlds	SIN0,0,0

main:

; Read and set rate
	ldax	POT0
	wrax	SIN0_RATE,0.0

; Read and set sin amplitude
	ldax	POT2
	wrax	SIN0_RANGE,0.0

; Output the lfos directly to DAC
	cho	rdal,SIN0
	wrax	DACL,0.0
	;cho	rdal,SIN0,COS|REG	; asfv1 only
	raw	0xc3000014		; assembled form
	wrax	DACR,0.0
end:
