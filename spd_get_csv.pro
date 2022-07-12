
FUNCTION spd_get_csv, all=all

;+
; NAME:
;     SPD_GET_CSV
;
; PURPOSE:
;     Finds the most recent SPD membership CSV file.
;
; CATEGORY:
;     SDP; membership
;
; CALLING SEQUENCE:
;     Result = SPD_GET_CSV( )
;
; INPUTS:
;     None.
;
; KEYWORD PARAMETERS:
;     ALL:   If set, then all of the CSV filenames are returned. 
;
; OUTPUTS:
;     Returns the full path to the most recent CSV file.
;
; RESTRICTIONS:
;     The environment variable $SPD_MEMBERS should point to where
;     the membership data files are located.
;
; MODIFICATION HISTORY:
;     Ver.1, 27-Feb-2020
;     Ver.2, 14-Apr-2020
;       Added /all keyword.
;     Ver.3, 27-Sep-2021, Peter Young
;       Changed location of data files.
;     Ver.4, 11-Jul-2022, Peter Young
;       Now use $SPD_MEMBERS environment variable.
;-


member_dir=getenv('SPD_MEMBERS')
IF member_dir EQ '' THEN BEGIN
  message,/cont,/info,'Please set the environment variable to point to where the SPD membership files are located.'
  return,''
ENDIF 

list=file_search(member_dir,'spd_members_*.csv',count=count)

IF count EQ 0 THEN BEGIN
  message,/info,/cont,'no membership CSV files were found.'
  return,''
ENDIF

IF keyword_set(all) THEN return,list

dates=long(strmid(file_basename(list),12,8))
getmax=max(dates,imax)
file=list[imax]

return,file

END
