clear all;
clc;

[y , Fs] = audioread('myPopcorn2.3gp');
%soundsc(y(200*Fs:206*Fs));
figure(1)
subplot(2,1,1);
plot(y(200*Fs:206*Fs));
subplot(2,1,2);
pops_10 = abs(downsample(y(200*Fs:206*Fs), 10)');
plot(pops_10);
real_pops = real_pops_creator (length(pops_10));

%%% Moving Average
%%%%Parameters
Pop_Width = 150;
Thresh_Factor = 5;
Window_Width = 4000;

%%%% Initializing
detect = zeros(1,length(pops_10));
avg = zeros(1,length(pops_10));
avg(1) = pops_10(1);
NumOfDetections = 0;
Avg = zeros(1,length(pops_10));

i=1;
while i<length(pops_10)-Window_Width
    Window = pops_10(i:i+Window_Width);
    Avg(i)=Window(1);
    j=1;
    while j<Window_Width
        Avg(i+j) = (Avg(i+j-1)*(j-1)+Window(j))/(j);
        j=j+1;
    end
    
    j=Pop_Width/2;
    while j<Window_Width
        j=j+1;
        detect(i+j-1) = 1*(Window(j)>Thresh_Factor*Avg(i+j-1));
        if(detect(i+j-1)==1) 
            j=j+Pop_Width;
            NumOfDetections = NumOfDetections +1;
        end
    end
     
    i=i+Window_Width;
end

detect(detect==0)=-1;

%%%% Ploting
hold on
plot (detect, 'og');
plot (real_pops, 'or');
plot(Thresh_Factor*Avg,'-m');
legend('Sound Recording','Detected Pops','Real Pops','Threshold Line');
hold off;
ylim([0 1.2]);
xlabel('Sample');
ylabel('Amplitude');
title(['Num Of Detections is ' num2str(NumOfDetections)]);

