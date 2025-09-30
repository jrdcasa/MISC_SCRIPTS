reset
###############################################################################
set term wxt 1 enhanced dashed size 1200,800 font "Arial,8"
set multiplot layout 4,4
set encoding iso_8859_1
set style line 1 lt 1 ps 1.0 lc rgb "black"   pt 4 lw 2.0
set style line 2 lt 2 ps 1.0 lc rgb "blue"    pt 6 lw 2.0
set style line 3 lt 3 ps 1.0 lc rgb "red"     pt 8 lw 2.0
set style line 4 lt 4 ps 1.0 lc rgb "yellow"  pt 4 lw 2.0
set style line 5 lt 5 ps 1.0 lc rgb "orange"  pt 5 lw 2.0
set style line 6 lt 6 ps 1.0 lc rgb "blue"    pt 6 lw 2.0
set style line 7 lt 7 ps 1.0 lc rgb "gray"    pt 7 lw 2.0
set style line 8 lt 8 ps 1.0 lc rgb "violet"  pt 8 lw 2.0
set style line 9 lt 9 ps 1.0 lc rgb "red"     pt 9 lw 2.0

set ylabel "{/Symbol r} (g/cm^3)"
set xlabel "Monte Carlo Step"
set format x "%2.1t·10^{%T}"
set format y "%.3f"
set key top right font "Arial,8"
set grid
set yrange[0:1.4]
set xrange[0:10E6]
#set xtics 0.4e-04
#set mxtics 5
#set ytics 0.1
#set mytics 4

# List of subdirs
dirs = system("ls -d ../../T_*_K*")

do for [d in dirs] {

    print "Processing: ".d

    f1 = system("ls ".d."/*.box1.prp")
    f2 = system("ls ".d."/*.box2.prp")

    #temp = system("basename ".d." | awk -F "_" '{print $2}'")
    temp = system("basename ".d." |awk -F \"_\"  '{print $2} '")

    
    print "Processing: ".temp
    set title sprintf("%s\\ K", temp)

    p f1 u 1:($2/1000) ls 1 w l title "Box 1",\
      f2 u 1:($2/1000) ls 2 w l title "Box 2",\

}

unset multiplot

###############################################################################
set term wxt 2 enhanced dashed size 1200,800 font "Arial,8"
set multiplot layout 4,4
set encoding iso_8859_1

set ylabel "L (A)"
set xlabel "Monte Carlo Step"
set format x "%2.1t·10^{%T}"
set format y "%.1f"
set key top right font "Arial,8"
set grid
set yrange[20:120]
set xrange[0:10E6]
#unset yrange
#set xtics 0.4e-04
#set mxtics 5
#set ytics 0.1
#set mytics 4

# List of subdirs
dirs = system("ls -d ../../T_*_K*")

do for [d in dirs] {

    print "Processing: ".d

    f1 = system("ls ".d."/*.box1.prp")
    f2 = system("ls ".d."/*.box2.prp")

    #temp = system("basename ".d." | awk -F "_" '{print $2}'")
    temp = system("basename ".d." |awk -F \"_\"  '{print $2} '")

    
    print "Processing: ".temp
    set title sprintf("%s\\ K", temp)

    p f1 u 1:($5**(1.0/3.0)) ls 1 w l title "Box 1",\
      f2 u 1:($5**(1.0/3.0)) ls 2 w l title "Box 2",\

}

unset multiplot

###############################################################################
set term wxt 3 enhanced dashed size 1200,800 font "Arial,8"
set multiplot layout 4,4
set encoding iso_8859_1

set ylabel "N_{mol}"
set xlabel "Monte Carlo Step"
set format x "%2.1t·10^{%T}"
set format y "%.0f"
set key top right font "Arial,8"
set grid
set yrange[0:700]
set xrange[0:10E06]
#unset yrange
#set xtics 0.4e-04
#set mxtics 5
#set ytics 0.1
#set mytics 4

# List of subdirs
dirs = system("ls -d ../../T_*_K*")

do for [d in dirs] {

    print "Processing: ".d

    f1 = system("ls ".d."/*.box1.prp")
    f2 = system("ls ".d."/*.box2.prp")

    #temp = system("basename ".d." | awk -F "_" '{print $2}'")
    temp = system("basename ".d." |awk -F \"_\"  '{print $2} '")

    
    print "Processing: ".temp
    set title sprintf("%s\\ K", temp)

    p f1 u 1:($4) ls 1 w l title "Box 1",\
      f2 u 1:($4) ls 2 w l title "Box 2",\

}

unset multiplot

###############################################################################
set term wxt 4 enhanced dashed size 1200,800 font "Arial,8"
set multiplot layout 2,2
set encoding iso_8859_1

set ylabel "T (K)"
set xlabel "{/Symbol r} (g/cm^3)"
set format x "%.3f"
set format y "%.0f"
set key top right font "Arial,8"
set grid
#set yrange[0:500]
unset xrange
unset yrange
#set xtics 0.4e-04
#set mxtics 5
#set ytics 0.1
#set mytics 4

f1="./avg_density.dat"
fexp1="./Exp_density_set1.dat"
fexp2="./Exp_density_set2.dat"
unset title

# List of subdirs
p f1 u ($2/1000):1:($3/1000) ls 1 w errorbars title "Box 1",\
  f1 u ($4/1000):1:($3/1000) ls 2 w errorbars title "Box 2",\
  fexp1 u ($2):($1)                w p ls 3 title "Exp,2017, liquid",\
  fexp2 u ($2):($1)                w p ls 4 title "Exp,1964, gas",\
  fexp2 u ($3):($1)                w p ls 5 title "Exp,1964, liquid",\




unset multiplot
