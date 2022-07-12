
FUNCTION spd_make_member_struc, filename


;+
; NAME:
;     SPD_MAKE_MEMBER_STRUC
;
; PURPOSE:
;     Reads a CSV file containing the list of SPD members into an IDL
;     structure.
;
; CATEGORY:
;     SPD; membership.
;
; CALLING SEQUENCE:
;     Result = SPD_MAKE_MEMBER_STRUC( )
;
; INPUTS:
;	Parm1:	Describe the positional input parameters here. Note again
;		that positional parameters are shown with Initial Caps.
;
; OPTIONAL INPUTS:
;     Filename:  The name of a CSV file to read. If not specified, then
;                the most recent file is read.
;
; OUTPUTS:
;     An IDL structure with the following tags:
;      .email  Email address.
;      .first  First name.
;      .middle Middle name/initial.
;      .last   Surname.
;      .company  Company/institute.
;      .city   City
;      .state  State.
;      .zip    Zip code.
;      .country  Country
;      .type   Type of membership.
;      .join   Date of joining SPD.
;      .id     ID number.
;
;     Note: not all fields are read into the structure.
;
; EXAMPLE:
;     IDL> s=spd_make_member_struc()
;
; MODIFICATION HISTORY:
;     Ver.1, 11-Jul-2022, Peter Young
;-


IF n_elements(filename) EQ 0 THEN filename=spd_get_csv()
d=read_csv(filename)

str={email: '', $
     first: '', $
     middle: '', $
     last: '', $
     company: '', $
     city: '', $
     state: '', $
     zip: '', $
     country: '', $
     type: '', $
     join: '', $
     id: ''}

n=n_elements(d.field01)

FOR i=0,n-1 DO BEGIN
  IF trim(d.field16[i]) NE '0' THEN BEGIN
    str.email=d.field01[i]
    str.first=d.field02[i]
    str.middle=d.field03[i]
    str.last=d.field04[i]
    str.company=d.field05[i]
    str.city=d.field06[i]
    str.state=d.field07[i]
    str.zip=d.field08[i]
    str.country=d.field09[i]
    str.type=d.field10[i]
    str.join=d.field11[i]
    str.id=trim(d.field16[i])
   ;
    IF n_tags(output) EQ 0 THEN output=str ELSE output=[output,str]
  ENDIF ELSE BEGIN
    print,'Problem: file '+trim(filename)+', index '+trim(i)
    print,d.field01[i]
  ENDELSE 
ENDFOR

     
return,output


END
