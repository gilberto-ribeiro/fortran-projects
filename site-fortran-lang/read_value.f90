program read_value
    ! https://fortran-lang.org/en/learn/quickstart/variables/

    implicit none

    integer :: age

    print *, 'Please, enter your age:'
    read(*,*) age
    print *, 'Your age is: ', age

end program read_value