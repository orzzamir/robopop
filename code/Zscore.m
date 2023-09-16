clear all;
clc;

[y , Fs] = audioread('myPopcorn2.3gp');
%soundsc(y(200*Fs:206*Fs));
figure(1)
subplot(2,1,1);
plot(y(200*Fs:206*Fs));
subplot(2,1,2);
pops_10 = downsample(y(200*Fs:206*Fs), 10)';
plot(pops_10);
real_pops = real_pops_creator (length(pops_10));

%%% Zscore
%%%%Parameters
Pop_Width = 100;
Thresh_Factor = 3;
Window_Width = 500;

%%%% Initializing
detect = zeros(1,length(pops_10))-2;
avg = [];
avg_std = [];
NumOfDetections = 0;


%%%% Calculating Zscore
i=1;
while i<length(pops_10)-Window_Width
    
    Window = pops_10(i:i+Window_Width);
    Avg = mean(Window);
    Std = std(Window);
    j = Pop_Width/2;
    while j<Window_Width
        if (pops_10(i+j)>Thresh_Factor*Std+Avg)
            detect(i+j)=1;
            NumOfDetections = NumOfDetections+1 ;
            j = j + Pop_Width;
        end
        j = j + 1;
    end
    avg = [avg ones(1,Window_Width)*Avg];
    avg_std = [avg_std ones(1,Window_Width)*(Avg+Thresh_Factor*Std)];
    i=i+Window_Width;
end
%%%% Ploting
hold on
plot (detect, 'og');
plot (real_pops, 'or');
%plot(avg,'--r');
plot(avg_std,'-m');
legend('Sound Recording','Detected Pops','Real Pops','Threshold Line');
hold off;
ylim([-1 1.2]);
xlabel('Sample');
ylabel('Amplitude');
title(['Num Of Detections is ' num2str(NumOfDetections)]);

