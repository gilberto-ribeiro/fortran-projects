module mod_diff

    use iso_fortran_env, only: int32, real32
    implicit none

contains

    pure function diff(x) result(dx)
        real(kind=real32), intent(in) :: x(:)
        real(kind=real32), dimension(size(x)) :: dx
        integer(kind=int32) :: im
        im = size(x)
        dx(1) = x(1) - x(im)    
        dx(2:im) = x(2:im) - x(1:im-1)
    end function diff

end module mod_diff