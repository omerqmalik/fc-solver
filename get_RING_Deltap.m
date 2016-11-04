function Deltap = get_RING_Deltap(n)
    %w_FSR (unitless, w_FSR/L/c)
    Deltap = 2*pi/n;
%     Deltap = 2*pi*(real(n) - 1i*imag(n))/(real(n)^2 + imag(n)^2)/L;
%     Deltap = 2*pi/real(n)/L;
end