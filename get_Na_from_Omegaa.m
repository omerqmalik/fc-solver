function Na = get_Na_from_Omegaa(Omegaa,n)
    Deltap = get_RING_Deltap(n);
    Na = round(Omegaa/real(Deltap));
end