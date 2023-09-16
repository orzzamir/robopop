function autocorrelation(y, Fs, tStart, tEnd, number, downSample)
y_d = downsample(y(tStart*Fs:tEnd*Fs), downSample)';
y_d = y_d-0.1;
y_d =(y_d<0).*0+(y_d>0).*y_d;
y_d = y_d - mean(y_d);
[autocor,lags] = xcorr(y_d,'coeff');

subplot(4,2,2*number-1);
plot(lags*downSample/Fs,autocor)
xlabel('Lag (Secs)')
ylabel('Autocorrelation')
xlim([-(tEnd-tStart) (tEnd-tStart)]);
ylim([-0.2 1.1]);
title('Autocorrelation');
hold on;

[pklg,lclg] = findpeaks(autocor, ...
'MinPeakDistance',0.5*Fs/downSample,'MinPeakheight',0.05);
long = mean(diff(lclg))/Fs;


plot(lags(lclg)*downSample/Fs,pklg+0.05,'vk');
hold off;


time_vec = (1:1:length(y_d))*downSample/Fs;
subplot(4,2,2*number);
plot(time_vec,y_d);
xlim([0 (tEnd-tStart)]);
ylim([0 1.2]);
hold off;
title(['Time is  ' int2str(floor(tStart/60)) '  Min  ' int2str(mod(tStart,60)) '  Sec']); 

end
