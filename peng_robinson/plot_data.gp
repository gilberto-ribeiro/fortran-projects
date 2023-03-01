set title 'Fator de compressibilidade do Metano'
set xlabel 'Pressão reduzida, P_R'
set ylabel 'Fator de compressibilidade, Z'
set xrange [0:6]
set yrange [0:1]
set key bottom right
plot 'data_output.dat' u 1:2 t 'T_R = 1.0' w l,\
'' u 1:3 t 'T_R = 1.1' w l,\
'' u 1:4 t 'T_R = 1.2' w l,\
'' u 1:5 t 'T_R = 1.3' w l,\
'' u 1:6 t 'T_R = 1.5' w l,\
'' u 1:7 t 'T_R = 2.0' w l
set terminal pdfcairo font 'courier' size 12cm,9cm
set output 'fig_peng.pdf'
replot
set output
set terminal qt