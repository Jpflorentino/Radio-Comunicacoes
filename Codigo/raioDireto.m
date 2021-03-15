function [ Pd ] = raioDireto( Pt, gaR, gaE, freq, d )

    freqM = freq/(1000);
    Lfs = 32.4 + 20*log10(d) + 20*log10(freqM);
    Pd = Pt + gaE + gaR - Lfs;

end