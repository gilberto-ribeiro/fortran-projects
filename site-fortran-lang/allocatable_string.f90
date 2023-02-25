program allocatable_string
    ! https://fortran-lang.org/en/learn/quickstart/arrays_strings/

    implicit none

    character(:), allocatable :: first_name
    character(:), allocatable :: last_name

    allocate(character(len=8) :: first_name)
    first_name = 'Gilberto'

    last_name = 'Ribeiro'

    print *, first_name//' '//last_name

end program allocatable_string