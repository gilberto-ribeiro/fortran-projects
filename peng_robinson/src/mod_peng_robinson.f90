module mod_peng_robinson
    
    use iso_fortran_env, only: int32, real32, real64

    implicit none

    private
    public :: compressibility_factor, print_z_p

    real(real32), parameter :: R = 8.3145

contains

    pure function compressibility_factor(T, P, critical_constants, Z_est) result(Z)
    ! Function that determines the compressibility factor according to Peng-Robinson.
        real(real32), intent(in) :: T, P, critical_constants(3)
        real(real64), intent(in) :: Z_est
        real(real32) :: Tc, Pc, omega, Tr, kappa, alpha, a_Tc, b_Tc, a, b, AA, BB
        real(real64) :: Z, coeff(2)
        Tc = critical_constants(1)
        Pc = critical_constants(2)
        omega = critical_constants(3)
        Tr = T / Tc
        kappa = 0.37464 + 1.54226 * omega - 0.26992 * omega**2
        alpha = (1 + kappa * (1 - sqrt(Tr)))**2
        a_Tc = 0.45724 * (R**2 * Tc**2) / Pc
        b_Tc = 0.07780 * (R * Tc) / Pc
        a = a_Tc * alpha
        b = b_Tc
        AA = (a * P) / (R**2 * T**2)
        BB = (b * P) / (R * T)
        coeff = [AA, BB]
        Z = newton_rhapson(Z_est, coeff, 1e-8, 100)
    end function compressibility_factor
    
    pure function equation_of_state(Z, coeff) result(f)
    ! Equation of state used to calculate the compressibility factor according to
    ! Peng-Robinson.
        real(real64), intent(in) :: Z, coeff(2)
        real(real64) :: A, B
        real(real64) :: f
        A = coeff(1)
        B = coeff(2)
        f = Z**3 - (1 - B) * Z**2 + (A - 3 * B**2 - 2 * B) * Z - (A * B - B**2 - B**3)
    end function equation_of_state
    
    pure function derivative_equation_of_state(Z, coeff) result(df)
    ! Derivative of the equation of state used to calculate the compressibility
    ! factor according to Peng-Robinson.
        real(real64), intent(in) :: Z, coeff(2)
        real(real64) :: A, B
        real(real64) :: df
        A = coeff(1)
        B = coeff(2)
        df = 3 * Z**2 - 2 * (1 - B) * Z + (A - 3 * B**2 - 2 * B)
    end function derivative_equation_of_state

    pure function newton_rhapson(x_est, coeff, tol_max, i_max) result(x)
    ! Calculates de zero of the equation of state using Newton-Rhapson method.
        integer(int32), intent(in) :: i_max
        real(real32), intent(in) :: tol_max
        real(real64), intent(in) :: x_est, coeff(2)
        real(real64) :: x, x_past, f, df, tol
        integer(int32) :: i
        x = x_est
        do i = 1, i_max
            x_past = x
            f = equation_of_state(x, coeff)
            df = derivative_equation_of_state(x, coeff)
            x = x - f / df
            tol = abs((x - x_past) / x_past)
            if (tol <= tol_max) exit
        end do
    end function newton_rhapson

    subroutine print_z_p(T, P, critical_constants, Z_est, reduced)
    ! Subroutine that prints out the compressibility factor given an array of pressures
    ! and an array of temperatures.
        real(real32), allocatable, intent(in out) :: T(:), P(:)
        real(real32), dimension(3), intent(in) :: critical_constants
        real(real64), intent(in) :: Z_est
        logical, intent(in), optional :: reduced
        real(real64), allocatable :: z(:)
        real(real32) :: corr
        integer(int32) :: i, j
        corr = 1
        if (present(reduced)) then
            if (reduced) then
                T = critical_constants(1) * T
                P = critical_constants(2) * P
                corr = critical_constants(2)
            end if
        end if
        z = [(0, i = 1, size(T))]
        do j = 1, size(P)
            do i = 1, size(T)
                z(i) = compressibility_factor(T(i), P(j), critical_constants, Z_est)
            end do
            print *, P(j) / corr, z 
        end do
    end subroutine print_z_p

end module mod_peng_robinson

!Working fine