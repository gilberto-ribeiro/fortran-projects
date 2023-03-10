program echo_robot

    use iso_fortran_env, only: int32, real32

    implicit none

    character(len=1000) :: text

    read '(a)', text
    print '(a)', trim(text)

end program echo_robot