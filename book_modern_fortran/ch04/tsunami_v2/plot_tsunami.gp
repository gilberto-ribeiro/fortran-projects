set title 'Altura da água'
set xlabel 'x [m]'
set ylabel 'h [m]'
set xrange [0:100]
set yrange [-0.2:1.2]
set grid
set terminal pdfcairo
set output 'graph_tsunami.pdf'
plot 'tsunami_output_gnuplot.dat' u 1:2 t '0.0 s' w l,\
'' u 1:82 t '1.6 s' w l,\
'' u 1:3152 t '63.0 s' w l,\
'' u 1:4862 t '97.2 s' w l
set output
set terminal qt
replot