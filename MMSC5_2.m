clc;
clear;
close all;
M = 4;
N = 1000;
SNRdB = 10;
pilotSymbols = [1 -1 1 -1];

transmittedSymbols = randi([0 M-1], 1, N);
modulatedSymbols = qammod(transmittedSymbols, M);

channel = [0.8 -0.4 0.2 -0.1];
channelOutput = filter(channel, 1, modulatedSymbols);

SNR = 10^(SNRdB/10);
noiseVar = 1/(2*SNR);
noise = sqrt(noiseVar) * (randn(1, length(channelOutput)) + 1i * randn(1, length(channelOutput)));
receivedSignal = channelOutput + noise;

pilotIndices = randperm(N, length(pilotSymbols));
pilotSignal = receivedSignal(pilotIndices);
estimatedChannel = conv(pilotSignal, conj(pilotSymbols(end:-1:1)));
estimatedChannel = estimatedChannel(end-length(channel)+1:end);

equalizerCoefficients = conj(estimatedChannel) ./ (abs(estimatedChannel).^2 + noiseVar);
equalizedSymbols = filter(equalizerCoefficients, 1, receivedSignal);

demodulatedSymbols = qamdemod(equalizedSymbols, M);

ts = transmittedSymbols(:).';
ds = demodulatedSymbols(:).';
L = min(length(ts), length(ds));
bitErrors = sum(ts(1:L) ~= ds(1:L));
bitErrorRate = bitErrors / L;

disp(['Bit Error Rate: ' num2str(bitErrorRate)]);
