module mod_alloc

    use iso_fortran_env, only: int32, real32

    implicit none

    private
    public :: reverse

contains

    subroutine alloc(array, n)
        real(real32), allocatable, intent(in out) :: array(:)
        integer(int32), intent(in) :: n
        integer :: stat
        character(len=100) :: errmsg
        if (allocated(array)) call free(array)
        allocate(array(n), stat=stat, errmsg=errmsg)
        if (stat > 0) error stop errmsg
    end subroutine alloc

    subroutine free(array)
        real(real32), allocatable, intent(in out) :: array(:)
        integer :: stat
        character(len=100) :: errmsg
        if (.not. allocated(array)) return
        deallocate(array, stat=stat, errmsg=errmsg)
        if (stat > 0) error stop errmsg
    end subroutine free

    pure function reverse(array)
        real(real32), allocatable, intent(in) :: array(:)
        real(real32), allocatable :: reverse(:)
        integer(int32) :: n
        n = size(array)
        allocate(reverse(n))
        reverse = array(n:1:-1)
    end function reverse

end module mod_alloc