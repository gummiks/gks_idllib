FUNCTION phit, nameElement, temp, VERBOSE=verb
	;+
	; NAME:
	;	phit()
	;
	; PURPOSE:
	;	To calculate the temperature dependent part of the RHS of the Saha equation for an arbitrary element **nameElement**
	;
	; CALLING SEQUENCE:
	;	res = phit(nameElement, temp)  
	;
	; INPUT PARAMETERS:
	;	**nameElement** A string containing the element name 
	;	temp         The temperature in Kelvins
	; 
	; OPTIONAL INPUT:
	;
	; OUTPUT PARAMETERS:
	;	res	  $\Phi(T)$ - the temperature dependent part of the RHS of the Saha equation for element **nameElement**
	; 
	; NOTES:
	;	This function depends on the ionization potentials for various elements
	;	present in the file **ioniz.txt** - so be careful that the function can locate it!
	;
	; MODIFICATION HISTORY:
	;	Coded by G. K. Stefansson - date Feb 24
	;
	;-
	
	; Filename of including the data
	;filename = '/astro/grads/gws5257/idl/gks_idllib/ioniz.txt'
	filename = 'ioniz.txt'

	; Constants
	; m_e = 9.108e-28 g
	; k = 1.380e-16 erg/K
	; h = 6.625e-27 erg*sec
	; C_1 = 4.413587e15 
	; C = 4.413587203d15
	; k/[e-charge) to change into eV
	; myEv = 8.61423d-5 

	theta = 5040.0D/temp

	; r is the ionization stage, U_rr is the r+1 stage, and U_r is the r stage
	U_rr  =10^(logpartfunc(nameElement+'+',theta,/USETEMPLATE))
	U_r   =10^(logpartfunc(nameElement,theta,/USETEMPLATE))

	ratio = U_rr/U_r

	; Read in the data, as a datastructure
	ioniz_data = read_struct(filename,/USETEMPLATE)
	elements = ioniz_data.field2


	elem_index = WHERE(elements EQ nameElement)
	IF elem_index EQ -1 THEN BEGIN
		print, 'Element not found'
		STOP
	ENDIF ELSE BEGIN
		IF KEYWORD_SET(verb) THEN BEGIN
			print, 'Element found'
		ENDIF
		chi = ioniz_data.field4[elem_index]
	ENDELSE

	phi =  0.6665D * ratio * (temp^2.5D) * 10^(-chi*theta)

	RETURN,phi
END
