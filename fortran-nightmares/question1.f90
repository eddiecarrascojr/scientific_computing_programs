PROGRAM question1
character(len=7) :: name
name = "bruno w"
IF (name == "bruno w") THEN
	print *,'|'//name//'|'
    print *,'|'//adjustl(name)//'|'
    print *,'|'//adjustr(name)//'|'
    print *,'|'//trim(name)//'|'
END IF
END PROGRAM question1