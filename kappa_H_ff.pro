FUNCTION kappa_H_ff, lambda, theta, STIMULATED=stim
	;+
	; NAME:
	;	kappa_H_ff()
	;
	; PURPOSE:
	;	To calculate the Free-Free opacity of Hydrogen for a given
        ;       lamdba, theta
	;
	; CALLING SEQUENCE:
	;	res = kappa_H_bf(lambda, theta)  
	;
	; INPUT PARAMETERS:
	;	lambda          The wavelength in Angstroms (array)
	;       theta   	Theta values: theta = 5040K/T where T is the temperature in Kelvins
	; 
	; OPTIONAL INPUT:
	;	STIMULATED                  Include the stimulated emission factor
	;
	; OUTPUT PARAMETERS:
	;	res	  
	; 
	; NOTES:
	;
	; MODIFICATION HISTORY:
	;	Coded by G. K. Stefansson - date 25 Feb 2014
	;-
	
	I = !const_I_H ; eV above ground level
	kappaff = (!const_alpha0*(lambda^3.0D)*gaunt_ff(lambda, theta) * alog10(exp(1.0D)) * (10.0D^(-theta*I))/(2*theta*I))

	IF KEYWORD_SET(stim) THEN BEGIN
		; Include stimulated emission factor
		chi_lambda = 1.2398D4/lambda
		kappaff = kappaff*(1.0D - 10.0^(-chi_lambda*theta))
	ENDIF

	RETURN, kappaff
END
