FUNCTION gaunt_ff, lambda, theta
	;+
	; NAME:
	;	gaunt_ff()
	;
	; PURPOSE:
	;	To calculate the Free-Free Gaunt factor (see eq 8.6 on page 151 in Gray) as a function
	;       of wavelength and temperature **theta** = 5040K/T
	;
	; CALLING SEQUENCE:
	;	res = gaunt_ff(lambda)  
	;
	; INPUT PARAMETERS:
	;	lambda        The wavelength in Angstroms (array)
	;       theta        Theta values: theta = 5040K/T where T is the temperature in Kelvins
	; 
	; OPTIONAL INPUT:
	;		  
	;
	; OUTPUT PARAMETERS:
	;	res	     The free-free Gaunt factor
	; 
	; NOTES:
	;       Relies on that the System-variable constants are defined
	;
	; MODIFICATION HISTORY:
	;	Coded by G. K. Stefansson - date Feb 25 2014
	;-
	
	; The photon energy:
	chi_lambda = 1.2398D4/lambda 
	gauntff = 1.0D + ((0.3456D)/(lambda*!const_R_A)^(1.0D/3.0D)) * ( (alog10(exp(1.0D))/(theta*chi_lambda)) + 0.5D ) 
	RETURN, gauntff
END

