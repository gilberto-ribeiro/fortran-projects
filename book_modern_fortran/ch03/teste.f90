program teste

    implicit none

    real :: res
    real :: a = 4

    call add(a, 3., res, c=7., debug=.true.)
    print *, res

    contains

    subroutine add(a, b, res, debug, c)
        real, intent(in) :: a, b
        real, intent(out) :: res
        logical, intent(in), optional :: debug
        real, intent(in), optional :: c
        if (present(c)) then
            res = (a + b) * c
        else
            res = a + b
        end if
        if (present(debug)) then
            if (debug) then
                call debug_msg('a', a)
                call debug_msg('b', b)
                call debug_msg('res', res)
            end if
        end if
    end subroutine add

    subroutine debug_msg(str, val)
        character, intent(in) :: str
        real, intent(in) :: val
        print *, 'DEBUG: subroutine add, ', str, ' = ', val
    end subroutine debug_msg

end program teste
