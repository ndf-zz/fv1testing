; FV-1 Testing
;
; Program: Sinc FIR Filter
;
; POT0: Feedback
;
; Test FIR filtering with windowed sinc function
; Expect extremely poor performance due to large
; rounding error in rda multiplication coefficient
;
	; apply a 129 tap blackman windowed sinc FIR filter
	; at Fs/8 with taps < 1/2 bit removed

	rda	64,0.250000		; G=0.250000
	rda	70,-0.051194		; G=0.198806
	rda	65,0.224857		; G=0.423663
	rda	58,-0.051194		; G=0.372468
	rda	63,0.224857		; G=0.597325
	rda	69,-0.043916		; G=0.553409
	rda	66,0.158527		; G=0.711936
	rda	59,-0.043916		; G=0.668020
	rda	62,0.158527		; G=0.826547
	rda	71,-0.030630		; G=0.795917
	rda	67,0.074362		; G=0.870279
	rda	57,-0.030630		; G=0.839648
	rda	61,0.074362		; G=0.914010
	rda	78,-0.018692		; G=0.895318
	rda	74,0.028820		; G=0.924138
	rda	50,-0.018692		; G=0.905446
	rda	54,0.028820		; G=0.934266
	rda	77,-0.014627		; G=0.919639
	rda	73,0.023077		; G=0.942716
	rda	51,-0.014627		; G=0.928089
	rda	55,0.023077		; G=0.951166
	rda	79,-0.011979		; G=0.939187
	rda	75,0.018141		; G=0.957328
	rda	49,-0.011979		; G=0.945349
	rda	53,0.018141		; G=0.963489
	rda	86,-0.008844		; G=0.954645
	rda	82,0.012761		; G=0.967406
	rda	42,-0.008844		; G=0.958562
	rda	46,0.012761		; G=0.971322
	rda	85,-0.006852		; G=0.964470
	rda	81,0.009903		; G=0.974373
	rda	43,-0.006852		; G=0.967520
	rda	47,0.009903		; G=0.977423
	rda	87,-0.005706		; G=0.971717
	rda	83,0.008229		; G=0.979946
	rda	41,-0.005706		; G=0.974241
	rda	45,0.008229		; G=0.982469
	rda	34,-0.004144		; G=0.978325
	rda	90,0.006105		; G=0.984430
	rda	94,-0.004144		; G=0.980286
	rda	38,0.006105		; G=0.986391
	rda	93,-0.003235		; G=0.983156
	rda	89,0.004741		; G=0.987897
	rda	35,-0.003235		; G=0.984662
	rda	39,0.004741		; G=0.989403
	rda	95,-0.002650		; G=0.986753
	rda	91,0.003926		; G=0.990679
	rda	33,-0.002650		; G=0.988030
	rda	37,0.003926		; G=0.991955
	rda	102,-0.001745		; G=0.990210
	rda	98,0.002739		; G=0.992949
	rda	26,-0.001745		; G=0.991204
	rda	30,0.002739		; G=0.993942
	rda	101,-0.001387		; G=0.992556
	rda	97,0.002154		; G=0.994710
	rda	27,-0.001387		; G=0.993323
	rda	31,0.002154		; G=0.995478
	rda	103,-0.001095		; G=0.994383
	rda	29,0.001737		; G=0.996120
	rda	25,-0.001095		; G=0.995025
	rda	99,0.001737		; G=0.996762
	rda	106,0.001060		; G=0.997821
	rda	22,0.001060		; G=0.998881

	wrax	DACL,1.0		; save to output
	mulx	POT0
	rdax	ADCL,1.0		; load input from ADCL
	wrax	DACR,1.0		; save a copy to DACR
	wra	0,0.0			; save to delay line input
