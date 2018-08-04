function [area] = CalcularAreaMC(x_figura,y_figura,...
    x_pontos_aleatorios, y_pontos_aleatorios)

%{  
    CalcularAreaMC
        Essa função calcula a area de uma figura plana usando o método de
        MC (Monte Carlo). Consiste em distribuir aleatoriamente pontos
        sobre uma figura de área conhecida (nesse casa um quadrado). A área
        da figura que se quer calcular é proporcinal à quantidade de pontos
        aleatórios que estiverem dentro da figura, ou seja:
    
        Área que se quer calcular = Área do quadrado *
        (qtd_pontos_dentro/qtd_pontos_aleatorios)
    
    Input:
    - x_figura: array de floats. Coordenadas x da figura
    - y_figura: array de floats. Coordenadas y da figura
    - x_pontos_aleatorios: array de floats. Coordenadas x dos pts
    aleatorios
    - y_pontos_aleatorios: array de floats. Coordenadas y dos pts
    aleatorios
    
    Output:
    - Area: float. area da figura
%}
    
    %definir lado do quadrado, o lado vai ser igual à maior dimensão da
    %figura, ou x ou y.
    if (max(x_pontos_aleatorios) - min(x_pontos_aleatorios))>=(max(y_pontos_aleatorios)-min(y_pontos_aleatorios))
        lado = max(x_pontos_aleatorios) - min(x_pontos_aleatorios);
    else
        lado = max(y_pontos_aleatorios) - min(y_pontos_aleatorios);
    end

    %Área_quadrado
    area_quadrado = lado.^2;

    %verificar quantidade de pontos dentro da figura
    [in,on] = inpolygon(x_pontos_aleatorios, y_pontos_aleatorios,...
        x_figura, y_figura);
    qtd_pontos_dentro = numel(x_pontos_aleatorios(in));

    %calcular area da figura
    if size(x_pontos_aleatorios,2) == 0
        area = 0;
    else
        area = area_quadrado * (qtd_pontos_dentro/size(x_pontos_aleatorios,1));
    end
end

