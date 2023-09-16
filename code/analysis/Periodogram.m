 clear all;
 clc;
 [y , Fs] = audioread('BadPopcorn.3gp');
 %soundsc(y(230*Fs:end),Fs)

 %%
 figure(1);
 
 myPeriodogram(abs(y), Fs, 103, 109, 1, 1);
 myPeriodogram(abs(y), Fs, 140, 146, 2, 1);
 myPeriodogram(abs(y), Fs, 180, 186, 3, 1);
 myPeriodogram(abs(y), Fs, 231, 238, 4, 1);
%%
    figure(1);
    graph = 0;
 for time = 180:4:260
    graph = graph + 1;
    if(graph == 21) graph = 1; end
    myPeriodogram(abs(y), Fs, time, time+6, graph,1);
    pause(1);
 end
%%
figure(2)
time_vec = (1:1:length(y(220*Fs:260*Fs)))/Fs;
plot(time_vec,y(220*Fs:260*Fs));