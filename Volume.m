function [volume] = Volume(nome_arquivo)    

%--------------------------------------------------------------------------
%   Configurações
%--------------------------------------------------------------------------
    COMPLEXIDADE = 100;
    varargin{1} = 1;
    varargin{2} = 2;
    varargin{3} = 3;

%--------------------------------------------------------------------------
%   Inicializacao variaveis
%--------------------------------------------------------------------------
    volume_real = 0;
    volume = 0;

%--------------------------------------------------------------------------
%   Gerar pontos da nuvem
%--------------------------------------------------------------------------
    if strcmpi(nome_arquivo, 'esfera')
        f = @(u,v) deal(varargin{1}*sin(v)*cos(u), ...
            varargin{1}*sin(v)*sin(u), varargin{1}*cos(v));
        lim_u = 2*pi;
        lim_v = pi;
        volume_real = (4/3)*pi*varargin{1}^3;
        [x,y,z] = GerarSuperficie(lim_u,lim_v,f,COMPLEXIDADE);
    %{
    elseif strcmpi(nome_arquivo,'pseudoesfera')
        f = @(u, v) deal (sech(u)*cos(v), sech(u)*sin(v), u - tanh(u));
        volume_real = (2/3)*pi;
    %}
    elseif strcmpi(nome_arquivo, 'elipsoide')
        f = @(u, v) deal(varargin{1}*cos(u)*sin(v),...
            varargin{2}*sin(u)*sin(v), varargin{3}*cos(v));
        volume_real = (4/3)*pi*varargin{1}*varargin{2}*varargin{3};
        lim_u = 2*pi;
        lim_v = pi;
        [x,y,z] = GerarSuperficie(lim_u,lim_v,f,COMPLEXIDADE);
    %{  
    elseif strcmpi(nome_arquivo,'paraboloide')
        f = @(u, v) deal(varargin{1}*sqrt(u/varargin{2})*cos(v), varargin{1}*sqrt(u/varargin{2})*sin(v), u);
        volume_real = (1/2)*pi*(varargin{1}^2)*varargin{2};
    %}  
    %{
        A implementar
        
        elseif strcmpi(nome_arquivo,'hiperboloide1')
            f = @(u, v) deal(varargin{1}*sqrt(1+u^2)*cos(v), varargin{1}*sqrt(1+u^2)*sin(v), varargin{2}*u);   
        elseif strcmpi(nome_arquivo, 'toroide')

            f = @(u,v) deal((varargin{2} + varargin{1}*cos(v))*cos(u), (varargin{2} + varargin{1}*cos(v))*sin(u),...
                varargin{1}*sin(v));
            volume = 2*pi^2*varargin{1}^2*varargin{2};
        
        elseif strcmpi(nome_arquivo,'hiperboloide2')
        elseif strcmpi(nome_arquivo,'pretzel')
        elseif strcmpi(nome_arquivo, 'pilz')
        elseif strcmpi(nome_arquivo, 'deco-cubo')
        elseif strcmpi(nome_arquivo, 'deco-tetaedro')
        elseif strcmpi(nome_arquivo, 'orthocirculo')
        elseif strcmpi(nome_arquivo,'breather')
        elseif strcmpi(nome_arquivo,'kuen')
        elseif strcmpi(nome_arquivo, 'undoloide')
    %}      
    else
        addpath(genpath('C:\Users\Justo\Desktop\PointCloudToolbox\Point_cloud_tools_for_Matlab-master'));
        obj = pcread(nome_arquivo);
        x = obj(:,1);
        y = obj(:,2);
        z = obj(:,3);
    end
%--------------------------------------------------------------------------
%   Calcular o Volume
%--------------------------------------------------------------------------
    volume = VolumeDelaunay(x,y,z);
    erro = abs(volume/volume_real -1);
    disp('volume calculado é:');
    disp(volume);
    if volume_real ~= 0;
        disp('Erro de:');
        disp(erro);
    end
end

