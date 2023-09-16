clear all;
close all;
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


%%% ZamirBerendorf
%%%%Parameters
Pop_Width = 200;
Thresh_Factor = 3;
Window_Width = 1000;


%%%% Getting the Window for Convolution
Pulse = pops_10(22380:22650);
Pulse_Length = length(Pulse);

%%%% Initializing



%%%% Calculating Convolution
pops_conv = conv(pops_10, Pulse);


%%%% Ploting
hold on
%plot(Pulse);
%plot(pops_10, 'g');
plot(pops_conv/4,'g');
hold off;
%ylim([-0.3 0.3]);

%%%% Initializing
detect = zeros(1,length(pops_10))-1;
NumOfDetections = 0;
avg = [];
avg_std = [];

%%%% Calculating Convolution
i=Window_Width;
while i<length(pops_conv)-Window_Width/2-1
    Window = pops_conv(i-Window_Width/2:i+Window_Width/2);
    Avg = mean(Window);
    Std = std(Window);
    
    j=Pop_Width/2;
    while j<Window_Width-1
        if(Window(j)>Thresh_Factor*Std+Avg)
            detect(i-Window_Width/2+j)=1;
            j = j + Pop_Width;
            NumOfDetections = NumOfDetections + 1;
        end
        j = j+1;
    end
    avg = [avg ones(1,Window_Width)*Avg];
    avg_std = [avg_std ones(1,Window_Width)*(Avg+Thresh_Factor*Std)];
    i=i+Window_Width;
end
%%%% Ploting
hold on
plot(avg,'--r');
plot(avg_std/4,'-r');
plot (detect, 'og');
plot(real_pops, 'or');
hold off;

legend('Sound Recording','After Convolution','Detected Pops','Real Pops');
ylim([-0.3 1.2]);
xlabel('Sample');
ylabel('Amplitude');
title(['Num Of Detections is ' num2str(NumOfDetections)]);
hold off;
