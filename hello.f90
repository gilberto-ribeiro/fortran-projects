program hello
    
    implicit none
    
    character(len=100) :: name
    integer :: age
    
    ! Pergunta pelo nome.
    print *, 'What is your name? How old are you?'
    read *, name, age
    
    ! Imprime mensagens no terminal.
    print *, 'Hello World, my name is ', trim(name), '.'
    print *, 'Hello ', trim(name), ', my name is World.'
    print *, 'You were born in', 2023 - age, '.'
    
end program hello