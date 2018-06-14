function [volume,largura, area, poligono, rand_points] = CalcularVolumeMC(x, y, z, x_pontos_aleatorios, y_pontos_aleatorios, z_pontos_aleatorios, qtd_pontos_aleatorios, qtd_fatias)
%{
    CalcularVolume
        Esse script calcula o volume de uma s�lido qualquer
        usando o m�todo de Monte Carlo para o c�lculo de �reas. 
        Basicamente, seccionamos a esfera em fatias e calculamos a area da
        figura formada em cada fatia (usando Monte Carlo)
        e ent�o a multiplicamos pela espessura da fatia. Somando o volume 
        de todas as fatias achamos o volume total.

    Input:
    - x(vetor float): coovrdenadas x's dos pontos que comp�e a figura
    - y(vetor float): coordenadas y's dosx pontos que comp�e a figura
    - z(vetor float): coordenadas z's dos pontos que comp�e a figura
    - qtd_pontos_aleatorios(int): quantidade de pontos aleat�rios gerados,
      quanto mais pontos, mais preciso ser� o volume achado
    - qtd_fatias(int): quantidade de se��es que ser� feita sobre o volume
      do s�lido

    Output:
    - volume(float): valor do volume calculado
%}

    %Vari�veis de teste
    area = zeros(qtd_fatias,1);
    largura = zeros(qtd_fatias,1);
    poligono = zeros(size(x,1),2,qtd_fatias);
    rand_points = zeros(2,size(x_pontos_aleatorios,2),qtd_fatias);

    %inicializa��o de algumas vari�veis
    volume = 0;
    last_z = min(z);
    
    %Definir maior coordenada existente na nuvem de pontos. Isso � feito
    %pois precisamos definir um "cubo" que englobe toda o objeto. 
    %As coordenadas dos pontos aleat�rios variam dentro desse "cubo"
    intervalo_x = max(x) - min(x);
    intervalo_y = max(y) - min(y);
    intervalo_z = max(z) - min(z);
    
    intervalos = [intervalo_x, intervalo_y, intervalo_z];
    intervalos_ordem_ascendente = sort(intervalos);
    maior_coord = intervalos_ordem_ascendente(3);
    
    %Gerar pontos aleatorios. 'maior_coord' corresponde ao intervalo sobre qual as
    %coordenadas v�o variar. Ou seja x, y e z aleat�rios pertencer�o a
    %[0,maior_coord]
    %[x_pontos_aleatorios, y_pontos_aleatorios, z_pontos_aleatorios] = ...
        %GerarPontosAleatorios(maior_coord, qtd_pontos_aleatorios);

    %Como a fun��o de coordenadas gera pontos num intervalo [0,maior_coord] queremos
    %deslocar as coordenadas para variarem no intervalo [-maior_coord/2 ,maior_coord/2] de forma a
    %obter um objeto inscrito num cubo.
    %x_pontos_aleatorios = x_pontos_aleatorios-(maior_coord/2);
    %y_pontos_aleatorios = y_pontos_aleatorios-(maior_coord/2);
    %z_pontos_aleatorios = z_pontos_aleatorios-(maior_coord/2);

    %Calculo do volume propriamente dito:

    for i = 0:(qtd_fatias -1)

        %definir o come�o e o fim da fatia
        z_inicial = ((i*intervalo_z/qtd_fatias) - intervalo_z/2); %coordenada z inicial da fatia
        z_final = (((i+1)*intervalo_z/qtd_fatias)- intervalo_z/2); %coordenada z final da fatia
        
        if abs((z_final - z_inicial) - 2/(qtd_fatias)) >= 10E-6
            %disp('as fatias tem forma irregular');
            %disp('c�digo terminado');
            %break;
        else
        end
        
        %achar os pontos contidos na fatia:
        I = ((z>=z_inicial) &(z < z_final)); %matriz l�gica, ele diz quais valores da matriz z cont�m elementos no intervalo dado
        I_aleatorio = ((z_pontos_aleatorios >=z_inicial) &(z_pontos_aleatorios < z_final)); %matriz l�gica, ele diz quais valores da matriz z_pontos_aleatorios cont�m elementos no intervalo dado

        %calcular o volume da fatia usando Monte Carlo e somar ao volume total:

        if size(x(I), 2)>0 %h� pontos na fatia?
            poligono(1:numel(x(I)),1:2,i+1) = [x(I)',y(I)'];
            rand_points(1:2,1:numel(x_pontos_aleatorios(I_aleatorio)),i+1) = [x_pontos_aleatorios(I_aleatorio); y_pontos_aleatorios(I_aleatorio)];
            area(i+1) = CalcularAreaMC (x(I), y(I),...
                x_pontos_aleatorios(I_aleatorio), y_pontos_aleatorios(I_aleatorio));
            largura(i+1) = (z_final - last_z);
            volume = volume + area(i+1)*largura(i+1);
            last_z = z_final;
        end
    end
    volume;
end