clear all;
close all;
clc;

[y , Fs] = audioread('myPopcorn2.3gp');
%soundsc(y(200*Fs:206*Fs));
figure(1)
subplot(2,1,1);
plot(y(200*Fs:206*Fs));
subplot(2,1,2);
pops_10 = abs(downsample(y(200*Fs:206*Fs), 10)');
%plot(pops_10);
real_pops = real_pops_creator (length(pops_10));

%%% ZamirBerendorf
%%%%Parameters
Pop_Width = 150;
Thresh_Factor = 0.07;
windowWidth = int16(50);
noise_reduction_param = 3.5;

%%%% Getting Mean of Noise
Avg = mean(pops_10(1:1000));

%%%% Initializing
pops_noise_reduction = zeros(length(pops_10),1);
pops_noise_reduction = pops_10 - Avg*noise_reduction_param;
pops_noise_reduction = pops_noise_reduction.*(pops_noise_reduction>0);
pops_derivated = zeros(length(pops_noise_reduction),1);
NumOfDetections = 0;
derivative_vec = [];
pops_smooth =[];
%%%% Calculating derivative
i=0;
while i<length(pops_noise_reduction)-1
    i=i+1;
    pops_derivated(i) = pops_noise_reduction(i+1)-pops_noise_reduction(i);
   
end

%pops_smooth = smooth(pops_derivated,1);
% Construct blurring window.
halfWidth = windowWidth / 2;
gaussFilter = gausswin(5);
gaussFilter = gaussFilter / sum(gaussFilter); % Normalize.
pops_smooth = conv(pops_derivated,gaussFilter);

%%%% Calculating ZamirBerendorf
j=1;
detect = zeros(1,length(pops_smooth))-1;
while j<length(pops_smooth)
    j=j+1;
    derivative = pops_smooth(j)-pops_smooth(j-1);
    if(derivative<-Thresh_Factor)
        detect(j)=1;
        NumOfDetections = NumOfDetections+1;
        j = j + Pop_Width;
    end
end


%%%% Ploting
hold on
%plot(avg,'--r');
%plot(avg_std,'-r');
plot(pops_10, 'b');
plot(pops_smooth,'g');
plot(detect,'og');
plot (real_pops, 'or');

legend('Sound Recording','Smoothed Recording','Detected Pops','Real Pops');
ylim([-0.3 1.2]);
xlabel('Sample');
ylabel('Amplitude');
title(['Num Of Detections is ' num2str(NumOfDetections)]);
hold off;