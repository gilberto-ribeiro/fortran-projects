program string
    ! https://fortran-lang.org/en/learn/quickstart/arrays_strings/

    implicit none

    character(len=8) :: first_name
    character(len=7) :: last_name
    character(16) :: full_name

    first_name = 'Gilberto'
    last_name = 'Ribeiro'

    full_name = first_name//' '//last_name

    print *, full_name

end program string