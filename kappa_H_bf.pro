FUNCTION kappa_H_bf, lambda, theta, STIMULATED=stim
	;+
	; NAME:
	;	kappa_H_bf()
	;
	; PURPOSE:
	;	To calculate the Bound-Free opacity of Hydrogen for a given
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

	len = n_elements(lambda)
	kappabf=make_array(1,len,/DOUBLE, value=0) 
	FOR i = 0, len-1 DO BEGIN
		n_0 = ceil(sqrt(!const_R_A*lambda[i]))
		chi3 = (!const_I_H*(1.0D - 1.0D/((n_0+3)^2.0D)))
		sum = 0
		; Calculate the sum part in eq 8.8 page 153 in Gray
		FOR n = n_0, n_0+2 DO BEGIN
			chi = !const_I_H * (1.0D - (1.0D)/(n^2.0D))
			sum = sum + (gaunt_bf(lambda[i], n)*(10.0D^(-theta*chi))/(n^3.0D))
		ENDFOR
		const_infront = (!const_alpha0*(lambda[i]^3.0D))
		tmp = (alog10(exp(1.0D))/(2*theta*!const_I_H))
		tmp2= (10.0D^(-chi3*theta) - 10.0D^(-!const_I_H*theta))
		kappabf[i] = const_infront * (sum + tmp*tmp2)
	ENDFOR

	IF KEYWORD_SET(stim) THEN BEGIN
		; Include stimulated emission factor
		chi_lambda = 1.2398D4/lambda
		kappabf = kappabf*(1.0D - 10.0^(-chi_lambda*theta))
	ENDIF

	RETURN, kappabf
END

