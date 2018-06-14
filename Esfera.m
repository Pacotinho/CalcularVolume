function [x,y,z] = Esfera(raio,complexidade)
    %Calcular volume de uma esfera
    tamanho_esfera = 1;
    volume = 0;
    qtd_secoes = 20;

    %criar matriz esfera
    for i = 0:complexidade
        for j = 0:complexidade
            x(i+1+j*(complexidade+1),1) = raio*sin((pi/complexidade)*j)*cos((2*pi/complexidade)*i);
            y(i+1+j*(complexidade+1),1) = raio*sin((pi/complexidade)*j)*sin((2*pi/complexidade)*i);
            z(i+1+j*(complexidade+1),1) = raio*cos((pi/complexidade)*j);
        end
    end
end