function [x, y, z] = GerarPontosAleatorios(max,min, qtd_pontos)
%{
---------------------------------------------------------------------------
   Essa função gera uma nuvem de pontos aleatórios sobre um espaço 3d. Os
   pontos tem distribuição de probabilidade uniforme.

   Input:
    - intervalo: inteiro. é o tamanho do intervalo sobre a qual quer se
                 gerar os pontos aleatórios.
    - qtd_pontos: inteiro. é a quantidade de pontos aleatórios que se quer
                  gerar
    
    Output:
    - x: array de float. coordenadas x dos pontos
    - y: array de float. coordenadas y dos pontos
    - z: array de float. coordenadas z dos pontos
%}
    for i = 1:qtd_pontos
        x(i,1) = rand*(max-min) + min; % rand retorna um número entre [0,1]
        y(i,1) = rand*(max-min) + min; % portanto é necessário multiplicar por 
        z(i,1) = rand*(max-min) + min; % intervalo para que as coordenadas variem
    end                        % no intervalo dado
end

