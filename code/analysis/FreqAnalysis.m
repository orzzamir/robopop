 clear all;
 clc;
 [y , Fs] = audioread('myPopcorn2.3gp');
 %soundsc(y(230*Fs:end),Fs)
%%
 
 figure(1);
 
 myFFT(y, Fs, 103, 110, 1, 1);
 myFFT(y, Fs, 140, 147, 2, 1);
 myFFT(y, Fs, 180, 187, 3, 1);
 myFFT(y, Fs, 230, 237, 4, 1);
%%
    figure(1);
    graph = 0;
 for time = 168:8:234
    graph = graph + 1;
    if(graph == 10) graph = 1; end
    myFFT(y, Fs, time, time+8, graph,1);
    pause(1);
 end
