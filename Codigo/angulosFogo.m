function [anguloFogoE, anguloFogoR] = angulosFogo(modelo, he, hr, d, k)

    d = d*10^3;
    r0 = 6370e3*k;

    if (strcmp(modelo,'terra plana'))
        %declive raio direto terra plana
        m = (hr-he)/d;
        if(m > 0)
            anguloFogoE = rad2deg(atan(m));
            anguloFogoR = -1*rad2deg(atan(m));
        elseif(m < 0)
            anguloFogoE = -1*rad2deg(atan(m));
            anguloFogoR = rad2deg(atan(m));
        else
            anguloFogoE = 0;
            anguloFogoR = 0;
        end
    else
        %declive raio direto terra esferica 
        hrEquivalente = -((d^2)/(2*r0)) + hr;
        m = (hrEquivalente-he)/d;
        if(m > 0)
            anguloFogoE = abs(rad2deg(atan(m))); 
        elseif(m < 0)
            anguloFogoE = abs(abs(rad2deg(atan(m)))); 
        else
            anguloFogoE = 0; 
        end

        %declive da reta tangente no recetor 
        m_tg = -d/r0;
        %ter dois angulos para somar ou subtrair
        ang1 = abs(rad2deg(atan(m)));
        ang2 = rad2deg(abs(atan(m_tg)));

        if(m<0)
            if(abs(m) < abs(m_tg))
                anguloFogoR = abs(ang2-ang1);
            elseif(abs(m) > abs(m_tg))
                anguloFogoR = ang2-ang1;
            else
                anguloFogoR = 0;
            end
        else
            anguloFogoR = abs((ang2+ang1));
        end
    end
end

