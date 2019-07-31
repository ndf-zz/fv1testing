; FV-1 Testing
;
; Program: Raw LFOs
;
; Output SIN0 on L channel and RMP0 on R channel
;
; POT0: RATE 0  0.5 - 20Hz
; POT1: RATE 1  0.5 - 20Hz
; POT2: AMP     0.0 - 1.0
;
; Kf - frequency coefficient ranges over 0-511 (0.0 -> 0.99)
; Ka - amplitude coefficient ranges over 0-32767 (0.0 -> 0.99)

; Prepare LFOs
	skp	RUN,main
	wlds	SIN0,0,0
	wldr	RMP0,0,4096

main:

; Read and set rate
	ldax	POT0
	wrax	SIN0_RATE,0.0
	ldax	POT1
	wrax	RMP0_RATE,0.0

; Read and set sin amplitude
	ldax	POT2
	wrax	SIN0_RANGE,0.0

; Output the lfos directly to DAC
	cho	rdal,SIN0
	wrax	DACL,0.0
	cho	rdal,RMP0
	wrax	DACR,0.0

end:
