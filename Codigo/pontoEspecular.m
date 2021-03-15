function [ponto, fact_div]=pontoEspecular(modelo, d,he, hr,k)

syms equ r t;
r0 = 6370*10^3*k;
d = d*10^3;

if (strcmp(modelo,'terra plana'))
    ponto = (he /(he+hr))*d/10^3;
    fact_div = 1;
else
    equ = 'u^3 - 1.5*u^2+ (0.5 - t*(r+1))*u + t = 0';
    equ = subs(equ, r, hr/he);    
    equ = subs(equ, t, (r0*he)/(d^2));
    u = solve(equ);
        
    for i=1:3
        %ponto_act = double(u(i))*d;
        ponto_act = round(double(u(i)),5)*d;
        if(isreal(ponto_act) && ponto_act > 0 && ponto_act < d)
            ponto = ponto_act/10^3;
            fact_div = 1/(sqrt(1+((2*u(i)^2*(1-u(i))))/(t*(1-(u(i)^2/(2*t))))));
            fact_div = subs(fact_div,t,(r0*he)/(d^2));
        end
    end
    
end
end
    