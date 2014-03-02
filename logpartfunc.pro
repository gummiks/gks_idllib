FUNCTION logpartfunc, nameElement, evaltheta, LISTITEMS=items, DOPLOT=plotting, USETEMPLATE=template
	;+
	; NAME:
	;	logpartfunc()
	;
	; PURPOSE:
	;	To calculate the logarithm of the partition function for an arbitrary 
	;	element **nameElement** at a theta-temperature of  **evaltheta**
	;
	; CALLING SEQUENCE:
	;	res = logpartfunc(nameElement, evaltheta)  
	;
	; INPUT PARAMETERS:
	;	nameElement 	The name of the element, e.g. 'Li-'
	;	evaltheta      	The theta-temperature at which the partition function
	;			will be evaluated (theta = 5040K / T )
	; 
	; OPTIONAL INPUT:
	;	LISTITEMS	If this keyword is set, the program will print
	;			out a list of available elements
	;	DOPLOT		Plot the log(u(T)), along with the intepolation curve
	;	USETEMPLATE     Use a working ascii_template, saved before - so 
	;                       you don't have to interactively set it all the time
	;
	; OUTPUT PARAMETERS:
	;	res	  	The logarithm of the partition function for a **nameElement** at **evaltheta**
	; 
	; NOTES:
	;	- This program depends on the data in the file 'p_nAndv.txt'
	;	  which lists the available elements in the first column, and
	;         the log(u(theta)) values for theta = 0.2,0.4,...,2.0. The last
	;         column lists log(g_0) where g_0 is the degeneracy of the ground state
	;       - If the USETEMPLATE keyword is set be sure that the 'logpartTemplate.sav'
	;	  is accessible.
	;
	; MODIFICATION HISTORY:
	;	Coded by G. K. Stefansson - date Feb 18
	;-
	
	; Filename of including the data used for interpolation

	;Current directory
	;name_p_nAndv = 'p_nAndv.txt' 
	;Full directory path
	name_p_nAndv = '/astro/grads/gws5257/idl/gklib/p_nAndv.txt'


	IF KEYWORD_SET(template) THEN BEGIN
		;Working dir
		;RESTORE, 'logpartTemplate.sav'
		;Full path
		RESTORE, '/astro/grads/gws5257/idl/gklib/logpartTemplate.sav'
	ENDIF ELSE BEGIN
		logpartTemplate = ascii_template(name_p_nAndv, browse_lines=1)
		SAVE, logpartTemplate, FILENAME='logpartTemplate.sav'
	ENDELSE

	; Data
	data = read_ascii(name_p_nAndv, template=logpartTemplate)
	elements = data.field01
	
	IF KEYWORD_SET(items) THEN BEGIN
		print, 'List of available elements:', elements
	ENDIF

	elem_index = WHERE(elements EQ nameElement)
	IF elem_index EQ -1 THEN BEGIN
		print, 'Element not found'
	ENDIF ELSE BEGIN
		print, 'Element found'
		theta = linspace(0.2D, 2.0D, 10.0D)
		logUval = [data.field02[elem_index],$ 
	                   data.field03[elem_index],$
                           data.field04[elem_index],$
                           data.field05[elem_index],$
                           data.field06[elem_index],$ 
			   data.field07[elem_index],$ 
			   data.field08[elem_index],$ 
			   data.field09[elem_index],$ 
			   data.field10[elem_index],$
			   data.field11[elem_index]]
		eval = interpol(logUval, theta, evaltheta, /NAN)

		IF KEYWORD_SET(plotting) THEN BEGIN
			cgWindow
			!x.thick=4
			!y.thick=4
			; nstring = strtrim(n, 2)
			xstr = TexToIDL('\theta') 
			ystr = TexToIDL('Log (u(T)') 
			cgPlot, theta, logUval, color='red', xstyle=1, ystyle=2, font=-1, /window, thick=3, yrange=[0,2],xrange=[0,2.5],$
				Aspect=2./3, XTitle=xstr, YTitle=ystr, charsize=2
			cgPlot, evaltheta, eval, color='blu7', xstyle=1, ystyle=2, font=-1, /window, thick=3, yrange=[0,2], xrange=[0,2.5],$
				Aspect=2./3, XTitle=xstr, YTitle=ystr, charsize=2 , /Overplot, /addcmd
		ENDIF
	ENDELSE

	RETURN, eval
END


