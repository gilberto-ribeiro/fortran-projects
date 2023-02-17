program test

    use iso_fortran_env, only: int32, real32
    use mod_alloc, only: reverse

    implicit none

    real, allocatable :: a(:), b(:)
    allocate(a(5))
    a = [5, 10, 15, 20, 25]
    b = reverse(a)
    print *, a
    print *, b

end program test