! Beginning of the program
program tsunami
    
    use iso_fortran_env, only: int32, real32
    use mod_diff, only: diff => diff_centered
    use mod_initial, only: set_gaussian

    ! Enforces explicit declaration of variables
    implicit none
    
    ! Declaration of data
    integer(int32) :: n
    
    integer(int32), parameter :: grid_size = 100, num_time_steps = 5000
    
    real(real32), parameter :: dt = 0.02, dx = 1, g = 9.8
    real(real32), parameter :: hmean = 10
    
    real(real32), dimension(grid_size) :: h, u
    
    integer(int32), parameter :: icenter = 25
    real(real32), parameter :: decay = 0.02
    
    ! call compiler_info()

    ! Checks input parameter values and aborts if invalid
    if (grid_size <= 0) stop 'grid_size must be > 0'
    if (dt <= 0) stop 'time step dt must be > 0'
    if (dx <= 0) stop 'grid spacing dx must be > 0'
    
    ! Loops over array elements and initializes values
    call set_gaussian(h, icenter, decay)
    u = 0
    
    ! Writes the initial water height values to the terminal 
    print *, 0, h
    
    ! Begins the time loop
    time_loop: do n = 1, num_time_steps
        u = u - (u * diff(u) + g * diff(h)) / dx * dt
        h = h - diff(u * (hmean + h)) / dx * dt
        print *, n, h
    end do time_loop
    
contains

    subroutine compiler_info()
        use iso_fortran_env, only: compiler_version, compiler_options
        implicit none
        print *, 'Compiler version: ', compiler_version()
        print *, 'Compiler options: ', compiler_options()
    end subroutine compiler_info
        
end program tsunami