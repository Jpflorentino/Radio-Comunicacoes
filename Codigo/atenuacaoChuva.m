function [atenuacaoChuva, atenuacaoChuvaPercentagem] = atenuacaoChuva(f, zona, percentagem, polarizacao, d, pm)

    freq=[1,2,4,6,7,8,10,12,15,20,25,30,35,40,45,50,60,70,80,90,100,120,150,200,300,400];
    freqghz=freq;
    KH=[0.0000387,0.000154,0.000650,0.00175,0.00301,0.00454,0.0101,0.0188,0.0367,0.0751,0.124,0.187,0.263,0.350,0.442,0.536,0.707,0.851,0.975,1.06,1.12,1.18,1.31,1.45,1.36,1.32];
    KV=[0.0000352,0.000138,0.000591,0.00155,0.00265,0.00395,0.00887,0.0168,0.0335,0.0691,0.113,0.167,0.233,0.310,0.393,0.479,0.642,0.784,0.906,0.999,1.06,1.13,1.27,1.42,1.35,1.31];
    alfaH=[0.912,0.963,1.121,1.308,1.332,1.327,1.276,1.217,1.154,1.099,1.061,1.021,0.979,0.939,0.903,0.873,0.826,0.793,0.769,0.753,0.743,0.731,0.710,0.689,0.688,0.683];
    alfaV=[0.880,0.923,1.075,1.265,1.312,1.310,1.264,1.200,1.126,1.065,1.030,1.000,0.963,0.929,0.897,0.868,0.824,0.793,0.769,0.754,0.744,0.732,0.711,0.690,0.689,0.684];
    
    kh = 0;
    kv = 0;
    alfah = 0;
    alfav = 0;

    for i=1 : length(freq)
        if(f>=freqghz(i))
            if(f==freqghz(i))
                kh = KH(i);
                kv = KV(i);
                alfah = alfaH(i);
                alfav = alfaV(i);
                break;
            end
        else
            kv=10^(log10(KV(i-1))+((log10(KV(i))-log10(KV(i-1)))/(log10(freqghz(i))-log10(freqghz(i-1))))*(log10(f)-log10(freqghz(i-1))));
            kh=10^(log10(KH(i-1))+((log10(KH(i))-log10(KH(i-1)))/(log10(freqghz(i))-log10(freqghz(i-1))))*(log10(f)-log10(freqghz(i-1))));
            alfah=alfaH(i-1)+((alfaH(i)-alfaH(i-1))/(log(freqghz(i))-log(freqghz(i-1))))*(log(f)-log(freqghz(i-1)));
            alfav=alfaH(i-1)+((alfaH(i)-alfaH(i-1))/(log(freqghz(i))-log(freqghz(i-1))))*(log(f)-log(freqghz(i-1)));
            break;
        end
    end

    if(strcmp(zona,'K'))
        ri = 32;
    elseif (strcmp(zona,'H'))
        ri = 42;
    end

    if(strcmp(polarizacao,'horizontal'))
        gamaR = kh*(ri^alfah);
    elseif (strcmp(polarizacao,'vertical'))
        gamaR = kv*(ri^alfav);
    end

    distanciaEficaz = d/(1+(d/35*exp(-0.015*ri)));

    if(percentagem == 1)
        atenuacaoChuva = gamaR * distanciaEficaz;
    else
        atenuacaoChuva = (gamaR * distanciaEficaz) * 0.12 * (percentagem)^(-(0.546 + 0.043 * log10(percentagem)));
    end
    
    pm = 0.3 * (pm)^1.15;
    atenuacaoChuvaPercentagem = (gamaR * distanciaEficaz) * 0.12 * (pm)^((-(0.546 + 0.043 * log10(pm))));

end