clc; clearvars; close all
m=10;
d=0.5;
N=100;
theta=[0,7.5];
P=eye(2);
sig2=1;
L=1024;
theta_k=180*((-1/2)+(0:(L-1))/L);
phi_beam=zeros(L,1);
phi_capon=zeros(L,1);
n=2;
doa_music=zeros(n,1);
doa_esprit=zeros(n,1);

%Monte carlo to simulate the random noise
for i=1:50
    Y = uladata(theta, P,N, sig2, m, d);%each col gives a particular instant of sensor values

    phi_beam=phi_beam+beamform(Y,L,d);
    phi_capon=phi_capon+capon_sp(Y,L,d);
    doa_music=doa_music+sort(root_music_doa(Y,n,d));
    doa_esprit=doa_esprit+sort(esprit_doa(Y,n,d));

end
figure;
tiledlayout("vertical")
sgtitle("Spatial Spectrum Estimation")
nexttile
plot(theta_k,phi_beam/50);
title('With Beamforming')
xlabel('\theta_k')
ylabel('A^{T}RA')
nexttile
plot(theta_k,phi_capon/50);
title('With Capon Method')
xlabel('\theta_k')
ylabel('1/real(A^{T}R^{-1}A)')

figure;
tiledlayout("vertical")
sgtitle("DoA Estimation")
nexttile
doa_music=doa_music/50;
xline(doa_music,'-',{sprintf("%f",doa_music(1)),sprintf("%f",doa_music(2))});
title('Root MUSIC')
xlabel('\theta')
nexttile
doa_esprit=doa_esprit/50;
xline(doa_esprit,'-',{sprintf("%f",doa_esprit(1)),sprintf("%f",doa_esprit(2))});
title('ESPRIT')
xlabel('\theta')