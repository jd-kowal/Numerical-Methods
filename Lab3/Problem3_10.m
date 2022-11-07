clear all; close all;
%table=readtable('babia_gora.dat');
%[X,Y,Z] = meshgrid(table.Var1,table.Var2,table.Var3);
load('babia_gora.dat')
size(babia_gora);
figure; grid; plot3(babia_gora(:,1),babia_gora(:,2),babia_gora(:,3),'b.'); pause
%geoMatrix = readmatrix("babia_gora.dat");
%disp(geoMatrix)

x = babia_gora(:,1); y = babia_gora(:,2); z = babia_gora(:,3);
vmin = min( min(x), min(y) ); % min
vmax = max( max(x), max(y) ); % max
[xi,yi] = meshgrid( vmin : (vmax-vmin)/10000 : vmax ); % dopasowanie zakresu
zi = griddata( x, y, z, xi, yi, 'linear' ); % interp: nearest, linear, spline, cubic
figure; surf( xi,yi,zi ); pause % rysunek

ax = -45/180*pi; ay = -90/180*pi; az = 135/180*pi;
Rx = [ 1, 0, 0; 0, cos(ax), -sin(ax); 0, sin(ax), cos(ax) ]; % macierz rotacji wzg. x
Ry = [ cos(ay), 0, -sin(ay); 0, 1, 0; sin(ay), 0, cos(ay) ]; % macierz rotacji wzg. y
Rz = [ cos(az), -sin(az), 0; sin(az), cos(az), 0; 0, 0, 1 ]; % macierz rotacji wzg. z
XR = Rz * Ry * Rx * babia_gora'; % 3 rotacje po kolei
figure; grid; plot3( XR(1,:), XR(2,:), XR(3,:), 'b.' ); % wynik obrotu