clear all; close all;

% Dane wejsciowe
[x,fpr]=audioread('mowa.wav',[1,2^14]);     %audioread(filename,samples) - reads the selected range of audio samaples in the fiel, where samples is a vector of the form [start,finish]
N = length(x);
figure; plot(x); title('x(n)');     %rysowanie wykresu

% Transformacja liniowa/ortogonalna - ANALIZA
n=0:N-1; k=0:N-1;   %dwa wektory poziome od 0 do N-1
A = sqrt(2/N)*cos( pi/N *(k'*n));   %dyskretna transformacja cosinusowa (wyżej)
x = A(500,:) + A(1000,:); x = x';   %%analizowany wektor - suma 500 i 1000 wiersza macierzy A (x' transpozycja)
figure; plot(x); title('x(n)');
y = A*x;    %x-sygnał odebrany, A-testujące cosinusy, sprawdzamy czy składowa sygnału (pojedynczy wiersz*x -> jak bardzo pasuje)
figure; plot(y); title('y(k)');

% Modyfikacja wyniku
%y(N/8+1:N,1) = zeros(7*N/8,1);
y(1000)=0;  %%ustawia 1000 element na 0
figure; plot(y); title('y(k)');

% Transformacja odwrotna - SYNTEZA
xback = A'*y;
figure; plot(xback); title('xback(n)');

soundsc(x,fpr); pause
soundsc(xback,fpr);