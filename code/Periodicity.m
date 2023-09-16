clear all;
clc;
[y , Fs] = audioread('myPopcorn2.3gp');
%soundsc(y(200*Fs:206*Fs));
figure(1)
%subplot(4,2,1);
%plot(y(200*Fs:208*Fs));
%subplot(4,1,2);
pops_10 = downsample(y(200*Fs:208*Fs), 10)';
%plot(pops_10);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% 26 Pops in this recording! %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Periodicity
%%%%Parameters
Pop_Width = 350;
Thresh_Factor = 0.7;
Big_Window = 4500;
Small_Window = 100;
Boundry = 1;

%%%% Initializing
detect = zeros(1,length(pops_10))-2;
AvgEnergyVec = [];
NumOfDetections = 0;
    
    pops_10 = pops_10 - mean(pops_10);
    [autocor,lags] = xcorr(pops_10,'coeff');
    subplot(4,2,1);
    plot(lags*8*10/Fs,autocor)
    xlabel('Lag ()')
    ylabel('Autocorrelation')
    xlim([-Boundry*4 Boundry*4]);
    ylim([-0.2 1]);
    hold off;
    
    subplot(4,2,2);
    plot(pops_10);
    hold off;
    
    pops_10 = pops_10 - mean(pops_10);
    [autocor,lags] = xcorr(pops_10(1*Fs/10:2*Fs/10),Fs/10,'coeff');
    subplot(4,2,3);
    plot(lags*10/Fs,autocor)
    xlabel('Lag ()')
    ylabel('Autocorrelation')
    xlim([-Boundry Boundry]);
    ylim([-0.2 1]);
    hold off;
    
    subplot(4,2,4);
    plot(pops_10(1*Fs/10:2*Fs/10));
    hold off;
    
   [autocor,lags] = xcorr(pops_10(4*Fs/10:5*Fs/10),Fs/10,'coeff');
    subplot(4,2,5);
    plot(lags*10/Fs,autocor)
    xlabel('Lag ()')
    ylabel('Autocorrelation')
   	xlim([-Boundry Boundry]);
    ylim([-0.2 1]);
    hold off;
    
    subplot(4,2,6);
    plot(pops_10(4*Fs/10:4.5*Fs/10));
    hold off;
    
    [autocor,lags] = xcorr(pops_10(7*Fs/10:8*Fs/10),Fs,'coeff');
    subplot(4,2,7);
    plot(lags*10/Fs,autocor)
    xlabel('Lag ()')
    ylabel('Autocorrelation')
    xlim([-Boundry Boundry]);
    ylim([-0.2 1]);
    hold off;
    
    subplot(4,2,8);
    plot(pops_10(7*Fs/10:8*Fs/10));
    hold off;
    
%%
subplot(4,2,7);
hold on;
[pksh,lcsh] = findpeaks(autocor);
short = mean(diff(lcsh))*10/Fs;

[pklg,lclg] = findpeaks(autocor, ...
'MinPeakDistance',ceil(short)*Fs/10,'MinPeakheight',0.3);
long = mean(diff(lclg))*10/Fs;

plot(lags(lcsh)*10/Fs,pksh,'or', ...
lags(lclg)*10/Fs,pklg+0.05,'vk');
hold off;
%%
%%%% Ploting

hold on
plot (detect, 'og');
%plot(AvgEnergyVec/3,'-r');
hold off;
ylim([-1 1]);
title(['Num Of Detections is ' num2str(NumOfDetections)]);