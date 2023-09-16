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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% 26 Pops in this recording! %%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% EnergyPeakDetection
%%%%Parameters
Pop_Width = 350;
Thresh_Factor = 0.7;
Big_Window = 4200;
Small_Window = 100;

%%%% Initializing
detect = zeros(1,length(pops_10))-2;
AvgEnergyVec = [];
NumOfDetections = 0;
%%%% Calculating Energy Peak 
i=1;
while i<length(pops_10)-Big_Window-1
    
    bWindow = pops_10(i:i+Big_Window);
    AvgEnergy = 1000*bWindow*bWindow'/Big_Window;

    j=Small_Window/2+1;
    while j<Big_Window-Small_Window/2-1
        sWindow = bWindow(j-Small_Window/2:j+Small_Window/2);
        InstEnergy = 1000*sWindow*sWindow'/Small_Window;
         if(InstEnergy>AvgEnergy*Thresh_Factor)
            detect(1,i+j)=1;
            NumOfDetections = NumOfDetections+1 ;
            j = j + Pop_Width;
         end
        j = j+1;
    end
    i=i+Big_Window;
    AvgEnergyVec = [AvgEnergyVec ones(1,Big_Window)*AvgEnergy];
end
%%%% Ploting

hold on
plot (detect, 'og');
plot (real_pops, 'or');
%plot(AvgEnergyVec/10,'-r');
hold off;

legend('Sound Recording','Detected Pops','Real Pops');
ylim([-1 1.2]);
xlabel('Sample');
ylabel('Amplitude');
title(['Num Of Detections is ' num2str(NumOfDetections)]);
hold off;