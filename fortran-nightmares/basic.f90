module basic
use working_precision

interface swap
    module procedure iswap, rswap
end interface

contains

function outer_product(u,v) result(op)
implicit none
real(wp), intent(in) :: u(:),v(:)
real(wp) :: op(size(u),size(v))
op = spread(u,2,size(v))*spread(v,1,size(u))
end function outer_product

subroutine iswap(a,b)
implicit none
integer, intent(inout) :: a,b
integer :: dummy
dummy = a; a = b; b = dummy
end subroutine iswap

elemental subroutine rswap(a,b)
implicit none
real(wp), intent(inout) :: a,b
real(wp) :: dummy
dummy = a; a = b; b = dummy
end subroutine rswap

end module basic
