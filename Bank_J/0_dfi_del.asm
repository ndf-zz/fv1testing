; FV-1 Testing
;
; Program: DF-I 2,3 Delay
;
; Direct-Form I 2nd and 3rd order filters using delay elements.
;
; POT0: Mix 2-3

; 2nd order Butterworth filter fc=0.1
;   [b,a]=butter(2,0.1)
equ	f2b0	2.008336556421124e-02
equ	f2b1	4.016673112842247e-02
equ	f2b2	2.008336556421124e-02
equ	f2a0	1.0
equ	f2a1	-1.561018075800718e+00
equ	f2a2	6.413515380575631e-01

; 2nd Order delay lines
mem	z2a	2
mem	z2b	2

; 3rd order Butterworth filter fc=0.1
;   [b,a]=butter(3,0.1)
equ	f3b0	2.898194633721430e-03
equ	f3b1	8.694583901164290e-03
equ	f3b2	8.694583901164290e-03
equ	f3b3	2.898194633721430e-03
equ	f3a0	1.0
equ	f3a11	-1.0
equ	f3a12	-1.374094743709352e+00
equ	f3a2	1.929355669091215e+00
equ	f3a3	-5.320753683120917e-01

; 3rd Order delay lines
mem	z3a	3
mem	z3b	3

	; measure mix pot, invert and offset
	sof	1.0,0x3ff
	rdax	POT0,-1.0
	wrax	REG0,1.0

	; second-order DF-I on delay lines
	ldax	ADCL		; load left input
	wrax	DACR,1.0	; copy input to output
	wra	z2b,f2b0	; save input to 'b' line and scale by b0
	rda	z2b+1,f2b1	; accumulate b1
	rda	z2b+2,f2b2	; accumulate b2
	rda	z2a+1,-f2a1	; accumulate -a1
	rda	z2a+2,-f2a2	; accumulate -a2
	wra	z2a,1.0		; save output to 'a' line
	mulx	REG0		; scale by pot
	wrax	REG0,0.0	; save

	; third-order DF-I on delay lines
	ldax	ADCL		; load left input
	wra	z3b,f3b0	; save input to 'b' line and scale by b0
	rda	z3b+1,f3b1	; accumulate b1
	rda	z3b+2,f3b2	; accumulate b2
	rda	z3b+3,f3b3	; accumulate b3
	rda	z3a+1,-f3a11	; accumulate -a11
	rda	z3a+2,-f3a2	; accumulate -a2
	rda	z3a+1,-f3a12	; accumulate -a12
	rda	z3a+3,-f3a3	; accumulate -a3
	wra	z3a,1.0		; save output to 'a' line

	mulx	POT0		; scale by mix
	rdax	REG0,1.0	; add 2nd order back in
	wrax	DACL,0.0	; output to left
