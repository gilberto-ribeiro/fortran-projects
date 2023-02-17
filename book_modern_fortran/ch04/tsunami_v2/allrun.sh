rm *.mod *.pdf *.dat tsunami
gfortran mod_*.f90 tsunami.f90 -o tsunami
./tsunami > tsunami_output.dat
python3 prepare_to_gnuplot.py
gnuplot plot_tsunami.gp
