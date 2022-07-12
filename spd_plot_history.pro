
FUNCTION spd_plot_history, _extra=extra, data=data, type=type

;+
; NAME:
;     SPD_PLOT_HISTORY
;
; PURPOSE:
;     Plots the number of SPD members as a function of time, as taken
;     from the set of saved CSV files downloaded from the AAS website.
;
; CATEGORY:
;     SPD; members; statistics.
;
; CALLING SEQUENCE:
;     Result = SPD_PLOT_HISTORY( )
;
; INPUTS:
;     None.
;
; OPTIONAL INPUTS:
;     Type:  A code specifying what member type to plot. For example,
;            'F' for full members. Run spd_member_stats with the
;            /type keyword to see the full list of types.
;
;     Optional plot commands can be passed through the usual keywords.
;	
; OUTPUTS:
;     Creates an IDL plot object showing the change in the number of
;     SPD members over time.
;
; OPTIONAL OUTPUTS:
;     Data:  A structure containing the plot data.
;             .time  Time in Julian days.
;             .n     Number of members.
;
; CALLS:
;     SPD_GET_CSV, SPD_MAKE_MEMBER_STRUC
;
; EXAMPLE:
;     IDL> p=spd_plot_history()
;     IDL> p=spd_plot_history(type='spd')
;
; MODIFICATION HISTORY:
;     Ver.1, 14-Apr-2020, Peter Young
;     Ver.2, 18-May-2020, Peter Young
;       Added symbols to plot.
;     Ver.3, 24-Jan-2022, Peter Young
;       Modified plot format.
;     Ver.4, 16-May-2022, Peter Young
;       Added Data= optional output.
;     Ver.5, 11-Jul-2022, Peter Young
;       Added Type= optional input.
;-

files=spd_get_csv(/all)

n=n_elements(files)

y=intarr(n)
dates=strmid(file_basename(files),12,8)

x=strmid(dates,6,2)+'-'+get_month(trim(strmid(dates,4,2))-1,/trunc)+'-'+strmid(dates,0,4)
x_jd=tim2jd(x)

FOR i=0,n-1 DO BEGIN
  s=spd_make_member_struc(files[i])
  IF n_elements(type) NE 0 THEN BEGIN
    k=where(strlowcase(s.type) EQ strlowcase(type),nk)
    y[i]=nk
  ENDIF ELSE BEGIN
    y[i]=n_elements(s)
  ENDELSE 
ENDFOR

IF n_elements(font_size) EQ 0 THEN font_size=14
IF n_elements(thick) EQ 0 THEN thick=2

IF n_elements(yrange) EQ 0 THEN BEGIN 
  mm=minmax(round(y))/20
  mm[1]=mm[1]+1
  yrange=mm*20
ENDIF


p=plot(x_jd,y,xtickunits='time',color=color_toi(/vibrant,'red'), $
       ytitle='No. of members', $
       xtitle='Time', $
       xticklen=1,yticklen=1, $
       yrange=yrange, /ysty, $
       font_size=font_size, $
       thick=thick, $
       symbol='diamond',sym_filled=1,sym_size=1.5, $
       xgridstyle=':', ygridstyle=':',$
       xminor=0, yminor=0, $
       _extra=extra )
       

print,format='(a8,3x,i5)',dates[-2],y[-2]
print,format='(a8,3x,i5)',dates[-1],y[-1]


data={ time: x_jd, n: y }

return,p

END
