clear;close all;
N=64;
sigma=1;mu=0;
e=sigma*randn(1,N)+mu;
t=0:1:(N-1);
yorg=(10*sin(0.2*(2*pi*t)))+(5*sin((0.2+1/N)*(2*pi*t)))+e;

figure;
tiledlayout("vertical")
i=1;
for M=[0,1,3,5,7]
    y=[yorg zeros(1,M*N)];
    L=length(y);
    v=ones(1,L);
    phi=periodogramse(y,v,L);
    nexttile
    f=(0 : 2/L :2*(L-1)/L);
    plot(phi);
    xlabel('frequency(f)')
    ylabel('\phi(f)')
    title(sprintf('Periodogram with data padded with %d*N zeros', M));
    i=i+1;
end
