program hello
    
    implicit none
    
    character(len=100) :: name
    
    print *, 'What is your name?'
    read *, name
    
    print *, 'Hello World, my name is ', trim(name)
    
end program hello
