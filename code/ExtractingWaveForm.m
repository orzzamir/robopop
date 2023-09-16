clear all;
clc;
[y , Fs] = audioread('Popcorn.mp3');
pops = y(48*Fs:139*Fs);
%soundsc(pops);
figure(1)
subplot(2,1,1);
plot(pops(70*Fs:72*Fs));
subplot(2,1,2);
pops_10 = abs(downsample(pops(70*Fs:72*Fs), 10));
plot(pops_10);


%% Moving Average
%%%%Parameters
Pop_Width = 80;
Thresh_Factor = 5;


%%%% Initializing
detect = zeros(1,length(pops_10));
avg = zeros(1,length(pops_10));
avg(1) = pops_10(1);

%%%% Calculating Avg
i=1;
while i<length(pops_10)
    i=i+1;
    avg(i) = (avg(i-1)*(i-1)+pops_10(i))/i;
end

%%%% Determining Detections
i=0;
while i<length(pops_10)
    i=i+1;
    detect(i) = 0.2*(pops_10(i)>Thresh_Factor*avg(i));
    if(detect(i)==0.2) 
        i=i+Pop_Width;
    end
end
detect(find(detect==0))=-1;

%%%% Ploting
hold on
plot(avg,'r');
plot (detect, 'og');
hold off;
ylim([0 0.3]);
