module mod_arrays

    use iso_fortran_env, only: int32, real32

    implicit none

    public

contains

    pure real function average(x)
        real(real32), intent(in) :: x(:)
        average = sum(x) / size(x)
    end function average

    pure real function std(x)
        real(real32), intent(in) :: x(:)
        std = sqrt(average((x - average(x))**2))
    end function std

    pure function moving_average(x, w)
        real(real32), intent(in) :: x(:)
        integer(int32), intent(in) :: w
        real(real32) :: moving_average(size(x))
        integer(int32) :: i, ib
        do i = 1, size(x)
            ib = max(1, i - w)
            moving_average(i) = average(x(ib:i))
        end do
    end function moving_average

    pure function moving_std(x, w)
        real(real32), intent(in) :: x(:)
        integer(int32), intent(in) :: w
        real(real32) :: moving_std(size(x))
        integer(int32) :: i, ib
        do i = 1, size(x)
            ib = max(1, i - w)
            moving_std(i) = std(x(ib:i))
        end do
    end function moving_std

    pure function crosspos(x, w) result(res)
        real(real32), intent(in) :: x(:)
        integer(int32), intent(in) :: w
        integer, allocatable :: res(:)
        logical, allocatable :: greater(:), smaller(:)
        integer(int32) :: i
        res = [(1, i = 2, size(x))]
        greater = x > moving_average(x, w)
        smaller = x < moving_average(x, w)
        res = pack(res, greater(2:) .and. smaller(:size(x)-1))
    end function crosspos

    pure function crossneg(x, w) result(res)
        real(real32), intent(in) :: x(:)
        integer(int32), intent(in) :: w
        integer, allocatable :: res(:)
        logical, allocatable :: greater(:), smaller(:)
        integer(int32) :: i
        res = [(1, i = 2, size(x))]
        greater = x > moving_average(x, w)
        smaller = x < moving_average(x, w)
        res = pack(res, smaller(2:) .and. greater(:size(x)-1))
    end function crossneg

    pure function reverse(x)
        real(real32), intent(in) :: x(:)
        real(real32) :: reverse(size(x))
        reverse = x(size(x):1:-1)
    end function reverse

end module mod_arrays
