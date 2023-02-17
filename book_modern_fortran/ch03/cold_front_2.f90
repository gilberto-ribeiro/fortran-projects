program cold_front_2
    
    implicit none
    
    real, parameter :: dx = 960, c = 20
    real :: dt(8)
    
    dt = [6, 12, 18, 24, 30, 36, 42, 48]
    
    print *, cold_front_temperature(12., 24., c, dx, dt)

contains

    real pure elemental function cold_front_temperature(temp1, temp2, c, dx, dt) &
        result(res)
        real, intent(in) :: temp1, temp2, c, dx, dt
        ! real :: res
        res = temp2 - c * (temp2 - temp1) / dx * dt
    end function cold_front_temperature
    
end program cold_front_2
