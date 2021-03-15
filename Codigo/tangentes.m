function [tangenteE, tangenteR] = tangentes(d,he,hr)
    
    d = d * 10^3;
    x = 0:100:d;
    r0 = 6370e3;
    mE = d/(2*r0);
    bE = he -((d^2)/(8*r0));
    mR = -d/(2*r0);
    bR = ((3/8)*((d^2)/r0)) + hr;
    
    tangenteE = mE.*x + bE;
    tangenteR = mR.*x + bR;

end
