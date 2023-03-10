program read_write_list

    use iso_fortran_env, only: int32, real32

    implicit none

    character(len=1000) :: text
    integer(int32) :: i
    real(real32) :: r
    real, dimension(5) :: m

    read *, text, i, r, m
    print *, 'User wrote:', i, r, trim(text)
    print *, m

end program read_write_list