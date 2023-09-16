function autocorrelation2(y, Fs, tStart, tEnd, number)
y_d = downsample(y(tStart*Fs:tEnd*Fs), 1)';
y_d = y_d-0.1;
y_d =(y_d<0).*0+(y_d>0).*y_d;
y_d = y_d - mean(y_d);
[autocor,lags] = xcorr(y_d,'coeff');

subplot(5,4,number);
plot(lags*10/Fs,autocor)
%xlabel('Lag (Secs)')
%ylabel('Autocorrelation')
xlim([-(tEnd-tStart) (tEnd-tStart)]);
ylim([-0.2 1.1]);
title('Autocorrelation');
hold on;

[pklg,lclg] = findpeaks(autocor, ...
'MinPeakDistance',0.2*Fs/10,'MinPeakheight',0.05);
long = mean(diff(lclg))/Fs;


plot(lags(lclg)*10/Fs,pklg+0.05,'vk');
hold off;

title(['Time is  ' int2str(floor(tStart/60)) '  Min  ' int2str(mod(tStart,60)) '  Sec']); 

end

%%[pksh,lcsh] = findpeaks(autocor);
%%short = mean(diff(lcsh))*10/Fs;

%%[pklg,lclg] = findpeaks(autocor, ...
%%'MinPeakDistance',ceil(short)*Fs/10,'MinPeakheight',0.3);
%%long = mean(diff(lclg))*10/Fs;

%plot(lags(lcsh)*10/Fs,pksh,'or', ...
%lags(lclg)*10/Fs,pklg+0.05,'vk');
%%hold off;