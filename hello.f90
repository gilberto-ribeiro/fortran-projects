program hello
    
    implicit none
    
    character(len=100) :: name
    
    ! Pergunta pelo nome.
    print *, 'What is your name?'
    read *, name
    
    ! Imprime mensagens no terminal.
    print *, 'Hello World, my name is ', trim(name), '.'
    print *, 'Hello ', trim(name), ', my name is World.'
    
end program hello