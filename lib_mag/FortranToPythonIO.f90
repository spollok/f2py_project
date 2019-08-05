module FortranToPythonIO

use DemagFieldGetSolution
implicit none

contains

subroutine hello_world( tileType, rect_size, result, result_array )
    integer,intent(in) :: tileType
    real,dimension(3),intent(in) :: rect_size
    integer,intent(out) :: result
    real,dimension(3),intent(out) :: result_array
    print*, "Hello from the Fortran subroutine!"
    print*, tileType
    print*, rect_size(1), rect_size(2), rect_size(3)
    result = tileType + 1
    result_array = rect_size
    result_array(1) = 18
    result_array(2) = tileType
end subroutine


subroutine getNFromTile( centerPos, dev_center, rect_size, Mag, u_ea, u_oa1, u_oa2, mu_r_ea, mu_r_oa, Mrem, tileType, offset, rotAngles, color, magnetType, stateFunctionIndex, includeInIteration, exploitSymmetry, symmetryOps, Mrel, H, pts, n_ele, N )
    !::Specific for a cylindrical tile piece
    real,dimension(3),intent(in) :: centerPos
    real,dimension(3),intent(in) :: dev_center
        
    !::Specific for a rectangular prism
    real,dimension(3),intent(in) :: rect_size
        
    !::Generel variables, shared among all tile types
    real,dimension(3),intent(in) :: Mag
    real,dimension(3),intent(in) :: u_ea,u_oa1,u_oa2    
    real,intent(in) :: mu_r_ea,mu_r_oa,Mrem
    integer,intent(in) :: tileType        !::defines whether the tile is cylindrical, a prism, an ellipsoid and so on
    real,dimension(3),intent(in) :: offset !::the centre coordinates relative to the global coordinate system
    real,dimension(3),intent(in) :: rotAngles !:: rotation angles (phi_x, phi_y, phi_z) about the principle axes of the tile with respect to the centre of the tile
    real,dimension(3),intent(in) :: color !! color rgb triplet
    integer,intent(in) :: magnetType !::defines whether the tile is a hard or soft magnet
    integer,intent(in) :: stateFunctionIndex !::index matching an entry into an array of type MagStateFunction. Used by soft ferromagnets (when interpolation on an M vs H curve is necessary)
    integer,intent(in) :: includeInIteration,exploitSymmetry
    real,dimension(3),intent(in) :: symmetryOps !! 1 for symmetry, -1 for anti-symmetry ((1) for about xy plane, (2) for about (xz) plane and (3) for about yz plane)
    real,intent(in) :: Mrel !! the current relative change of the magnetization (i.e. abs((M1-M2)/M2 ) where M1 is the latest magnetization norm and M2 is the previous one

    real,dimension(n_ele,3),intent(in) :: pts
    real,dimension(n_ele,3),intent(out) :: H
    real,dimension(1,n_ele,3,3),intent(out) :: N
    type(MagTile),dimension(:),allocatable :: tile
    integer,intent(in) :: n_ele

    !::initialise MagTile with specified parameters
    allocate(tile(1))

    tile(1)%r0 = centerPos(1)
    tile(1)%theta0 = centerPos(2)
    tile(1)%z0 = centerPos(3)
    tile(1)%dr = dev_center(1)
    tile(1)%dtheta = dev_center(2)
    tile(1)%dz = dev_center(3)
    tile(1)%a = rect_size(1)
    tile(1)%b = rect_size(2)
    tile(1)%c = rect_size(3)
    tile(1)%M = Mag
    tile(1)%u_ea = u_ea
    tile(1)%u_oa1 = u_oa1
    tile(1)%u_oa2 = u_oa2
    tile(1)%mu_r_ea = mu_r_ea
    tile(1)%mu_r_oa = mu_r_oa
    tile(1)%Mrem = Mrem
    tile(1)%tileType = tileType
    tile(1)%offset = offset
    tile(1)%rotAngles = rotAngles
    tile(1)%color = color
    tile(1)%magnetType = magnetType
    tile(1)%stateFunctionIndex = stateFunctionIndex
    tile(1)%includeInIteration = includeInIteration
    tile(1)%exploitSymmetry = exploitSymmetry
    tile(1)%symmetryOps = symmetryOps
    tile(1)%Mrel = Mrel

    !call loadMagTile(tile(1), centerPos, dev_center, rect_size, Mag, u_ea, u_oa1, u_oa2, mu_r_ea, mu_r_oa, Mrem, tileType, offset, rotAngles, color, magnetType, stateFunctionIndex, includeInIteration, exploitSymmetry, symmetryOps, Mrel )

    !::do the calculation
    N(:,:,:,:) = 0
    H(:,:) = 0      
    ! if ( tile(1)%tileType .eq. tileTypeCylPiece ) then
    !     call getFieldFromCylTile( tile(1), H, pts, n_ele, N, .false. )
    ! else if (tile(1)%tileType .eq. tileTypeCircPiece ) then          
    !     call getFieldFromCircPieceTile( tile(1), H, pts, n_ele, N, .false. )
    ! else if (tile(1)%tileType .eq. tileTypeCircPieceInverted ) then          
    !     call getFieldFromCircPieceInvertedTile( tile(1), H, pts, n_ele, N, .false. )
    ! else if (tile(1)%tileType .eq. tileTypePrism ) then          
    !     call getFieldFromRectangularPrismTile( tile(1), H, pts, n_ele, N, .false. )
    ! endif

end subroutine getNFromTile

end module FortranToPythonIO
