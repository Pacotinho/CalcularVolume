complexidade = 100;
for i = 0:complexidade
        for j = 0:complexidade
            [x(i+1+j*(complexidade+1)),y(i+1+j*(complexidade+1)),z(i+1+j*(complexidade+1))]...
                = f(2*pi/complexidade*i,pi/complexidade*j);           
        end
 end