program main
    
    use iso_fortran_env, only: int32, real32, real64
    use mod_peng_robinson, only: compressibility_factor, print_z_p

    implicit none

    real(real32) :: const(3), h
    real, allocatable :: T(:), P(:)
    ! real :: T, P
    real(real64) :: z_est
    integer(int32) :: i, N

    z_est = 1

    const = [190.564, 4.599e6, 0.0115]
    ! const = [44.4, 2.653e6, -0.0396]
    T = [1.0, 1.1, 1.2, 1.3, 1.5, 2.]
    N = 10000
    h = (6. - 0) / N

    P = [(0 + h * (i - 1) , i = 1, N + 1)]

    ! print *, compressibility_factor(T, P, const, z_est)

    call print_z_p(T, P, const, z_est, .true.)


    
end program main

! gfortran src/mod_peng_robinson.f90 main.f90 -o main.out && ./main.out > data_output.dat && gnuplot plot_data.gp