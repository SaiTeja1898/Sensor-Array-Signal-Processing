clear;close all;
%% Part 1

for p=[1,2]
    figure;
    tiledlayout("vertical")
    i=1;
    for M=[64,128,256,512]
        nexttile
        if p==1
            v=bartlett(M);
            titl="Bartlett";
        else
            v=ones(1,M);
            titl="Rectangular";

        end

        [h,w]=freqz(v,1);
        plot(w,10*log10(h))
        xlabel('\omega')
        ylabel('\phi(\omega)(dB)')
        title(sprintf('Frequency response of %s window with M=%d',titl,M))

        % nexttile
        % powerbw(v);
        % i=i+1;
    end
end


%% Part 2
f=0.2;a1=1;a2=1;N=256;
t=0:1:(N-1);
sigma=0;mu=0;

for p=[1,2]
    figure;
    tiledlayout("vertical")
    if p==1
        sgtitle('Spectral estimation using Unwindowed Periodogram')
    else
        sgtitle('Spectral estimation using btse')
    end
    for a=0.5:0.1:0.9
        y=(a1*sin(f*2*pi*t))+(a2*sin((f+(a/N))*2*pi*t));
        e=sigma*randn(1,length(y))+mu;
        y=y+e;
        M=N;L=1024;
        if p==1
            phi=periodogramse(y,ones(1,length(y)),L);
        else
            phi=btse(y,bartlett(length(y)),L);
        end
        nexttile
        fi=(0 : 1/L :(L-1)/(2*L));
        plot(fi,10*log10(phi(1:L/2)));
        title(sprintf('a=%d',a));
        xlabel('frequency')
        ylabel('\phi(f)')
    end
end

%% Part 3
f=0.2;a1=1;a=4;N=256;
t=0:1:(N-1);
sigma=0;mu=0;

for p=[1,2]
    figure;
    tiledlayout("vertical")
    if p==1
        sgtitle('Spectral estimation using Unwindowed Periodogram')
    else
        sgtitle('Spectral estimation using btse')
    end
    for a2=[1,0.1,0.01]
        y=a1*sin(f*2*pi*t)+a2*sin((f+(a/N))*2*pi*t);
        e=sigma*randn(1,length(y))+mu;
        y=y+e;
        M=N;L=1024;
        if p==1
            phi=periodogramse(y,ones(1,length(y)),L);
        else
            phi=btse(y,bartlett(length(y)),L);
        end
        nexttile
        fi=(0 : 1/L :(L-1)/(2*L));
        plot(fi,10*log10(phi(1:L/2)));
        title(sprintf('a2=%d',a2));
        xlabel('frequency')
        ylabel('\phi(f)')
    end
end