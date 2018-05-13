%Algoritmo de testes
qtd_pontos = 5;
qtd_fatias = 10;
volume_real = pi*4/3;
[x,y,z] = Esfera(1,100);

%Inicialização de variáveis
x_pontos_aleatorios = zeros(1,10.^qtd_pontos);
y_pontos_aleatorios = zeros(1,10.^qtd_pontos);
z_pontos_aleatorios = zeros(1,10.^qtd_pontos);


%%

%Calcular volume x qtd_pontos
    for i=1:qtd_pontos
        [x_pontos_aleatorios, y_pontos_aleatorios, z_pontos_aleatorios] = GerarPontosAleatorios(2, 10.^qtd_pontos, x_pontos_aleatorios, y_pontos_aleatorios, z_pontos_aleatorios);
        for k = 1:20
            volume_1(i,k) = CalcularVolumeMC (x, y, z, x_pontos_aleatorios, y_pontos_aleatorios, z_pontos_aleatorios, 10.^i, 100);
        end
        erro_versus_pontos(i) = abs((mean(volume_1(i,:)) - volume_real)/volume_real);
    end
    
    %Plotar histogramas
    for i = 1:qtd_pontos
        figure('visible', 'off');
        hist(volume_1(i,:));
        variancia = var(volume_1(i,:));
        title(sprintf('Histograma Volume (10^%d pts)', i));
        ylabel('N');
        xlabel('volume (u.v)');
        annotation ('textbox', [0.7 0.5 0.3 0.4], 'String',...
            sprintf('Variância: %f u.v', variancia), 'FitBoxToText', 'on');
        print(sprintf('hist_volume_10E%d_pontos', i), '-dpng');
        save(sprintf('hist_volume_10E%d_pontos.txt', i), 'volume_1',...
            '-ascii');
    end


    %Plotar erro relativo x qtd_pontos
    figure('visible', 'off');
    plot(linspace(1, qtd_pontos, qtd_pontos), erro_versus_pontos);
    title('Erro relativo x Qtd. de pontos (100 fatias)');
    xlabel('quantidade de pontos');
    ylabel('erro relativo');
    a = cellstr(num2str(get(gca, 'ytick')'*100));
    b = char(ones(size(a,1),1)*'%');
    nova_label_y = [char(a), b];
    set(gca, 'yticklabel', nova_label_y);
    print('erro_relativo_ponto', '-dpng');
    save('erro_relativo_pts (100fatias).txt', 'erro_versus_pontos', '-ascii');

 %% 

%Calcular volume x qtd_fatias
    for i = 1:qtd_fatias
        for k = 1:30
            [x_pontos_aleatorios, y_pontos_aleatorios, z_pontos_aleatorios] = GerarPontosAleatorios(2, 10.^qtd_pontos, x_pontos_aleatorios, y_pontos_aleatorios, z_pontos_aleatorios);
            volume_2(i,k) = CalcularVolumeMC (x, y, z, x_pontos_aleatorios, y_pontos_aleatorios, z_pontos_aleatorios, 10^5, i*100);
        end
        erro_versus_fatias(i) = abs((mean(volume_2(i,:)) - volume_real)/volume_real);
    end

%Plotar erro x quantidade de 'cortes'
    figure('visible', 'off');
    plot(linspace(100,qtd_fatias*100,qtd_fatias), erro_versus_fatias);
    title('Erro relativo x Qtd. de fatias (10E5pts)');
    xlabel('quantidade de fatias');
    ylabel('erro relativo');
    a = cellstr(num2str(get(gca, 'ytick')'*100));
    b = char(ones(size(a,1),1)*'%');
    nova_label_y = [char(a), b];
    set(gca, 'yticklabel', nova_label_y);
    print('erro_relativo_fatia(10E6pts)', '-dpng');
    save('erro_relativo_fatia(10E6pts).txt', 'erro_versus_fatias', '-ascii');
    
    %% 
    
    disp('código executado com sucesso');
    0
    