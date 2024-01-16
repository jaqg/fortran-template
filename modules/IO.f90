! +--------------------------------------------+
! | Author: Jose Antonio Quinonero Gris        |
! | Creation date: Tuesday 09:11:35 16/01/2024 |
! +--------------------------------------------+
! +-------------------------------------------+
! | Author: Jose Antonio Quinonero Gris       |
! | Creation date: Monday 18:11:15 11/12/2023 |
! +-------------------------------------------+
module io 
    ! 
    ! Input/Output module
    !
    use declarations
    use strings
    use DALTON_basis_funcs
    !
    implicit none
    !
    contains

    subroutine parameters
        implicit none
        
        ! Width of the terminal/file to be written on
        termwidth = 46
        ! Threshold for a floating-point number to be considered zero
        thres = 1.0d-4  ! if x < thres then x = 0
        ! Auxiliar variable
        keep = 1
        ! Filename of the input file
        input_fl = 'data/6-31G.txt'

        return
    end subroutine parameters 

    subroutine open_files
        implicit none

        ! Input file
        uf = 100
        open(unit=uf, file=input_fl)

        ! Output file
        ouf = 101
        open(unit=ouf, file='data/output.txt')
        
        !
        return
    end subroutine open_files 

    subroutine print_input(ouf)
        implicit none
        integer, intent(in) :: ouf

        write(ouf,*)
        write(ouf,'(a)') 'Printing the basis functions for'
        write(ouf,'(a)') 'Z =' ; read(*,*) Z
        write(ouf,'(2a)') 'from the file ', trim(input_fl)
        write(ouf,*)
        write(ouf,'(a)') 'Print results in the screen? (Y/N)'
        read(*,*) screen

        return
    end subroutine print_input 

    subroutine print_output(ouf)
        implicit none
        integer, intent(in) :: ouf

        if (trim(orb) .eq. 's') then 
            call print_s_func(ouf)
        elseif (trim(orb) .eq. 'p') then 
            call print_p_func(ouf)
        elseif (trim(orb) .eq. 'd') then 
            call print_d_func(ouf)
        end if

        return
    end subroutine print_output 
end module io 
