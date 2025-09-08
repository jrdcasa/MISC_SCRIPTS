reset
###############################################################################
set term wxt 1 enhanced dashed size 1200,800 font "Arial,12"
set multiplot layout 2,3
set encoding iso_8859_1
set style line 1 lt 1 ps 1.2 lc rgb "black"   pt 4 lw 2.0
set style line 2 lt 2 ps 1.2 lc rgb "blue"    pt 6 lw 2.0
set style line 3 lt 3 ps 1.2 lc rgb "red"     pt 8 lw 2.0
set style line 4 lt 4 ps 1.2 lc rgb "yellow"  pt 4 lw 2.0
set style line 5 lt 5 ps 1.2 lc rgb "orange"  pt 5 lw 2.0
set style line 6 lt 6 ps 1.2 lc rgb "blue"    pt 6 lw 2.0
set style line 7 lt 7 ps 1.2 lc rgb "gray"    pt 7 lw 2.0
set style line 8 lt 8 ps 1.2 lc rgb "violet"  pt 8 lw 2.0
set style line 9 lt 9 ps 1.2 lc rgb "red"     pt 9 lw 2.0

set xlabel "f(kPa)"
set ylabel "Loading [mol/kg]"
set format x "10^{%L}"
set format y "%.1f"
set log x
set key top left
set yrange[0:3.2]
#set xtics 0.4e-04
#set mxtics 5
#set ytics 0.1
#set mytics 4
mw=5767.97

f2a="./99-ANALYSIS/01-Isotherms/MFI_Al00_222_opt_DDEC6-CH3Cl_ES_isotherm.dat"
f2b="./99-Exp_data_CH3Cl_338K.data"


p f2a u 1:((($2/8)/mw)*1000) w p ls 1 title "CH_3Cl,sim,298K",\
  f2b u 1:2 w p ls 2 title "CH_3Cl,exp,348K",\


unset multiplot 

