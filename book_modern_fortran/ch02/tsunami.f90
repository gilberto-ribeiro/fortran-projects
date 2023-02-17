! Beginning of the program
program tsunami
    
    ! Enforces explicit declaration of variables
    implicit none
    
    ! Declaration of data
    integer :: i, n
    
    integer, parameter :: grid_size = 100, num_time_steps = 100
    
    real, parameter :: dt = 1 ! time step [s]
    real, parameter :: dx = 1 ! grid spacing [m]
    real, parameter :: c  = 1 ! background flow speed [m/s]
    
    real, dimension(grid_size) :: h
    real :: dh(grid_size)
    
    integer, parameter :: icenter = 25
    real, parameter ::    decay   = 0.02
    
    ! Checks input parameter values and aborts if invalid
    if (grid_size <= 0) stop 'grid_size must be > 0'
    if (dt <= 0) stop 'time step dt must be > 0'
    if (dx <= 0) stop 'grid spacing dx must be > 0'
    if (c <= 0) then
        stop 'background flow speed c must be > 0'
    end if
    
    ! Loops over array elements and initializes values
    do concurrent(i = 1:grid_size)
        h(i) = exp(-decay * (i - icenter)**2)
    end do
    
    ! Writes the initial water height values to the terminal 
    print *, 0, h
    
    ! Begins the time loop
    time_loop: do n = 1, num_time_steps
        
        ! Applies the periodic boudary condition at the left edge of the domain
        dh(1) = h(1) - h(grid_size)
        
        ! Calculates de finite difference of water height in space
        do concurrent(i = 2:grid_size)
            dh(i) = h(i) - h(i-1)
        end do
        
        !Integrates the solution forward; this is the core of our solver
        do concurrent(i = 1:grid_size)
            h(i) = h(i) - c * dh(i) / dx * dt
        end do
        
        ! Prints current values to the terminal
        print *, n, h
        
    end do time_loop
        
end program tsunami
