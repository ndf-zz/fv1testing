; FV-1 Testing
;
; Program: ACC Persistence
;
; Expected output if ACC persists:
;       - first sample output should be MIN
;       - all following samples should be MAX

equ     maxval  0x7fffff
equ     minval  0x800000
equ     max     REG0
equ     min     REG1

        skp     RUN,main
        clr
        or      maxval          ; load maximum flag value
        wrax    MAX,0.0
        or      minval          ; load minimum flag value
        wrax    MIN,1.0         ; ACC is now min
main:
	wrax	DACL,0.0	; write out ACC and clear
	LDAX	MAX		; ACC is now max
