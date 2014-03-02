FUNCTION read_struct, filename, USETEMPLATE=template
	;+
	; NAME:
	;	read_struct()
	;
	; PURPOSE:
	;	To read data located in an ASCII file **filename**, and return the data
	;       as a datastructure. It facilitates the use of reading the data
	;       by the help of ascii_template - and allows you to save the template
	;       (see OPTIONAL PARAMETERS)
	;
	; CALLING SEQUENCE:
	;	res = read_struct(filename)  
	;
	; INPUT PARAMETERS:
	;	**filename**    The filename of the file containing the data 
	; 
	; OPTIONAL INPUT:
	;	USETEMPLATE	If you have already saved the template in a file
	;			then you can issue this keyword to access the template
	;			and skip the GUI template part.
	;
	; OUTPUT PARAMETERS:
	;	res	  	The data in an IDL datastructure. Normally you would
	;                       get the resulting data like this:
	;  			res.field1
	;			res.field2 and so on,
	;			- but you can set the names of the fields in the GUI
	; 
	; NOTES:
	;	Any files created will be created in the working directory
	;
	; MODIFICATION HISTORY:
	;	Coded by G. K. Stefansson - date Feb 24
	;-
	
	IF KEYWORD_SET(template) THEN BEGIN
		;Working dir
		RESTORE, filename+'_asciiTemplate.sav'
		;Full path
		;RESTORE, '/astro/grads/gws5257/idl/gklib/logpartTemplate.sav'
	ENDIF ELSE BEGIN
		myTemplate = ascii_template(filename, browse_lines=1)
		SAVE, myTemplate, FILENAME=filename+'_asciiTemplate.sav'
	ENDELSE

	; Return the datastructure
	data = read_ascii(filename, template=myTemplate)

	RETURN, data
END
