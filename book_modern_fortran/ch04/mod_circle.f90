module mod_circle

    use iso_fortran_env, only: real32
    implicit none

    private :: pi
    public :: circle_area

    real(real32), parameter :: pi = 3.14159265358

contains

    pure elemental function circle_area(r) result (a)
        real(real32), intent(in) :: r
        real(real32) :: a
        a = pi * r**2
    end function circle_area

end module mod_circle