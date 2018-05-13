function [f, volume] = GerarSuperficie(superficie, varargin)    

    x = NaN;
    y = NaN;
    z = NaN;
    volume = NaN;
    f = NaN;
    
    if strcmpi(superficie, 'esfera')
        
        f = @(u,v) deal(varargin{1}*sin(v)*cos(u), varargin{1}*sin(v)*sin(u), varargin{1}*cos(v));
        volume = (4/3)*pi*varargin{1}^3;
        
    elseif strcmpi(superficie, 'toroide')
        
        f = @(u,v) deal((varargin{2} + varargin{1}*cos(v))*cos(u), (varargin{2} + varargin{1}*cos(v))*sin(u),...
            varargin{1}*sin(v));
        volume = 2*pi^2*varargin{1}^2*varargin{2};
        
    elseif strcmpi(superficie, 'undoloide')
        
    elseif strcmpi(superficie,'pseudoesfera')
        
        f = @(u, v) deal (sech(u)*cos(v), sech(u)*sin(v), u - tanh(u));
        volume = (2/3)*pi;
        
    elseif strcmpi(superficie,'breather')
        
    elseif strcmpi(superficie,'kuen')
        
    elseif strcmpi(superficie, 'elipsoide')
        f = @(u, v) deal(varargin{1}*cos(u)*sin(v), varargin{2}*sin(u)*sin(v), varargin{3}*cos(v));
        volume = (4/3)*pi*varargin{1}*varargin{2}*varargin{3};
        
    elseif strcmpi(superficie,'paraboloide')
        f = @(u, v) deal(varargin{1}*sqrt(u/varargin{2})*cos(v), varargin{1}*sqrt(u/varargin{2})*sin(v), u);
        volume = (1/2)*pi*(varargin{1}^2)*varargin{2};
        
    elseif strcmpi(superficie,'hiperboloide1')
        f = @(u, v) deal(varargin{1}*sqrt(1+u^2)*cos(v), varargin{1}*sqrt(1+u^2)*sin(v), varargin{2}*u);   
    elseif strcmpi(superficie,'hiperboloide2')
    elseif strcmpi(superficie,'pretzel')
    elseif strcmpi(superficie, 'pilz')
    elseif strcmpi(superficie, 'deco-cubo')
    elseif strcmpi(superficie, 'deco-tetaedro')
    elseif strcmpi(superficie, 'orthocirculo')
    else
    end
end

