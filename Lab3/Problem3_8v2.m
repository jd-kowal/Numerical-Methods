clear all; close all;

% Dane wejsciowe
[x,fpr]=audioread('elephnt1.wav',[1,2^14]); %audioread(filename,samples) - reads the selected range of audio samaples in the fiel, where samples is a vector of the form [start,finish]
N = length(x);
figure; plot(x); title('x(n)');
[x1,fpr1]=audioread('Canary_animals065.wav',[1,2^14]);
N1 = length(x1);
figure; plot(x1); title('x1(n)');
suma = x + x1;
N2 = length(suma);
figure; plot(suma); title('suma(n)');

% Transformacja liniowa/ortogonalna - ANALIZA
n=0:N2-1; k=0:N2-1;
A = sqrt(2/N2)*cos( pi/N2*(k'*n));
%suma = A(12000,:) + A(18000,:); suma = suma';
y = A*suma;
%nieslon=A*x;
%y=y-nieslon;
figure; plot(y); title('Analiza(k)');

% Modyfikacja wyniku
y(1000:13000,1) = zeros(12001,1);
figure; plot(y); title('Modyfikacja(k)');

% Transformacja odwrotna - SYNTEZA
xback = A'*y;
figure; plot(xback); title('xback(n)');

soundsc(suma,fpr); pause
soundsc(xback,fpr); pause