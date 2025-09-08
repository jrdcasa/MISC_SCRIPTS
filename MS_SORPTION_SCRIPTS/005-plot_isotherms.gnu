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
set ylabel "Loading [molecules/unit cell]"
set format x "10^{%L}"
set format y "%.0f"
set log x
set key top left
set yrange[0:20]
#set xtics 0.4e-04
#set mxtics 5
#set ytics 0.1
#set mytics 4

f1a="./99-ANALYSIS/01-Isotherms/MFI_Al00_222_opt_DDEC6-CH4_ES_isotherm.dat"
f2a="./99-ANALYSIS/01-Isotherms/MFI_Al00_222_opt_DDEC6-CH3Cl_ES_isotherm.dat"
f3a="./99-ANALYSIS/01-Isotherms/MFI_Al00_222_opt_DDEC6-CH2Cl2_ES_isotherm.dat"
f4a="./99-ANALYSIS/01-Isotherms/MFI_Al00_222_opt_DDEC6-CHCl3_ES_isotherm.dat"
f5a="./99-ANALYSIS/01-Isotherms/MFI_Al00_222_opt_DDEC6-CCl4_ES_isotherm.dat"


p f1a u 1:($2/8) w p ls 1 title "CH_4,current",\

p f2a u 1:($2/8) w p ls 1 title "CH_3Cl,current",\

p f3a u 1:($2/8) w p ls 1 title "CH_2Cl_2,current",\

p f4a u 1:($2/8) w p ls 1 title "CHCl_3,current",\

p f5a u 1:($2/8) w p ls 1 title "CHCl_4,current",\

unset multiplot 

##############################################################################
set term wxt 2 enhanced dashed size 1200,800 font "Arial,12"
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
set ylabel "Loading [molecules/unit cell]"
set format x "10^{%L}"
set format y "%.0f"
set log x
set key top left
set yrange[0:20]
#set xtics 0.4e-04
#set mxtics 5
#set ytics 0.1
#set mytics 4

f6a="./99-ANALYSIS/01-Isotherms/MFI_Al00_222_opt_DDEC6-C2H6_ES_isotherm.dat"
f7a="./99-ANALYSIS/01-Isotherms/MFI_Al00_222_opt_DDEC6-C2H4Cl2_ES_isotherm.dat"
f8a="./99-ANALYSIS/01-Isotherms/MFI_Al00_222_opt_DDEC6-C2H4_ES_isotherm.dat"
f9a="./99-ANALYSIS/01-Isotherms/MFI_Al00_222_opt_DDEC6-C2HCl3_ES_isotherm.dat"
f10a="./99-ANALYSIS/01-Isotherms/MFI_Al00_222_opt_DDEC6-C2Cl4_ES_isotherm.dat"

p f6a u 1:($2/8) w p ls 1 title "C_2H_6,current",\

p f7a u 1:($2/8) w p ls 1 title "C_2H_4Cl_2,current",\

p f8a u 1:($2/8) w p ls 1 title "C_2H_4,current",\

p f9a u 1:($2/8) w p ls 1 title "C_2HCl_3,current",\

p f10a u 1:($2/8) w p ls 1 title "C_2Cl_4,current",\

unset multiplot
 
##############################################################################
set term wxt 3 enhanced dashed size 1200,800 font "Arial,12"
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
set ylabel "Loading [molecules/unit cell]"
set format x "10^{%L}"
set format y "%.0f"
set log x
set key top left
set yrange[0:20]
#set xtics 0.4e-04
#set mxtics 5
#set ytics 0.1
#set mytics 4

f11a="./99-ANALYSIS/01-Isotherms/MFI_Al00_222_opt_DDEC6-Cl2_ES_isotherm.dat"
f12a="./99-ANALYSIS/01-Isotherms/MFI_Al00_222_opt_DDEC6-HCl_ES_isotherm.dat"

p f11a u 1:($2/8) w p ls 1 title "Cl_2,current",\

p f12a u 1:($2/8) w p ls 1 title "HCl,current",\

unset multiplot
