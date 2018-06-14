function [volume,largura, area, poligono, rand_points] = CalcularNuvem(nome_arquivo)
%==========================================================================
%   Configurações
%--------------------------------------------------------------------------
    qtd_rand = 1E6; %quantidade de pontos aleatórios
    qtd_fatias = 100; %quantidade de fatias

%==========================================================================

addpath(genpath('C:\Users\Justo\Desktop\PointCloudToolbox\Point_cloud_tools_for_Matlab-master'));
obj = pcread(nome_arquivo);
x = obj(:,1);
y = obj(:,2);
z = obj(:,3);
maximo = max(max([x,y,z]));
minimo = min(min([x,y,z]));
[x_rand,y_rand,z_rand] = GerarPontosAleatorios(maximo,minimo,qtd_rand);
[volume,largura, area, poligono, rand_points] = CalcularVolumeMC(x',y',z',x_rand,y_rand,z_rand,qtd_rand,qtd_fatias);
end

