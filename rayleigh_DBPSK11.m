clc;
clear;
close all;
c = 1i*ones(200,1); 
chan = comm.RayleighChannel('SampleRate',1e3,'MaximumDopplerShift',100); 
y = chan(c); 
x = 20*log(abs(y)); 
p = plot(x);
