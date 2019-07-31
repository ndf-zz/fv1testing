; FV-1 Testing
;
; Program: SOF Clipping
;
; Check where saturation is performed on SOF command
;
; POT0: Test Value
;
; ACC = k*ACC + c
;
; If clipping happens on (k*ACC) before adding c, output
; should be totally negative. If the guard bits are retained
; until after c is added, then the output should go positive
;

; Read test value
	or	0.25		; load up a starting offset
	rdax	POT0,-1.0	; subtract test value
	wrax	DACR,1.0	; write to debug output
	sof	-2.0,-1.0	; scale by -2 and offset to recover
	wrax	DACL,0.0	; output result to DACL

