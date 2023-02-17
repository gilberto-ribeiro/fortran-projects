program test
    
    use iso_fortran_env, only: int32, real32
    use mod_circle, only: circle_area
    
    implicit none

    real(kind=real32), dimension(4) :: radio, area
    integer(int32) :: i

    radio = [1, 2, 3, 4]
    area = circle_area(radio)
    
    do i = 1, size(radio)
        print *, 'Radio: ', radio(i), ' | Area: ', area(i)
    end do


end program test