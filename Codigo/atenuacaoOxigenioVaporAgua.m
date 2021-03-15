function [AtenuacaoVaporAgua, AtenuacaoOxi] = atenuacaoOxigenioVaporAgua(freq, pressao, temperatura, humidade, distancia)

    distancia = distancia * 10^3;
    rp = pressao/1013;
    rt = 288/(273+temperatura);
    es = 6.1121*exp((17.502*temperatura)/(240.97+temperatura));
    e = (humidade*es)/100;
    ro = 216.7*(e/(temperatura+273.3));

    AtenuacaoVaporAgua = ((((3.27*10^-2)*rt)+(1.67*10^-3)*ro*((rt^7)/rp)+(7.7*10^-4*freq^0.5))+(3.79/(((freq-22.235)^2)+(9.81*(rp^2)*rt)))+((11.73*rt)/(((freq-183.31)^2)+(11.85*(rp^2)*rt)))+((4.01*rt)/(((freq-325.153)^2)+(10.44*(rp^2)+rt))))*((freq^2)*ro*rp*rt*(10^-4));

    g0_57=(((7.27*rt)/(57^2+0.35*rp^2*rt^2))+7.5/(((57-57)^2)+2.44*rp^2*rt^2))*(57^2)*(rp^2)*(rt^2)*(10^-3);
    g0_63=((2*10^-4)*(rt^1.5)*(1-1.2*10^-5*63^1.5)+(4/(((63-63)^2)+(1.5*(rp^2)*(rt^5))))+((0.28*rt^2)/(((63-118.75)^2)+(2.84*(rp^2)*(rt^2)))))*63^2*rp^2*rt^2*10^-3;
    
    if(freq <= 57)
        AtenuacaoOxi = (((7.27*rt)/(freq^2+0.35*rp^2*rt^2))+7.5/(((freq-57)^2)+2.44*rp^2*rt^2))*(freq^2)*(rp^2)*(rt^2)*(10^-3);

    elseif((freq>57) && (freq<63))
        AtenuacaoOxi = ((((freq-60)*(freq-63))/18)*g0_57)-1.66*(rp^2)*(rt^8.5)*(freq-57)*(freq-63)+((((freq-57)*(freq-60))/18)*g0_63);

    elseif ((freq>=63)&&(freq<350))
        AtenuacaoOxi = ((2*10^-4)*(rt^1.5)*(1-1.2*10^-5*freq^1.5)+(4/(((freq-63)^2)+(1.5*(rp^2)*(rt^5))))+((0.28*rt^2)/(((freq-118.75)^2)+(2.84*(rp^2)*(rt^2)))))*freq^2*rp^2*rt^2*10^-3;
    
    end
        
    AtenuacaoOxi = AtenuacaoOxi * distancia;
    AtenuacaoVaporAgua = AtenuacaoVaporAgua * distancia;
end
