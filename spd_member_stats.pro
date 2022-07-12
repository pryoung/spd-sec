
PRO spd_member_stats, country=country, types=types, file=file, verbose=verbose


;+
; NAME:
;     SPD_MEMBER_STATS
;
; PURPOSE:
;     Print out some statistics about SPD members.
;
; CATEGORY:
;     SPD; membership.
;
; CALLING SEQUENCE:
;     SPD_MEMBER_STATS
;
; INPUTS:
;     None.
;
; OPTIONAL INPUTS:
;     File:   By default the routine uses the most recent membership
;             file. This input allows you to directly specify a file
;             (see example below).
;	
; KEYWORD PARAMETERS:
;     COUNTRY:  Prints the number of countries to which members
;               belong, and the numbers for each country.
;     TYPES:    Prints the different types of AAS membership, with
;               numbers of members in each type.
;     VERBOSE:  If set, then additional (may) be printed.
;
; OUTPUTS:
;     Prints information to the IDL window.
;
; EXAMPLE:
;     IDL> spd_member_stats
;     IDL> spd_member_stats, /country
;     IDL> spd_member_stats, /types
;
;     IDL> files=spd_get_csv(/all)
;     IDL> spd_member_stats, file=files[0]
;
; MODIFICATION HISTORY:
;     Ver.1, 13-Jul-2020, Peter Young
;     Ver.2, 05-Mar-2021, Peter Young
;       Added /verbose keyword.
;     Ver.3, 02-Jun-2021, Peter Young
;       Added alumni category.
;-


IF n_elements(file) EQ 0 THEN file=spd_get_csv()

d=read_csv(file)

n=n_elements(d.field01)

surname=d.field04
forename=d.field02


CASE 1 OF
   keyword_set(country): BEGIN
      c=d.field09
      uniq_c=c[uniq(c,sort(c))]
      nu=n_elements(uniq_c)
      print,'Country membership: '
      print,'    No. of unique countries: '+trim(nu)
      FOR i=0,nu-1 DO BEGIN
         k=where(c EQ uniq_c[i],nk)
         print,'    '+uniq_c[i]+': '+trim(nk)
         IF keyword_set(verbose) THEN BEGIN 
            IF trim(uniq_c[i]) EQ '' THEN BEGIN
               print,'     **empty country string**'
               FOR ik=0,nk-1 DO print,'       ',forename[k[ik]]+' '+surname[k[ik]]
            ENDIF 
         ENDIF 
      ENDFOR 
   END
  ;
  keyword_set(types): BEGIN
    t=d.field10
    uniq_t=t[uniq(t,sort(t))]
    nt=n_elements(uniq_t)
   ;
    print,'Member types:'
    FOR i=0,nt-1 DO BEGIN
      k=where(t EQ uniq_t[i],nk)
      CASE trim(uniq_t[i]) OF
         'AL': type='Alumni'
         'AM': type='Amateur'
         'E': type='Emeritus'
         'ED': type='Educator'
         'F': type='Full member'
         'GR': type='Graduate student'
         'IA': type='International affiliate'
         'JR': type='Undergraduate'
         'SPD': type='Affiliate member'
         'STAFF': type='AAS staff'
        ELSE: type='Unknown'
      ENDCASE 
      print,format='(3x,a6,a25,i5)',strpad(uniq_t[i],6,/after),strpad(type,25,fill=' ',/after),nk
    ENDFOR 
  END
  ELSE: print,'Number of SPD members: '+trim(n)
ENDCASE 


END
