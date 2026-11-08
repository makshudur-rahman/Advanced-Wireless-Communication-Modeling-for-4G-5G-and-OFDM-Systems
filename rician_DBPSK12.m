clc; 
clear; 
close all;

T = 0:1:100;
A = 5;
B = 10;
Y = (A + B*T*1i).';

Chan = comm.RicianChannel('SampleRate',1e3,'MaximumDopplerShift',100,'KFactor',6);

Y_out = Chan(Y);

Y_dB = 20*log10(abs(Y_out) + eps);
plot(Y_dB); grid on;
xlabel('Sample'); ylabel('Magnitude (dB)');
title('Output of Rician Channel (Magnitude in dB)');
