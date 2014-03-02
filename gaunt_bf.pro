FUNCTION gaunt_bf, lambda, n
	;+
	; NAME:
	;	gaunt_bf()
	;
	; PURPOSE:
	;	To calculate the Bound-Free Gaunt factor (see eq 8.5, p 151 in Gray)
	;
	; CALLING SEQUENCE:
	;	res = gaunt_bf(lambda, n)  
	;
	; INPUT PARAMETERS:
	;	lambda    The wavelenght in angstroms (array)
	;	n         principal quantum number
	; 
	; OPTIONAL INPUT:
	;
	; OUTPUT PARAMETERS:
	;	res	  The Bound-Free Gaunt factor
	; 
	; NOTES:
	;       Relies on that the System-variable constants are defined
	;	
	;
	; MODIFICATION HISTORY:
	;	Coded by G. K. Stefansson - date 25 Feb 2014
	;
	;-

	gauntbf = 1.0D - ((0.3456D)/(lambda*!const_R_A)^(1.0D/3.0D)) * ( (lambda*!const_R_A/(n*n))- 0.5D)
	RETURN, gauntbf
END

