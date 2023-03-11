program qn

    use iso_fortran_env, only: stdin => input_unit, &
                               stdout => output_unit, &
                               stderr => error_unit

    implicit none

    integer :: fileunit, stat
    character(len=9999) :: filename, text
    character(len=6) :: pos

    if (command_argument_count() < 1) stop 'Usage: qn <filename>'
    call get_command_argument(1, filename)
    call check_file(filename, pos)

    open(newunit=fileunit, file=trim(filename), &
         action='write', position=pos)

    do
        read(unit=stdin, fmt='(a)', iostat=stat, err=100) text
        if (trim(text) == 'exit') exit
        write(unit=fileunit, fmt='(a)', iostat=stat, err=100) trim(text)
        flush(fileunit, iostat=stat, err=100)
    end do

    100 close(fileunit)
    if (stat > 0) then
        write(stderr, '(a, i3)') &
            'Error encountered, code = ', stat
            stop
    end if

    contains

    subroutine check_file(filename, pos)
        character(len=9999), intent(in) :: filename
        character(len=9999) :: text
        character(len=6), intent(out) :: pos
        logical :: file_exists
        pos = 'rewind'
        inquire(file=trim(filename), exist=file_exists)
        if (file_exists) then
            write(unit=stdout, fmt='(a)') 'File ' // trim(filename) // ' already exists'
            do
                write(unit=stdout, fmt='(a)', advance='no') '[O]verwrite, [A]ppend, [Q]uit: '
                read(unit=stdin, fmt='(a)') text
                if (any(trim(text) == ['O', 'o'])) then
                    write(stdout, '(a)') 'Overwiting ' // trim(filename)
                    exit
                end if
                if (any(trim(text) == ['A', 'a'])) then
                    write(stdout, '(a)') 'Appending to ' // trim(filename)
                    pos = 'append'
                    exit
                end if
                if (any(trim(text) == ['Q', 'q'])) then
                    stop 'Closing application'
                end if
            end do
        else
            write(stdout, '(a)') 'Creating file ' // trim(filename)
        end if
    end subroutine check_file

end program qn