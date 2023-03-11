program redirect_stdout_to_file

    use iso_fortran_env, only: stdin => input_unit, &
                               stdout => output_unit, &
                               stderr => error_unit

    implicit none

    integer :: log_out
    character(len=1000) :: text

    open(newunit=log_out, file='log_output.txt')
    open(unit=stderr, file='log_error.txt')

    read(unit=stdin, fmt='(a)') text
    write(unit=stdout, fmt='(a)') 'Output: ' // trim(text)
    write(unit=log_out, fmt='(a)') 'LOG Output: ' // trim(text)
    write(unit=stderr, fmt='(a)') 'This is an error message'

end program redirect_stdout_to_file