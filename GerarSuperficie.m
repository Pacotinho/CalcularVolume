function [x,y,z] = GerarSuperficie(lim_u,lim_v,f,COMPLEXIDADE)
    for i = 0:COMPLEXIDADE
        for j = 0:COMPLEXIDADE
            [x(i+1+j*(COMPLEXIDADE+1)),y(i+1+j*(COMPLEXIDADE+1)),z(i+1+j*(COMPLEXIDADE+1))]...
                = f(2*pi/COMPLEXIDADE*i,pi/COMPLEXIDADE*j);           
        end
    end
end

