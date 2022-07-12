
PRO spd_find_member, name, file=file

;+
; NAME:
;     SPD_FIND_MEMBER
;
; PURPOSE:
;     Searches the list of SPD members for the specified name.
;
; CATEGORY:
;     SPD; membership.
;
; CALLING SEQUENCE:
;     SPD_FIND_MEMBER, Name
;
; INPUTS:
;     Name:  The surname of the person to be searched for.
;
; OPTIONAL INPUTS:
;     File:  String specifying the SPD data file. If not specified
;            then the most recent file is used.
;
; OUTPUTS:
;     Prints to the IDL window any member names that are found.
;
; RESTRICTIONS:
;     The membership CSV file must be in ~/syndrive/spd/membership. 
;
; EXAMPLE:
;     IDL> spd_find_member,'Young'
;
; MODIFICATION HISTORY:
;     Ver.1, 27-Feb-2020, Peter Young
;     Ver.2, 05-Mar-2021, Peter Young
;       Adjusted output format.
;     Ver.3, 08-Jun-2021, Peter Young
;       Added affiliation
;     Ver.4, 27-Sep-2021, Peter Young
;       Updated to call spd_get_csv.
;     Ver.5, 22-Feb-2022, Peter Young
;       Added "paid through" to output.
;     Ver.6, 11-Mar-2022, Peter Young
;       Added file= optional input.
;-

IF n_elements(file) EQ 0 THEN file=spd_get_csv()

IF file EQ '' THEN return

print,'% SPD_FIND_MEMBER: using file '+file_basename(file)

d=read_csv(file)

surname=d.field04
forename=d.field02
type=d.field10
email=d.field01
affil=d.field05
paidthru=d.field12


chck=strpos(strlowcase(surname),strlowcase(name))
k=where(chck GE 0,nk)

IF nk NE 0 THEN BEGIN
   print,'-----------------'
  FOR i=0,nk-1 DO BEGIN
    j=k[i]
    print,forename[j]+' '+surname[j]
    print,'Affiliation: '+affil[j]
    print,'Type:  '+trim(type[j])
    print,'Email: '+trim(email[j])
    print,'Paid through: '+trim(paidthru[j])
    print,'-----------------'
  ENDFOR
ENDIF ELSE BEGIN
  print,'% SPD_FIND_MEMBER: name not found.'
ENDELSE

END
