program standard_streams

    use iso_fortran_env, only: stdin => input_unit, &
                               stdout => output_unit, &
                               stderr => error_unit

    implicit none

    character(len=1000) :: text

    read(unit=stdin, fmt='(a)') text
    write(unit=stdout, fmt='(a)') trim(text)
    write(unit=stderr, fmt='(a)') 'This is an error message'

end program standard_streams