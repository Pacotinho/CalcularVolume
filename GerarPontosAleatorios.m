function [x, y, z] = GerarPontosAleatorios(max,min, qtd_pontos)
%{
---------------------------------------------------------------------------
   Essa fun��o gera uma nuvem de pontos aleat�rios sobre um espa�o 3d. Os
   pontos tem distribui��o de probabilidade uniforme.

   Input:
    - intervalo: inteiro. � o tamanho do intervalo sobre a qual quer se
                 gerar os pontos aleat�rios.
    - qtd_pontos: inteiro. � a quantidade de pontos aleat�rios que se quer
                  gerar
    
    Output:
    - x: array de float. coordenadas x dos pontos
    - y: array de float. coordenadas y dos pontos
    - z: array de float. coordenadas z dos pontos
%}
    for i = 1:qtd_pontos
        x(i,1) = rand*(max-min) + min; % rand retorna um n�mero entre [0,1]
        y(i,1) = rand*(max-min) + min; % portanto � necess�rio multiplicar por 
        z(i,1) = rand*(max-min) + min; % intervalo para que as coordenadas variem
    end                        % no intervalo dado
end

