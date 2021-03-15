function [difracao] = atenuacaoDifracao(polarizacao, he, hr, d, freq, terreno)
    
    freq = freq*10^9;

    r0 = 6370*10^3;

    d = d*10^3;

    lambda = comprimentoOnda(freq);

    k = 0;
    e = 0;
    sigma = 0;

    if(strcmp(terreno,'agua'))
        e = 81;
        sigma = 5;
    elseif(strcmp(terreno,'terreno'))
        e = 15;
        sigma = 0.005;
    end

    kh = (((2*pi*r0)/lambda)^(-1/3))*(((e-1)^2)+((60*lambda*sigma)^2))^(-1/4);

    kv = kh*sqrt((e^2)+((60*lambda*sigma)^2));

    if(strcmp(polarizacao,'horizontal'))
        k = kh;
    elseif(strcmp(polarizacao,'vertical'))
        k = kv;
    end

    beta = (1+1.6*(k^2)+0.75*(k^4))/(1+4.5*k^2+1.35*k^4);

    x = beta*d*(pi/(lambda*r0^2))^(1/3);

    y1 = 2*beta*he*((pi^2)/(lambda^2*r0))^(1/3);

    y2 = 2*beta*hr*((pi^2)/(lambda^2*r0))^(1/3);

    fx = 11+10*log10(x)-17.6*x;

    if(y1>=2)
        gy1 = 17.6*sqrt(y1-1.1)-5*log10(y1-1.1)-8;
    elseif(y1<2 && y1>10*k)
        gy1 = 20*log10(y1+y1^3);
    elseif(y1<10*k && y1>k/10)
        gy1 = 2+20*log10(k)+9*log10(y1/k)*(log10(y1/k)+1);
    elseif(y1<k/10)
        gy1 = 2+20*log10(k);
    end

    if(y2>=2)
        gy2 = 17.6*sqrt(y2-1.1)-5*log10(y2-1.1)-8;
    elseif(y2<2 && y2>10*k)
        gy2 = 20*log10(y2+y2^3);
    elseif(y2<10*k && y2>k/10)
        gy2 = 2+20*log10(k)+9*log10(y2/k)*(log10(y2/k)+1);
    elseif(y2<k/10)
        gy2 = 2+20*log10(k);
    end

    difracao = -(fx+gy1+gy2);

end