function myPeriodogram(y, Fs, tStart, tEnd, number,downSample)
y_d = downsample(y(tStart*Fs:tEnd*Fs), downSample)';

y_d = y_d - mean(y_d);
y_d=y_d;

n = 0:length(y_d)-1;
x = cos(pi/4*n)+randn(size(n));

%hamming(length(x)),
[pxx,f] = periodogram(y_d,[],[],Fs/downSample);

figure(1);
subplot(5,4,number);
semilogy(f,pxx);
ax = gca;
ax.XLim = [0 100];

%xlabel('f(Hz)')
%ylabel('|Recording(f)|')
title([int2str(floor(tStart/60)) '  Min  ' int2str(mod(tStart,60)) '  Sec']);
hold off;

%figure(2);
%time_vec = (1:1:length(y_d))*downSample/Fs;
%subplot(5,4,number);
%plot(time_vec,y_d);
%xlim([0 (tEnd-tStart)]);
%ylim([0 1.2]);
%hold off;
%title([int2str(floor(tStart/60)) '  Min  ' int2str(mod(tStart,60)) '  Sec']); 

end
