; FV-1 Testing
;
; Program: DF-I 2,3 Register
;
; Direct-Form I 2nd and 3rd order filters using registers
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

; 2nd Order delays
equ	tmp	REG0
equ	z2a1	REG1
equ	z2a2	REG2
equ	z2b1	REG3
equ	z2b2	REG4

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

; 3rd Order delays
equ	z3a1	REG5
equ	z3a2	REG6
equ	z3a3	REG7
equ	z3b1	REG8
equ	z3b2	REG9
equ	z3b3	REG10

	; measure mix pot, invert and offset
	sof	1.0,0x3ff
	rdax	POT0,-1.0
	wrax	REG11,1.0

	; second-order DF-I on delay lines
	ldax	ADCL		; load left input
	wrax	DACR,f2b0	; copy input to output and scale by b0
	rdax	z2b1,f2b1	; accumulate b1
	rdax	z2b2,f2b2	; accumulate b2
	rdax	z2a1,-f2a1	; accumulate -a1
	rdax	z2a2,-f2a2	; accumulate -a2
	wrax	tmp,1.0		; save result
	mulx	REG11
	wrax	REG11,0.0	; save output

	; shift delays
	ldax	z2b1
	wrax	z2b2,0.0	; z2b2=z2b1
	ldax	ADCL		; re-load input
	wrax	z2b1,0.0
	ldax	z2a1
	wrax	z2a2,0.0	; z2a2=z2a1
	ldax	tmp
	wrax	z2a1,0.0	; z2a1=y

	; third-order DF-I on delay lines
	rdax	ADCL,f2b0
	rdax	z3b1,f3b1
	rdax	z3b2,f3b2
	rdax	z3b3,f3b3
	rdax	z3a1,-f3a11
	rdax	z3a2,-f3a2
	rdax	z3a1,-f3a12
	rdax	z3a3,-f3a3	; y
	wrax	tmp,1.0		; save result

	; shift delays
	ldax	z3b2
	wrax	z3b3,0.0
	ldax	z3b1
	wrax	z3b2,0.0
	ldax	ADCL
	wrax	z3b1,0.0
	ldax	z3a2
	wrax	z3a3,0.0
	ldax	z3a1
	wrax	z3a2,0.0
	ldax	tmp
	wrax	z3a1,1.0	; y

	mulx	POT0		; scale 3rd ord output
	rdax	REG11,1.0	; add on 2nd ord
	wrax	DACL,0.0	; output left
