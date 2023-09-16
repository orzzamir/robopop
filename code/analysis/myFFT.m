function myFFT(y, Fs, tStart, tEnd, number,downSample)
y_d = downsample(y(tStart*Fs:tEnd*Fs), downSample)';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
windowWidth = int16(20);
halfWidth = windowWidth / 2;
gaussFilter = gausswin(100);
gaussFilter = gaussFilter / sum(gaussFilter); % Normalize.
%y_d = conv(y_d,gaussFilter);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

y_d = y_d - mean(y_d);

y_fft = fft(y_d);
L = length(y_fft);
f = Fs/downSample*(0:L/2-1)/L;

subplot(3,3,number);
plot(f,abs(y_fft(1:L/2)));
xlabel('f(Hz)')
ylabel('|Recording(f)|')
%title('FFT of a Recording');
xlim([0 1000]);
hold off;

%time_vec = (1:1:length(y_d))*downSample/Fs;
%subplot(4,2,2*number);
%plot(time_vec,y_d);
%xlim([0 (tEnd-tStart)]);
%ylim([0 1.2]);
%hold off;
title(['Time is  ' int2str(floor(tStart/60)) '  Min  ' int2str(mod(tStart,60)) '  Sec']); 

end
