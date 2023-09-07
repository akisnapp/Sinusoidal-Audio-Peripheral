; BeepTest.asm
; Sends the value from the switches to the
; tone generator peripheral once per second.

ORG 0

	; Get the switch values
	; IN     Switches
	; Send to the peripheral
	;							OUT    Beep
	; Delay for 1 second
	; Do it again
	
; Loop:	LOAD E
	; OUT Beep
	; CALL Delay
	; LOAD A
	; OUT Beep
	; JUMP Loop
	
; TESTING LOOP

Start:
	IN Switches
	JZERO Start
	; JUMP Loop

; Decrement:
	; LOAD LoopCount
	; ADDI -1
	; STORE LoopCount
Loop:
	LOAD  D
	OUT Beep
	CALL Delay
	CALL Delay

	LOADI 0
	OUT Beep
	CALL Delay

	LOAD D 
	OUT Beep
	CALL Delay
	CALL Delay

	LOADI 0
	OUT Beep
	CALL Delay
	
	LOAD D
	OUT Beep
	CALL Delay
	CALL Delay

	LOADI 0
	OUT Beep
	CALL Delay
	;here 
	LOAD G
	OUT Beep
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	
	LOADI 0
	OUT Beep
	CALL Delay
	
	LOAD Ds 
	OUT Beep
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	; CALL Delay
	; CALL Delay
	; CALL Delay
	; CALL Delay
	; CALL Delay
	; CALL Delay
	;finished
	; LOADI 0
	; OUT Beep
	CALL Delay
	
	LOAD C
	OUT Beep
	CALL Delay
	CALL Delay
	
	LOADI 0
	OUT Beep
	CALL Delay
	
	LOAD B
	OUT Beep
	CALL Delay
	CALL Delay
	
	LOADI 0
	OUT Beep
	CALL Delay
	
	LOAD A
	OUT Beep
	CALL Delay
	CALL Delay
	
	LOADI 0
	OUT Beep
	CALL Delay
	
	LOAD G
	OUT Beep
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	
	LOADI 0
	OUT Beep
	CALL Delay
	
	LOAD D
	OUT Beep
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	; CALL Delay
	; CALL Delay
	; CALL Delay
	; CALL Delay
	; CALL Delay
	; CALL Delay
	
	LOADI 0
	OUT Beep
	
	LOAD C
	OUT Beep
	CALL Delay
	CALL Delay
	
	LOADI 0
	OUT Beep
	CALL Delay
	
	LOAD B
	OUT Beep
	CALL Delay
	CALL Delay
	
	LOADI 0
	OUT Beep
	CALL Delay
	
	LOAD A
	OUT Beep
	CALL Delay
	CALL Delay
	
	LOADI 0
	OUT Beep
	CALL Delay
	
	LOAD G
	OUT Beep
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	
	LOADI 0
	OUT Beep
	CALL Delay
	
	LOAD D
	OUT Beep
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	;CALL Delay
	;CALL Delay
	;CALL Delay
	;CALL Delay
	;CALL Delay
	;CALL Delay
	
	LOAD C
	OUT Beep
	CALL Delay
	CALL Delay
	
	LOADI 0
	OUT Beep
	CALL Delay
	
	LOAD B
	OUT Beep
	CALL Delay
	CALL Delay
	
	LOADI 0
	OUT Beep
	CALL Delay
	
	LOAD C
	OUT Beep
	CALL Delay
	CALL Delay
	
	LOADI 0
	OUT Beep
	CALL Delay
	
	LOAD A
	OUT Beep
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	
	LOADI 0
	OUT Beep
	CALL Delay
	
	LOAD  D
	OUT Beep
	CALL Delay
	CALL Delay

	LOADI 0
	OUT Beep
	CALL Delay

	LOAD D 
	OUT Beep
	CALL Delay
	CALL Delay

	LOADI 0
	OUT Beep
	CALL Delay
	
	LOAD D
	OUT Beep
	CALL Delay
	CALL Delay

	LOADI 0
	OUT Beep
	CALL Delay
	;here 
	LOAD G
	OUT Beep
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	
	LOADI 0
	OUT Beep
	CALL Delay
	
	LOAD Ds 
	OUT Beep
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	; CALL Delay
	; CALL Delay
	; CALL Delay
	; CALL Delay
	; CALL Delay
	; CALL Delay
	;finished
	; LOADI 0
	; OUT Beep
	CALL Delay
	
	LOAD C
	OUT Beep
	CALL Delay
	CALL Delay
	
	LOADI 0
	OUT Beep
	CALL Delay
	
	LOAD B
	OUT Beep
	CALL Delay
	CALL Delay
	
	LOADI 0
	OUT Beep
	CALL Delay
	
	LOAD A
	OUT Beep
	CALL Delay
	CALL Delay
	
	LOADI 0
	OUT Beep
	CALL Delay
	
	LOAD G
	OUT Beep
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	
	LOADI 0
	OUT Beep
	CALL Delay
	
	LOAD D
	OUT Beep
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	; CALL Delay
	; CALL Delay
	; CALL Delay
	; CALL Delay
	; CALL Delay
	; CALL Delay
	
	LOADI 0
	OUT Beep
	
	LOAD C
	OUT Beep
	CALL Delay
	CALL Delay
	
	LOADI 0
	OUT Beep
	CALL Delay
	
	LOAD B
	OUT Beep
	CALL Delay
	CALL Delay
	
	LOADI 0
	OUT Beep
	CALL Delay
	
	LOAD A
	OUT Beep
	CALL Delay
	CALL Delay
	
	LOADI 0
	OUT Beep
	CALL Delay
	
	LOAD G
	OUT Beep
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	
	LOADI 0
	OUT Beep
	CALL Delay
	
	LOAD D
	OUT Beep
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	;CALL Delay
	;CALL Delay
	;CALL Delay
	;CALL Delay
	;CALL Delay
	;CALL Delay
	
	LOAD C
	OUT Beep
	CALL Delay
	CALL Delay
	
	LOADI 0
	OUT Beep
	CALL Delay
	
	LOAD B
	OUT Beep
	CALL Delay
	CALL Delay
	
	LOADI 0
	OUT Beep
	CALL Delay
	
	LOAD C
	OUT Beep
	CALL Delay
	CALL Delay
	
	LOADI 0
	OUT Beep
	CALL Delay
	
	LOAD A
	OUT Beep
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	CALL Delay
	
	LOADI 0
	OUT Beep
	CALL Delay
	
	
	JUMP End
	
Chorus:
	

	
; Subroutine to delay for 0.2 seconds.
Delay:
	OUT    Timer
WaitingLoop:
	IN     Timer
	ADDI   -1
	JNEG   WaitingLoop
	RETURN
	
playQuarter:
	STORE	arg1
	OUT 	Beep
	OUT		Timer
	
quarterLoop:
	IN		Timer
	ADDI	-10
	JNEG	quarterLoop
	LOADI	0
	OUT		Beep
	CALL	Delay
	LOAD	arg1
	RETURN
	
End:
	JUMP END
	
	
	

; IO address constants
Switches:  EQU 000
LEDs:      EQU 001
Timer:     EQU 002
Hex0:      EQU 004
Hex1:      EQU 005
Beep:      EQU &H40

; NOTES
A:		DW &B0001110	;A4
B:		DW &B0010000	;B4
C:		DW &B0010001	;C4
D:		DW &B0010011	;D4
E:		DW &B0010101	;E4
F:		DW &B0010110	;F4
G:		DW &B0011000	;G4
G3:		DW &B0001100    ;G3
H:		DW &B0000101	;
Ds:		DW &B0011100 ;D-sharp
I:		DW &B0000110
Fs:		DW &B0010111
arg1:	DW 0
arg2:	DW 0

LoopCount:	DW 0