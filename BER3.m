clc;
clear;
close;

numBits = 1e6;
EbNo_dB = 10;

txSymbols = randi([0 3], 1, numBits);
modulatedSymbols = pskmod(txSymbols, 4, pi/4);

EbNo = 10^(EbNo_dB/10);
noiseVar = 1 / (2 * EbNo);
noise = sqrt(noiseVar) * randn(size(modulatedSymbols));
rxSymbols = modulatedSymbols + noise;

fadeChannel = comm.RayleighChannel('SampleRate',1e6,'MaximumDopplerShift',30);
fadedSymbols = fadeChannel(rxSymbols.').';

demodulatedSymbols = pskdemod(fadedSymbols, 4, pi/4);

numErrors = sum(txSymbols ~= demodulatedSymbols);
ber = numErrors / numBits;

fprintf('Bit Error Rate (BER): %.4f\n', ber);
