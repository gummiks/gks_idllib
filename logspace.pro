FUNCTION LOGSPACE, A, B, N
	;+
	; NAME:
	;	LOGSPACE()
	; PURPOSE:
	;	To create an array of N logarithmically spaced values between the endpoints A and B
	;
	; CALLING SEQUENCE:
	;	myArray = LOGSPACE( A, B, N)
	;
	; INPUT PARAMETERS:
	;	A         Left endpoint
	;	B         Right endpoint
	;	N         Number of points in myArray
	;
	; OUTPUT PARAMETERS:
	;       myArray   Array of logarithmically spaced numbers, ranging from A to B; N in total 
	;		  - Values are equally spaced in log-space
	;
	; NOTES:
	; 	Code based on code shown in the following website:
	; 	  https://klassenresearch.orbs.com/Emulate+linspack+and+logspace
	;	but it did not include any documentation
	;
	; MODIFICATION HISTORY
	;	G. K. Stefansson - February 4, 2014
	;-
	L = DINDGEN(N) / (N - 1.0D) * (B - A) + A
	L = 10.0D^(L)
	return, L
END
