program cold_front
    
    implicit none
    
    integer :: n
    real, parameter :: dx = 960, c = 20
    real :: nhours, temp
    
    do n = 6, 48, 6
        nhours = real(n)
        temp = cold_front_temperature(12., 24., c, dx, nhours)
        print *, 'Temperature after ', nhours, ' hours is ', &
            temp, 'degrees.'
    end do
    
    contains
    
    function cold_front_temperature(temp1, temp2, c, dx, dt) result(res)
        real, intent(in) :: temp1, temp2, c, dx, dt
        real :: res
        res = temp2 - c * (temp2 - temp1) / dx * dt
    end function cold_front_temperature
    
end program cold_front
