! Beginning of the program
program tsunami
    
    ! Enforces explicit declaration of variables
    implicit none
    
    ! Declaration of data
    integer :: n
    
    integer, parameter :: grid_size = 100, num_time_steps = 100
    
    real, parameter :: dt = 1 ! time step [s]
    real, parameter :: dx = 1 ! grid spacing [m]
    real, parameter :: c  = 1 ! background flow speed [m/s]
    
    real, dimension(grid_size) :: h
    
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
    call set_gaussian(h, icenter, decay)
    
    ! Writes the initial water height values to the terminal 
    print *, 0, h
    
    ! Begins the time loop
    time_loop: do n = 1, num_time_steps
        h = h - c * diff(h) / dx * dt
        print *, n, h
    end do time_loop
    
contains
    
    pure function diff(x) result(dx)
        real, intent(in)         :: x(:)
        real, dimension(size(x)) :: dx
        integer :: im
        im = size(x)
        dx(1) = x(1) - x(im)
        dx(2:im) = x(2:im) - x(1:im-1)
    end function diff
    
    pure subroutine set_gaussian(x, icenter, decay)
        real, intent(in out) :: x(:)
        integer, intent(in)  :: icenter
        real, intent(in)     :: decay
        integer              :: i
        do concurrent(i = 1:size(x))
            x(i) = exp(-decay * (i - icenter)**2)
        end do
    end subroutine set_gaussian
        
end program tsunami