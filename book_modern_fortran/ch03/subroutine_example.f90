program subroutine_example
    implicit none
    integer :: a = 0
    call add(a, 1)
    print *, a
    call add(a, 2)
    print *, a
    contains
    subroutine add(a, b)
        integer, intent(in out) :: a
        integer, intent(in)     :: b
        a = a + b
    end subroutine
end program subroutine_example
