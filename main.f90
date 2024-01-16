! +--------------------------------------------+
! | Author: Jose Antonio Quinonero Gris        |
! | Creation date: Tuesday 09:09:29 16/01/2024 |
! +--------------------------------------------+
program huckel
    !
    ! Program to return the Atomic Orbital (AO) basis centered at the origin
    ! of the element of given atomic number, Z, in terms of the primitive
    ! spherical-harmonic GTOs
    !
    ! Modules
    use declarations
    use strings
    use IO
    use huckel_theory
    !
    implicit none
    !
    ! === START OF THE PROGRAM ===
    !
     
    ! Initialize the parameters
    call parameters

    ! Open files
    ! call open_files

    ! Print the title
    call title(6, 'Program AOs', termwidth)
    call title(ouf, 'Program AOs', termwidth)

    ! ! Print input information
    ! call print_input(6)
    ! write(ouf,*)
    ! write(ouf,'(a, i0)') 'Basis functions for Z = ', Z
    ! write(ouf,*)
    !
    ! ! Find the basis functions for the given element (Z)
    ! call find_Z(uf, Z, line)
    !
    ! ! Skip first line
    ! read(uf,*) 
    !
    ! dl1: do
    !     ! Read type of function
    !     call func_type(uf)
    !     if (keep == 0) exit dl1 
    !
    !     ! Read the exponents and coefficients for the AOs
    !     call read_funcs(uf)
    !
    !     ! Print the output
    !     call print_output(ouf)
    !     if (trim(screen) .eq. 'Y' .or. trim(screen) .eq. 'y') then 
    !         call print_output(6)
    !     end if
    !
    !     ! Deallocate the arrays
    !     deallocate(as, ds)
    ! end do dl1
    !
    ! write(*,*)
    ! write(*,'(a)') 'Results written to data/output.txt'

    !
    stop
endprogram huckel
