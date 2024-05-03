clear;close all;
%% Part 1
M=10;
r=abs(-M:1:M);
r=r/M;
r=1-r;
figure;
stem(-M:1:M,r);
xlabel('lag')
ylabel('ACS')
title('Plot of ACS sequence with M = 10')


L=256;
x=[zeros(1,L-length(r)) r];
x=circshift(x,M+1);
xf=real(fft(x));%to remove imaginary components of fft
nnz(xf<0)%check number of non-negative components

figure;
w = pi*(-1 : 2/L :(L-1)/L);
plot (w, fftshift (xf)) 
title('FFT of ACS sequence')
xlabel('\omega')
ylabel('\phi(\omega)')

%% Part 2
w=(2*pi/L)*(1:1:L-1);
yf=(sin(M*w/2).^2)./(M*sin(w/2).^2);
yf=[M yf];
y=real(ifft(yf));

figure;
w = pi*(-1 : 2/L :(L-1)/L);
plot(w,fftshift(yf));
title('Plot of derived PSD')
xlabel('\omega')
ylabel('\phi(\omega)')

figure;
t=-L/2:(L/2)-1;
stem(t,fftshift(y))
xlabel('lag')
ylabel('ACS')
title('Plot of IFFT of derived PSD')

figure;

a=fftshift(y);
a=round(a,8);
stem(-10:10,[0 a(a>0) 0])%Padded zeros as they are truncated due to > 0 condn.
xlabel('lag')
ylabel('ACS')
title('Components of PSD >0')
