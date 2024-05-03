clc; clearvars; close all
load('submarine.mat');
m=6;
d=0.9/5.32;
P=eye(2);
% sig2=1;
L=1024;
theta_k=180*((-1/2)+(0:(L-1))/L);

Y=X;
for n=2:4
    phi_beam=zeros(L,1);
    phi_capon=zeros(L,1);
    % n=4;%number of sources-unknown
    doa_music=zeros(n,1);
    doa_esprit=zeros(n,1);


    phi_beam=phi_beam+beamform(Y,L,d);
    phi_capon=phi_capon+capon_sp(Y,L,d);
    doa_music=doa_music+sort(root_music_doa(Y,n,d));
    doa_esprit=doa_esprit+sort(esprit_doa(Y,n,d));

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
    sgtitle("DoA Estimation with n="+ n)
    nexttile
    doa_music=real(doa_music);
    if n==2
        xline(doa_music,'-',{sprintf("%f",doa_music(1)),sprintf("%f",doa_music(2))});
    elseif n==3
        xline(doa_music,'-',{sprintf("%f",doa_music(1)),sprintf("%f",doa_music(2)),sprintf("%f",doa_music(3))});
    else
        xline(doa_music,'-',{sprintf("%f",doa_music(1)),sprintf("%f",doa_music(2)),sprintf("%f",doa_music(3)),sprintf("%f",doa_music(4))});
    end
    title('Root MUSIC')
    xlabel('\theta')
    nexttile
    doa_esprit=real(doa_esprit);
    if n==2
        xline(doa_esprit,'-',{sprintf("%f",doa_esprit(1)),sprintf("%f",doa_esprit(2))});
    elseif n==3
        xline(doa_esprit,'-',{sprintf("%f",doa_esprit(1)),sprintf("%f",doa_esprit(2)),sprintf("%f",doa_esprit(3))});
    else
        xline(doa_esprit,'-',{sprintf("%f",doa_esprit(1)),sprintf("%f",doa_esprit(2)),sprintf("%f",doa_esprit(3)),sprintf("%f",doa_esprit(4))});
    end
    title('ESPRIT')
    xlabel('\theta')
end