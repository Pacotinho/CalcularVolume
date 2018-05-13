function [volume,largura, area, poligono, rand_points] = CalcularVolumeMC(x, y, z, x_pontos_aleatorios, y_pontos_aleatorios, z_pontos_aleatorios, qtd_pontos_aleatorios, qtd_fatias)
%{
    CalcularVolume
        Esse script calcula o volume de uma sólido qualquer
        usando o método de Monte Carlo para o cálculo de áreas. 
        Basicamente, seccionamos a esfera em fatias e calculamos a area da
        figura formada em cada fatia (usando Monte Carlo)
        e então a multiplicamos pela espessura da fatia. Somando o volume 
        de todas as fatias achamos o volume total.

    Input:
    - x(vetor float): coovrdenadas x's dos pontos que compõe a figura
    - y(vetor float): coordenadas y's dosx pontos que compõe a figura
    - z(vetor float): coordenadas z's dos pontos que compõe a figura
    - qtd_pontos_aleatorios(int): quantidade de pontos aleatórios gerados,
      quanto mais pontos, mais preciso será o volume achado
    - qtd_fatias(int): quantidade de seções que será feita sobre o volume
      do sólido

    Output:
    - volume(float): valor do volume calculado
%}

    %Variáveis de teste
    area = zeros(qtd_fatias);
    largura = zeros(qtd_fatias);
    poligono = zeros(size(x,1),2,qtd_fatias);
    rand_points = zeros(2,size(x_pontos_aleatorios,2),qtd_fatias);

    % Centrar o sistema de coordenadas no ponto médio do objeto
    x_medio = (max(x) + min(x))/2;
    y_medio = (max(y) + min(y))/2;
    z_medio = (max(z) + min(z))/2;
    x = x - x_medio;
    y = y - y_medio;
    z = z - z_medio;

    %inicialização de algumas variáveis
    volume = 0;
    last_z = min(z);
    
    %Definir maior coordenada existente na nuvem de pontos. Isso é feito
    %pois precisamos definir um "cubo" que englobe toda o objeto. 
    %As coordenadas dos pontos aleatórios variam dentro desse "cubo"
    intervalo_x = max(x) - min(x);
    intervalo_y = max(y) - min(y);
    intervalo_z = max(z) - min(z);
    
    intervalos = [intervalo_x, intervalo_y, intervalo_z];
    intervalos_ordem_ascendente = sort(intervalos);
    maior_coord = intervalos_ordem_ascendente(3);
    
    %Gerar pontos aleatorios. 'maior_coord' corresponde ao intervalo sobre qual as
    %coordenadas vão variar. Ou seja x, y e z aleatórios pertencerão a
    %[0,maior_coord]
    %[x_pontos_aleatorios, y_pontos_aleatorios, z_pontos_aleatorios] = ...
        %GerarPontosAleatorios(maior_coord, qtd_pontos_aleatorios);

    %Como a função de coordenadas gera pontos num intervalo [0,maior_coord] queremos
    %deslocar as coordenadas para variarem no intervalo [-maior_coord/2 ,maior_coord/2] de forma a
    %obter um objeto inscrito num cubo.
    x_pontos_aleatorios = x_pontos_aleatorios-(maior_coord/2);
    y_pontos_aleatorios = y_pontos_aleatorios-(maior_coord/2);
    z_pontos_aleatorios = z_pontos_aleatorios-(maior_coord/2);

    %Calculo do volume propriamente dito:

    for i = 0:(qtd_fatias -1)

        %definir o começo e o fim da fatia
        z_inicial = ((i*intervalo_z/qtd_fatias) - intervalo_z/2); %coordenada z inicial da fatia
        z_final = (((i+1)*intervalo_z/qtd_fatias)- intervalo_z/2); %coordenada z final da fatia
        
        if abs((z_final - z_inicial) - 2/(qtd_fatias)) >= 10E-6
            %disp('as fatias tem forma irregular');
            %disp('código terminado');
            %break;
        else
        end
        
        %achar os pontos contidos na fatia:
        I = ((z>=z_inicial) &(z < z_final)); %matriz lógica, ele diz quais valores da matriz z contém elementos no intervalo dado
        I_aleatorio = ((z_pontos_aleatorios >=z_inicial) &(z_pontos_aleatorios < z_final)); %matriz lógica, ele diz quais valores da matriz z_pontos_aleatorios contém elementos no intervalo dado

        %calcular o volume da fatia usando Monte Carlo e somar ao volume total:

        if size(x(I), 2)>0 %há pontos na fatia?
            poligono(1:numel(x(I)),1:2,i+1) = [x(I),y(I)];
            rand_points(1:2,1:numel(x_pontos_aleatorios(I_aleatorio)),i+1) = [x_pontos_aleatorios(I_aleatorio); y_pontos_aleatorios(I_aleatorio)];
            area(i+1) = CalcularAreaMC (x(I), y(I),...
                x_pontos_aleatorios(I_aleatorio), y_pontos_aleatorios(I_aleatorio));
            largura(i+1) = (z_final - last_z);
            volume = volume + area(i+1)*largura(i+1);
            last_z = z_final;
        end
    end
    volume
end