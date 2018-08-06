function [volume] = VolumeDelaunay(x,y,z)
%{
VolumeDelaunay
    Essa função calcula o volume de uma nuvem de pontos convexa repartindo
o dominio em vários tetraedros e calculando o volume de cada tetraedro.
%}

volume = 0;
tri = delaunay(x,y,z); %Define os tetraedros

%Calcular volume de cada tetraedro usando produto vetorial e produto
%escalar de vetores:
for k = 1:size(tri,1)
    a = [x(tri(k,1)),y(tri(k,1)),z(tri(k,1))];
    b = [x(tri(k,2)),y(tri(k,2)),z(tri(k,2))];
    c = [x(tri(k,3)),y(tri(k,3)),z(tri(k,3))];
    d = [x(tri(k,4)),y(tri(k,4)),z(tri(k,4))];
    ab = a-b;
    ac = a-c;
    ad = a-d;
    volume = volume + abs(dot(cross(ab,ac),ad))/6;
end
end