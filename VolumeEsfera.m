function [volume] = VolumeEsfera(raio, qtd_pontos_aleatorios, x_pontos_aleatorios, y_pontos_aleatorios, z_pontos_aleatorios, qtd_fatias, complexidade_esfera)
%{
    VolumeEsfera
        Esse script calcula o volume de uma esfera com raio especificado
        usando o método de Monte Carlo para o cálculo de áreas. 
        Basicamente, seccionamos a esfera em fatias e calculamos a area da
        figura em cada fatia e então a multiplicamos pela espessura da
        fatia. Somando o volume de todas as fatias achamos o volume total.

    Input:
    - raio
    - qtd_pontos_aleatorios
    - qtd_fatias
    - complexidade_esfera
%}

    %Configurações do script:
    raio = 1; %raio da esfera a ser calculada
    qtd_pontos_aleatorios = 1.5E5; %quantidade de pontos usada para o calculo das areas, quanto maior, mais próximo do valor real estará o volume calculado
    qtd_fatias = 100; %quantidade de secções que serão feitas sobre a circunferencia

    %inicialização de algumas variáveis
    volume = 0;
    last_z = -raio;

    %Gerar esfera                               %informa-se o raio da esfera e o nível de complexidade da esfera
    [x,y,z] = Esfera(raio,complexidade_esfera); %quanto maior a complexidade mais bem definida será a esfera
                                                %a quantidade de pontos gerada é complexidade^2

    %Gerar pontos aleatorios. raio*2 corresponde ao intervalo sobre qual as
    %coordenadas vão variar. Ou seja x, y e z aleatórios pertencerão a
    %[0,raio*2]
    %[x_pontos_aleatorios, y_pontos_aleatorios, z_pontos_aleatorios] = ...
        %GerarPontosAleatorios(raio*2, qtd_pontos_aleatorios);

    %Como a função de coordenadas gera pontos num intervalo [0,raio*2] queremos
    %deslocar as coordenadas para variarem no intervalo [-raio,raio] de forma a
    %obter uma esfera inscrita num cubo.
    x_pontos_aleatorios = x_pontos_aleatorios-raio;
    y_pontos_aleatorios = y_pontos_aleatorios-raio;
    z_pontos_aleatorios = z_pontos_aleatorios-raio;
    plot3(x_pontos_aleatorios,y_pontos_aleatorios,z_pontos_aleatorios, '.');

    %Calculo do volume propriamente dito:

    for i = 0:(qtd_fatias -1)

        %achar os pontos contidos na fatia:
        z0 = ((i*2*raio/qtd_fatias) - raio); %coordenada z inicial da fatia
        zfinal = (((i+1)*2*raio/qtd_fatias)-raio); %coordenada z final da fatia
        I = ((z>=z0) &(z < zfinal)); %matriz lógica, ele diz quais valores da matriz z contém elementos no intervalo dado
        I_2 = ((z_pontos_aleatorios >=z0) &(z_pontos_aleatorios < zfinal)); %matriz lógica, ele diz quais valores da matriz z_pontos_aleatorios contém elementos no intervalo dado

        %calcular o volume da fatia usando Monte Carlo e somar ao volume total:

        if size(x(I), 2)>0 %há pontos da circunferencia na fatia?
            area = CalcularAreaCircunferencia (x(I), y(I),...
                x_pontos_aleatorios(I_2), y_pontos_aleatorios(I_2), raio);
            volume= volume + area*((zfinal - last_z));
            last_z = zfinal;
        end
    end
end

