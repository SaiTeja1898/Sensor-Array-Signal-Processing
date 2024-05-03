clear;close all;
% load("/MATLAB Drive/CRL704_HW-1/sunspotdata.mat")
% y=sunspot;
% load("/MATLAB Drive/CRL704_HW-1/lynxdata.mat")
load('sunspotdata.mat')
load('lynxdata.mat')
y=lynx;
% y=loglynx;
% y=y-mean(y);
% 
% y=sunspot;

N=length(y);
figure;
tiledlayout(6,1)
i=1;
sgtitle('Spectral estimation using different estimators for sunspot data')


M=N;
L=1024;
ax(i)=nexttile;
phi=periodogramse (y,ones(1,M),L);
f=(0 : 1/L :(L-1)/(2*L));
plot(f,10*log10(phi(1:L/2)));
title('Periodogram with rectangular temporal window')

M=N;
L=1024;
i=i+1;ax(i)=nexttile;
phi=periodogramse (y,bartlett(M),L);
f=(0 : 1/L :(L-1)/(2*L));
plot(f,10*log10(phi(1:L/2)));
title('Periodogram with Bartlett temporal window')

M=round(N/4);
L=1024;
i=i+1;ax(i)=nexttile;
phi = btse(y, bartlett(M), L);
f=(0 : 1/L :(L-1)/(2*L));
plot(f,10*log10(phi(1:L/2)));
title('Blackman-Tukey with Bartlett window (M = N/4)')

M=round(N/4);
L=1024;
i=i+1;ax(i)=nexttile;
phi=bartlettse (y,M,L);
f=(0 : 1/L :(L-1)/(2*L));
plot(f,10*log10(phi(1:L/2)));
title('Bartlett method (M = N/4)')

M=round(N/2);K=N/2;
L=1024;
i=i+1;ax(i)=nexttile;
phi = welchse(y, ones(1,M), K, L);
f=(0 : 1/L :(L-1)/(2*L));
plot(f,10*log10(phi(1:L/2)));
title('Welch method with rectangular temporal window (M = N/2, K = N/2)')

J = 4; Ntilde = 16*N;
L=Ntilde;
i=i+1;ax(i)=nexttile;
phi= daniellse (y,J,L);
f=(0 : 1/L :(L-1)/(2*L));
plot(f,10*log10(phi(1:L/2)));
title('Daniell method (J = 4, Ntilde = 16N)')

xlabel(ax,'frequency(f)') %This is the same for all subplots
ylabel(ax,'\phi(f)') %This is the same for all subplots