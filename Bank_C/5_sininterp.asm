; FV-1 Testing
;
; Program: Sin interpolation
;
; Output SIN0 inerpolation coefficients on each channel
;
; POT0: RATE 0  0.5 - 20Hz
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

; Read and set amplitude
	ldax	POT2
	wrax	SIN0_RANGE,1.0

; Output the lfo interpolation coefficients
	or	0x7fffff		; Load max val
	cho	sof,SIN0,SIN|REG|COMPC,0.0	; Multiply by 1-k & store REG
	wrax	DACL,0.0		; write to DACL and clear ACC
	or	0x7fffff		; Load max val
	cho	sof,SIN0,SIN,0.0	; Multiply by k
	wrax	DACR,0.0		; Write to DACR and clear ACC

end:
